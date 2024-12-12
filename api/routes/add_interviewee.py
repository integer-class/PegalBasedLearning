from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from database import get_connection
from auth.dependencies import get_current_user

router = APIRouter()

# Pydantic model for input validation
class IntervieweeCreate(BaseModel):
    name: str
    gender: str
    email: str

@router.post("/add-interviewee")
def add_interviewee(interviewee: IntervieweeCreate):
    try:
        connection = get_connection()
        with connection.cursor() as cursor:
            query = """
                INSERT INTO interviewees (name, gender, email, is_interviewed, created_at, updated_at)
                VALUES (%s, %s, %s, %s, NOW(), NOW())
            """
            cursor.execute(query, (interviewee.name, interviewee.gender, interviewee.email, False))
            connection.commit()
            return {"status": "success", "message": "Interviewee added successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error adding interviewee: {str(e)}")
    finally:
        connection.close()
