from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware

import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
import numpy as np

import tensorflow as tf
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.preprocessing.image import img_to_array, load_img
import numpy as np

import requests
import os

import mysql.connector
from mysql.connector import Error

import asyncio
from collections import deque
import time
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

items = []

# Define the custom layer, `StandardizedConv2DWithOverride`
# This is a placeholder implementation; replace it with the actual code if available
class StandardizedConv2DWithOverride(Conv2D):
    def __init__(self, *args, **kwargs):
        super(StandardizedConv2DWithOverride, self).__init__(*args, **kwargs)

    def call(self, inputs):
        # Placeholder for any custom processing
        return super(StandardizedConv2DWithOverride, self).call(inputs)

# Get the absolute path to the model file
current_dir = os.path.dirname(os.path.abspath(__file__))
model_path = os.path.join(current_dir, "modelv2.hdf5")

# Load the model with absolute path
model = tf.keras.models.load_model(model_path, custom_objects={'StandardizedConv2DWithOverride': StandardizedConv2DWithOverride})
print(f"Model loaded successfully from: {model_path}")

# Create a queue for processing images
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

@app.get("/")
def root():
    return 'this is a place holder'

@app.post("/upload/")
async def upload_file(file: UploadFile = File(...)):
    try:
        save_path = "./uploaded_files/image.jpg"

        os.makedirs(os.path.dirname(save_path), exist_ok=True)

        contents = await file.read()
        with open(save_path, "wb") as f:
            f.write(contents)
        
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=400)

    # Path to the image in the 'uploaded_files' folder
    image_path = './uploaded_files/image.jpg'  # Update the image name if needed

    # Ensure the file exists in the 'uploaded_files' folder
    if os.path.exists(image_path):
    # Load the image as RGB to match the model’s expected input shape
        image = load_img(image_path, target_size=(48, 48), color_mode="rgb")
        
        # Convert image to array and add batch dimension
        image = img_to_array(image)
        image = np.expand_dims(image, axis=0)  # Add batch dimension
        image /= 255.0  # Normalize the image

        # Run the model prediction
        predictions = model.predict(image)

        # Decode the prediction (e.g., emotion labels in a classification model)
        # Assuming a softmax output with labels
        class_names = ['Angry', 'Disgust', 'Fear', 'Happy', 'Sad', 'Surprise', 'Neutral']  # Adjust to your classes
        predicted_class = class_names[np.argmax(predictions)]
        confidence = np.max(predictions)

        print(f"Predicted emotion: {predicted_class} with confidence {confidence:.2f}")
    else:
        print(f"Image not found at {image_path}. Please check the file path.")


@app.post("/model")
def run():
    # Path to the image in the 'uploaded_files' folder
    image_path = './uploaded_files/image.jpg'  # Update the image name if needed

    # Ensure the file exists in the 'uploaded_files' folder
    if os.path.exists(image_path):
    # Load the image as RGB to match the model’s expected input shape
        image = load_img(image_path, target_size=(48, 48), color_mode="rgb")
        
        # Convert image to array and add batch dimension
        image = img_to_array(image)
        image = np.expand_dims(image, axis=0)  # Add batch dimension
        image /= 255.0  # Normalize the image

        # Run the model prediction
        predictions = model.predict(image)

        # Decode the prediction (e.g., emotion labels in a classification model)
        # Assuming a softmax output with labels
        class_names = ['Angry', 'Disgust', 'Fear', 'Happy', 'Sad', 'Surprise', 'Neutral']  # Adjust to your classes
        predicted_class = class_names[np.argmax(predictions)]
        confidence = np.max(predictions)

        print(f"Predicted emotion: {predicted_class} with confidence {confidence:.2f}")
    else:
        print(f"Image not found at {image_path}. Please check the file path.")

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

# Add these global variables near the top of the file
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