from fastapi import APIRouter
from database import get_connection
from auth.dependencies import Depends, get_current_user
from users.models import User

router = APIRouter()

@router.get("/results")
def get_results(current_user: User = Depends(get_current_user)):
    try:
        user_id = current_user.id
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        query = """
        SELECT i.name, e.sad, e.disgust, e.surprise, e.angry, e.fear, e.happy, e.neutral, e.created_at AS date
        FROM interviewees AS i
        JOIN expressions AS e ON i.id = e.interviewee_id
        WHERE e.id = (SELECT MAX(id) 
        FROM expressions 
        WHERE interviewee_id = e.interviewee_id
        AND interviewer_id = %s
        );
        """
        cursor.execute(query, (user_id,))
        results = cursor.fetchall()
        return {"status": "success", "data": results}
    finally:
        connection.close()
