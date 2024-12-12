from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from jose import JWTError
from .dependencies import get_db, authenticate_user, create_access_token, get_user, get_email, oauth2_scheme, revoked_tokens, get_current_user
from .models import Token
from .schemas import UserCreate, UserResponse
from users.models import User
from .utils import get_password_hash  # Import get_password_hash here

router = APIRouter()

@router.post("/token", response_model=Token)
def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = authenticate_user(db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = create_access_token(data={"sub": user.username})
    return {"access_token": access_token, "token_type": "bearer"}

@router.post("/register", response_model=UserResponse)
def signup(user: UserCreate, db: Session = Depends(get_db)):
    db_user = get_user(db, username=user.username)
    if db_user:
        raise HTTPException(status_code=400, detail="username already registered")
    db_email = get_email(db, email=user.email)
    if db_email:
        raise HTTPException(status_code=400, detail="email already registered")
    hashed_password = get_password_hash(user.password)
    db_user = User(username=user.username, email=user.email, hashed_password=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

@router.post("/logout")
def logout(token: str = Depends(oauth2_scheme)):
    try:
        revoked_tokens.add(token)
        return {"message": "Successfully logged out"}
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token",
            headers={"WWW-Authenticate": "Bearer"},
        )

@router.put("/edit-email")
def edit_email(new_email: str, password: str,db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    user = get_current_user(db, token)  # Get the current user based on the token
    db_user = get_email(db, email=new_email)
    if not authenticate_user(db, user.username, password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Current password is incorrect",
        )
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    user.email = new_email  # Update email
    db.commit()
    return {"message": "Email updated successfully"}

@router.put("/edit-password")
def edit_password(current_password: str, new_password: str, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    user = get_current_user(db, token)  # Get the current user based on the token
    if not authenticate_user(db, user.username, current_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Current password is incorrect",
        )
    user.hashed_password = get_password_hash(new_password)  # Hash and update the password
    db.commit()
    return {"message": "Password updated successfully"}
