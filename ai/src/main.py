from contextlib import asynccontextmanager
from fastapi import Depends, FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware

from src.schemas import ExecuteQueryData, FindQueryData
from src.config import *
from src.services import AIService
from src.dependies import create_ai_service
from src.utils import *


def init():
    global is_running
    res1 = methods_load(TypesenseCon)
    res2 = products_load(TypesenseCon)
    if res1 and res2:
        is_running = True


@asynccontextmanager
async def lifespan(app: FastAPI):
    init()
    print("Запуск...")
    yield


is_running = False
app = FastAPI(lifespan=lifespan)
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_URL,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.post("/find_endpoints")
async def find_endpoints(
    q: FindQueryData,
    limit=Query(default=COUNT_ITEMS),
    ai_service: AIService = Depends(create_ai_service),
):
    return await ai_service.find_endpoints(q, limit)


@app.post("/parse_query")
async def parse_query(
    q: ExecuteQueryData, ai_service: AIService = Depends(create_ai_service)
):
    return await ai_service.parse_query(q)


@app.post("/find_products")
async def find_products(
    q: FindQueryData,
    limit=Query(default=COUNT_ITEMS),
    ai_service: AIService = Depends(create_ai_service),
):
    return await ai_service.find_products(q, limit)
