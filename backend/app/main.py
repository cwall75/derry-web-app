"""Main FastAPI application"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import JSONResponse
import os

from app.routes import victims

# Create FastAPI app
app = FastAPI(
    title="Derry Missing Persons Database",
    description="Missing persons database for Derry, Maine",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify exact origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mount static files for victim images
static_path = os.getenv('STATIC_PATH', '/app/static')
if os.path.exists(static_path):
    app.mount("/images", StaticFiles(directory=f"{static_path}/images"), name="images")

# Include routers
app.include_router(victims.router)


@app.get("/")
async def root():
    """Root endpoint"""
    return {
        "message": "Welcome to Derry Missing Persons Database API",
        "docs": "/docs",
        "version": "1.0.0"
    }


@app.get("/health")
async def health_check():
    """Health check endpoint"""
    try:
        from app.database import get_db_cursor
        with get_db_cursor() as cursor:
            cursor.execute("SELECT 1")
        return {"status": "healthy", "database": "connected"}
    except Exception as e:
        return JSONResponse(
            status_code=503,
            content={"status": "unhealthy", "error": str(e)}
        )


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
