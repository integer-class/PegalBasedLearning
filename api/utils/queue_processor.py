import cv2
import os
import asyncio
from models.emotion_model import predict_emotion

async def process_queue(queue, session_emotions, session_active):
    while True:
        if not queue.empty():
            image_data = await queue.get()

            # Debugging: Check the path
            print(f"Attempting to read image from path: {image_data['path']}")

            # Validate file existence
            if not os.path.exists(image_data["path"]):
                raise FileNotFoundError(f"File not found: {image_data['path']}")

            # Read the image
            image = cv2.imread(image_data["path"])

            # Validate the loaded image
            if image is None or image.size == 0:
                raise ValueError(f"Failed to load image or image is empty: {image_data['path']}")

            # Perform emotion prediction
            result = predict_emotion(image)

            if session_active:
                session_emotions[result["emotion"]] += 1

            # Remove the original file
            os.remove(image_data["path"])

            # Complete the future with the result
            image_data["future"].set_result(result)

        await asyncio.sleep(0.1)
