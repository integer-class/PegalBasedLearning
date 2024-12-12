from fastapi import APIRouter
from database import get_connection
from auth.dependencies import Depends, get_current_user

router = APIRouter()

@router.get("/interviewees")
def get_interviewees(current_user: str = Depends(get_current_user)):
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT * FROM interviewees WHERE is_interviewed = False")
        interviewees = cursor.fetchall()
        return {"status": "success", "data": interviewees}
    finally:
        connection.close()
