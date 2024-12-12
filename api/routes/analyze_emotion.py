from fastapi import APIRouter, File, UploadFile, Depends, HTTPException, status
from utils.file_utils import save_uploaded_file
from utils.queue_processor import process_queue
from users.models import User
from auth.dependencies import get_current_user
import asyncio

router = APIRouter()
queue = asyncio.Queue()
session_emotions = {key: 0 for key in ['angry', 'disgust', 'fear', 'happy', 'sad', 'surprise', 'neutral']}
session_active = False

# @router.post("/analyze-emotion")
# async def analyze_emotion(file: UploadFile = File(...)):
#     save_path = save_uploaded_file(await file.read())
#     future = asyncio.Future()
#     await queue.put({"path": save_path, "future": future})
#     asyncio.create_task(process_queue(queue, session_emotions, session_active))
#     return await future
@router.post("/analyze-emotion")
async def analyze_emotion(
    file: UploadFile = File(...), 
    current_user: User = Depends(get_current_user)  # Ensure the user is authenticated
):
    if not current_user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authentication required",
        )
    
    save_path = save_uploaded_file(await file.read())
    future = asyncio.Future()
    await queue.put({"path": save_path, "future": future})
    asyncio.create_task(process_queue(queue, session_emotions, session_active))
    return await future