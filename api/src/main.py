from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI
from contextlib import asynccontextmanager
from fastapi_cache import FastAPICache
from fastapi_cache.backends.redis import RedisBackend


from src.config import *
from src.const import *
from src.routers import Routers
from src.utils import *
from src.exceptions import ServiceException


@asynccontextmanager
async def lifespan(app: FastAPI):
    FastAPICache.init(
        RedisBackend(RedisConnection),
        prefix=PREFIX_REDIS_CACHE,
        key_builder=custom_key_builder,
    )
    print("Запуск...")
    yield
    FastAPICache.reset()


app = FastAPI(title=BACKEND_NAME, lifespan=lifespan)
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_URL,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
app.add_exception_handler(ServiceException, handle_service_exception)


for router in Routers:
    app.include_router(router)
