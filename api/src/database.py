from sqlalchemy.orm import sessionmaker
from sqlalchemy.engine import create_engine
from sqlalchemy.ext.asyncio import AsyncSession, AsyncEngine

from src.config import settings

db_url = f"postgresql+asyncpg://{settings.POSTGRES_USER}:{settings.POSTGRES_PASSWORD}@{settings.HOST}:{settings.PORT}/{settings.POSTGRES_DB}"
engine = AsyncEngine(create_engine(db_url, future=True))
AsyncSessionMaker = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)


async def get_async_session():
    async with AsyncSessionMaker() as session:
        yield session
