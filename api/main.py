from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import analyze_emotion, session_management, interviewees, results

from auth.routes import router as auth_router
from users.routes import router as users_router

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)


# Include routers from different modules
app.include_router(analyze_emotion.router)
app.include_router(session_management.router)
app.include_router(interviewees.router)
app.include_router(results.router)
app.include_router(auth_router, prefix="/auth", tags=["auth"])
app.include_router(users_router, prefix="/users", tags=["users"])
