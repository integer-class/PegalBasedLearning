import tensorflow as tf
from tensorflow.keras.layers import Conv2D
import os
import numpy as np
from routes.session_management import session_emotions
import cv2
from matplotlib import pyplot as plt


# Custom layer definition
class StandardizedConv2DWithOverride(Conv2D):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
    def call(self, inputs):
        return super().call(inputs)

# Load model
current_dir = os.path.dirname(os.path.abspath(__file__))
model_path = os.path.join(current_dir, "vito.h5")
model = tf.keras.models.load_model(
    model_path, custom_objects={'StandardizedConv2DWithOverride': StandardizedConv2DWithOverride}
)

def predict_emotion(image):

    # Check if the image is empty
    if image is None or image.size == 0:
        raise ValueError("Input image is empty or None.")
    
    
    # Check if the image is a batch (4D) and extract the first image if so
    if len(image.shape) == 4:
        image = image[0]  # Take the first image from the batch
    
    # Check the number of channels in the input image
    if len(image.shape) == 2:  # Grayscale image
        face_gray_rgb = cv2.cvtColor(image, cv2.COLOR_GRAY2RGB)
    elif len(image.shape) == 3 and image.shape[2] == 3:  # BGR image
        face_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        face_gray_rgb = cv2.cvtColor(face_gray, cv2.COLOR_GRAY2RGB)
    elif len(image.shape) == 3 and image.shape[2] == 4:  # RGBA image
        face_bgr = cv2.cvtColor(image, cv2.COLOR_RGBA2BGR)
        face_gray = cv2.cvtColor(face_bgr, cv2.COLOR_BGR2GRAY)
        face_gray_rgb = cv2.cvtColor(face_gray, cv2.COLOR_GRAY2RGB)
    else:
        raise ValueError(f"Invalid image format: expected 1 or 3 channels, got {image.shape}.")

    
    # Convert to grayscale (required for Haar cascade)
    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Load the pre-trained Haar cascade for face detection
    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

    # Detect faces in the image
    faces = face_cascade.detectMultiScale(gray_image, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    # Check if any faces are detected
    if len(faces) == 0:
        print("No faces detected!")
        return 'No face detected'
    else:
        print(f"Detected {len(faces)} face(s)")

        # Use the first detected face for preprocessing
        x, y, w, h = faces[0]
        
        # Extract the face
        face = image[y:y+h, x:x+w]

        # Convert the face to grayscale but keep RGB format
        face_gray = cv2.cvtColor(face, cv2.COLOR_BGR2GRAY)
        face_gray_rgb = cv2.cvtColor(face_gray, cv2.COLOR_GRAY2RGB)

        # Resize the face to 48x48 pixels
        resized_face = cv2.resize(face_gray_rgb, (48, 48))

        # Replace the original image with the preprocessed face
        image = resized_face  # Replace original image with preprocessed face
        print("Replaced the original image with the preprocessed face.")

        # Display the preprocessed image
        plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
        plt.title("Preprocessed Face (Grayscale RGB, 48x48)")
        plt.axis('off')


    # Preprocess the image for prediction
    image = np.expand_dims(image, axis=0)  # Add batch dimension (1, 48, 48, 3)
    image = image / 255.0  # Normalize to the same scale as your training data (0-1)

    # Make a prediction
    predictions = model.predict(image)
    class_names = ['angry', 'disgust', 'fear', 'happy', 'sad', 'surprise', 'neutral']

    # Output the predicted emotion and confidence
    predicted_class = class_names[np.argmax(predictions)]
    print(f"Predicted Emotion: {predicted_class}, Confidence: {float(np.max(predictions))}")

    # Increment the emotion count for session tracking
    session_emotions[predicted_class.lower()] += 1  # Increment the counter
    print(session_emotions)

    # Return the prediction result
    return {
        "emotion": predicted_class,
        "confidence": float(np.max(predictions))
    }
