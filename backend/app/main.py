from __future__ import annotations

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.routes import location, meta
from app.config import get_settings

settings = get_settings()

app = FastAPI(title="Location Info Explorer API", version="0.1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[settings.cors_origins] if settings.cors_origins != "*" else ["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(location.router)
app.include_router(meta.router)


@app.get("/health")
async def health() -> dict:
    return {"status": "ok"}
