import os
from datetime import datetime

def save_uploaded_file(file):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    save_path = f"./uploaded_files/frame_{timestamp}.jpg"
    os.makedirs(os.path.dirname(save_path), exist_ok=True)
    with open(save_path, "wb") as f:
        f.write(file)
    return save_path
