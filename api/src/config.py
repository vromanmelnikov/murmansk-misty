from typing import List
from fastapi.security import OAuth2PasswordBearer
from pydantic_settings import BaseSettings
from redis import asyncio as aioredis
from celery import Celery

from src.authentication.constants import *
from src.const import *


# environment
class Settings(BaseSettings):
    POSTGRES_USER: str
    POSTGRES_PASSWORD: str
    POSTGRES_DB: str
    HOST: str
    PORT: str

    SECRET_STRING: str
    ALGORITHM: str

    CORS_URL: List[str]
    URL_MAILER: str
    URL_FRONTEND: str

    REDIS_HOST: str
    REDIS_PORT: str

    FILE_SHARING_URL: str
    WORKER_URL: str

    class Config:
        env_file = ".env"


settings = Settings()

# authorization
OAuth2Scheme = OAuth2PasswordBearer(tokenUrl=f"{AUTH}{PATH_SIGNIN}")

# connections
REDIS_URL = f"redis://{settings.REDIS_HOST}:{settings.REDIS_PORT}"
RedisConnection = aioredis.from_url(REDIS_URL, encoding="utf8")
CeleryConnection = Celery(MAIN_QUEUE_NAME_CELERY, broker=REDIS_URL)
