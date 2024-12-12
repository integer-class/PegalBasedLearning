from pydantic import BaseModel

class UserBase(BaseModel):
    username: str

class UserCreate(UserBase):
    email: str
    password: str

class UserResponse(UserBase):
    id: int

    class Config:
        orm_mode = True