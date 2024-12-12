import asyncio

# # Global variables to store session data
# session_emotions = {
#     'angry': 0,
#     'disgust': 0,
#     'fear': 0,
#     'happy': 0,
#     'sad': 0,
#     'surprise': 0,
#     'neutral': 0
# }
# session_active = False

# Create a queue for processing images, this is used incase the server isn't fast enough to process the images
processing_queue = asyncio.Queue()
is_processing = False