from fastapi import APIRouter, Depends, HTTPException, status
from mysql.connector import Error
from datetime import datetime
from database import get_connection
from auth.dependencies import oauth2_scheme, get_current_user, get_db
from sqlalchemy.orm import Session
from users.models import User

router = APIRouter()
session_emotions = {key: 0 for key in ['angry', 'disgust', 'fear', 'happy', 'sad', 'surprise', 'neutral']}
session_active = False


@router.post("/start-session")
async def start_session(
    db: Session = Depends(get_db),
    token: str = Depends(oauth2_scheme),
):
    # Ensure the user is authenticated
    user = get_current_user(db, token)

    # Add optional authorization if needed, e.g., check user role
    if not user:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Insufficient permissions to start a session",
        )

    # Reset session emotions and start session
    global session_active
    session_emotions.update({
        'sad': 0, 'disgust': 0, 'surprise': 0,
        'angry': 0, 'fear': 0, 'happy': 0, 'neutral': 0
    })
    session_active = True
    return {"status": "success", "message": "Session started"}


@router.post("/end-session/{interviewee_id}")
async def end_session(
    interviewee_id: int,
    current_user: User = Depends(get_current_user),
):

    if not current_user:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Insufficient permissions to start a session",
        )
    
    interviewer_id = current_user.id
    global session_active
    if not session_active:
        return {"status": "error", "message": "No active session"}
    #delete debug
    print(session_emotions['angry'], session_emotions['disgust'], session_emotions['fear'], session_emotions['happy'], session_emotions['neutral'], session_emotions['sad'], session_emotions['surprise'])
    try:
        connection = get_connection()
        
        if connection.is_connected():
            cursor = connection.cursor()
            
            # Insert emotion counts into database
            query = """
            INSERT INTO expressions 
            (interviewee_id, interviewer_id, sad, disgust, surprise, angry, fear, happy, neutral, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            current_time = datetime.now()
            values = (
                interviewee_id,
                interviewer_id,
                session_emotions['sad'],
                session_emotions['disgust'],
                session_emotions['surprise'],
                session_emotions['angry'],
                session_emotions['fear'],
                session_emotions['happy'],
                session_emotions['neutral'],
                current_time
            )
            #delete debug
            print(query, values)
            cursor.execute(query, values)

            query2 = """
            UPDATE `interviewees` 
            SET `is_interviewed` = '1' 
            WHERE `interviewees`.`id` = %s;
            """
            cursor.execute(query2,(interviewee_id,))
            connection.commit()
            
            cursor.close()
            connection.close()
            
            session_active = False
            #delete debug
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