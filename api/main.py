from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware

import tensorflow as tf
import numpy as np

import tensorflow as tf
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.preprocessing.image import img_to_array, load_img
import numpy as np

import os

import mysql.connector
from mysql.connector import Error

import asyncio
from datetime import datetime

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# Global variables to store session data
session_emotions = {
    'angry': 0,
    'disgust': 0,
    'fear': 0,
    'happy': 0,
    'sad': 0,
    'surprise': 0,
    'neutral': 0
}
session_active = False

# Import the model
# Define the custom layer, `StandardizedConv2DWithOverride`
class StandardizedConv2DWithOverride(Conv2D):
    def __init__(self, *args, **kwargs):
        super(StandardizedConv2DWithOverride, self).__init__(*args, **kwargs)
    def call(self, inputs):
        # Placeholder for any custom processing
        return super(StandardizedConv2DWithOverride, self).call(inputs)
# Get the absolute path to the model file
current_dir = os.path.dirname(os.path.abspath(__file__))
model_path = os.path.join(current_dir, "modelv.hdf5")
# Load the model with absolute path
model = tf.keras.models.load_model(model_path, custom_objects={'StandardizedConv2DWithOverride': StandardizedConv2DWithOverride})
print(f"Model loaded successfully from: {model_path}")


# Create a queue for processing images, this is used incase the server isn't fast enough to process the images
processing_queue = asyncio.Queue()
is_processing = False

async def process_image_from_queue():
    global is_processing, session_emotions
    while True:
        try:
            if not processing_queue.empty():
                is_processing = True
                image_data = await processing_queue.get()
                
                # Process the image
                image = load_img(image_data['path'], target_size=(48, 48), color_mode="rgb")
                image = img_to_array(image)
                image = np.expand_dims(image, axis=0)
                image /= 255.0
                
                # Get predictions
                predictions = model.predict(image)
                class_names = ['angry', 'disgust', 'fear', 'happy', 'sad', 'surprise', 'neutral']  # Changed to lowercase
                predicted_class = class_names[np.argmax(predictions)]
                confidence = float(np.max(predictions))
                
                # Update session emotions if session is active
                if session_active:
                    session_emotions[predicted_class.lower()] += 1  # Increment the counter
                    print(f"Updated emotion count for {predicted_class}: {session_emotions[predicted_class.lower()]}")
                
                # Clean up - remove the temporary file
                os.remove(image_data['path'])
                print(f"✓ Processed and cleaned up {image_data['path']}")
                
                # Store or return results as needed
                image_data['result_future'].set_result({
                    "status": "success",
                    "emotion": predicted_class,
                    "confidence": confidence,
                    "current_session_counts": session_emotions if session_active else None
                })
            
            is_processing = False
            await asyncio.sleep(0.1)
            
        except Exception as e:
            print(f"Error in queue processing: {str(e)}")
            is_processing = False
            await asyncio.sleep(0.1)

@app.post("/analyze-emotion")
async def analyze_emotion(file: UploadFile = File(...)):
    try:
        # Create a unique filename using timestamp
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        save_path = f"./uploaded_files/frame_{timestamp}.jpg"
        
        print(f"\n[{timestamp}] Processing new image...")
        
        # Ensure directory exists
        os.makedirs(os.path.dirname(save_path), exist_ok=True)
        
        # Save the uploaded file
        contents = await file.read()
        with open(save_path, "wb") as f:
            f.write(contents)
        print(f"✓ Image saved temporarily as: {save_path}")
        
        # Create a future to store the result
        result_future = asyncio.Future()
        
        # Add to queue
        await processing_queue.put({
            'path': save_path,
            'result_future': result_future
        })
        
        # Start processing if not already running
        if not is_processing:
            asyncio.create_task(process_image_from_queue())
        
        # Wait for the result
        result = await result_future
        return result
        
    except Exception as e:
        print(f"\nError occurred: {str(e)}")
        # Clean up file in case of error
        if os.path.exists(save_path):
            os.remove(save_path)
        return {
            "status": "error",
            "message": str(e)
        }

@app.post("/start-session/{interviewee_id}")
async def start_session(interviewee_id: int):
    global session_active, session_emotions
    session_emotions = {
        'angry': 0,
        'disgust': 0,
        'fear': 0,
        'happy': 0,
        'sad': 0,
        'surprise': 0,
        'neutral': 0
    }
    session_active = True
    return {"status": "success", "message": "Session started"}

@app.post("/end-session/{interviewee_id}")
async def end_session(interviewee_id: int):
    global session_active
    if not session_active:
        return {"status": "error", "message": "No active session"}
    
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="expriview"
        )
        
        if connection.is_connected():
            cursor = connection.cursor()
            
            # Insert emotion counts into database
            query = """
            INSERT INTO expressions 
            (interviewee_id, sad, disgust, surprise, angry, fear, happy, neutral, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            current_time = datetime.now()
            values = (
                interviewee_id,
                session_emotions['sad'],
                session_emotions['disgust'],
                session_emotions['surprise'],
                session_emotions['angry'],
                session_emotions['fear'],
                session_emotions['happy'],
                session_emotions['neutral'],
                current_time
            )
            
            cursor.execute(query, values)
            connection.commit()
            
            cursor.close()
            connection.close()
            
            session_active = False
            return {
                "status": "success",
                "message": "Session ended and data saved",
                "emotion_counts": session_emotions
            }
            
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if 'connection' in locals() and connection.is_connected():
            connection.close()
            
# This is used to get all the data from the interviewees table, to ouputted into the start interview page
@app.get("/interviewees")
def get_interviewees():
    try:
        # Establish connection to MySQL database
        connection = mysql.connector.connect(
            host="localhost",
            user="root", 
            password="",
            database="expriview"
        )

        if connection.is_connected():
            cursor = connection.cursor(dictionary=True)
            
            # Execute query to get all interviewees
            cursor.execute("SELECT * FROM interviewees")
            
            # Fetch all records
            interviewees = cursor.fetchall()
            
            # Close cursor and connection
            cursor.close()
            connection.close()
            
            return {"status": "success", "data": interviewees}

    except Error as e:
        return {"status": "error", "message": str(e)}

    finally:
        if 'connection' in locals() and connection.is_connected():
            connection.close()

# This is used to get all the results, which is the last expression of each interviewee, to be outputted into the results page
@app.get("/results")
def get_results():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="expriview"
        )

        if connection.is_connected():
            cursor = connection.cursor(dictionary=True)
            
            query = """
            SELECT 
                i.name, 
                e.sad, 
                e.disgust, 
                e.surprise, 
                e.surprise, 
                e.angry, 
                e.fear, 
                e.happy, 
                e.neutral,
                e.created_at as date
            FROM interviewees AS i 
            JOIN expressions AS e 
            ON i.id = e.interviewee_id 
            WHERE e.id = ( SELECT MAX(id) FROM expressions AS e2 WHERE e2.interviewee_id = e.interviewee_id );
            """
            
            cursor.execute(query)
            results = cursor.fetchall()
            
            # Format the data
            formatted_results = [{
                'name': result['name'] or 'Unknown',
                'date': result['date'].strftime('%Y-%m-%d %H:%M:%S'),
                'happy': int(result['happy'] or 0),
                'disgust': int(result['disgust'] or 0),
                'angry': int(result['angry'] or 0),
                'fear': int(result['fear'] or 0),
                'neutral': int(result['neutral'] or 0),
                'sad': int(result['sad'] or 0),
                'surprise': int(result['surprise'] or 0)
            } for result in results]
            
            cursor.close()
            connection.close()
            
            return {"status": "success", "data": formatted_results}

    except Error as e:
        return {"status": "error", "message": str(e)}