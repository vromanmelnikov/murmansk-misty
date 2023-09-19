from typing import List
from pydantic_settings import BaseSettings
from typesense import Client

from src.consts import *


# environment
class Settings(BaseSettings):
    TIMEOUT_SECS: int
    WORKER_URL: str
    NLTK_MODEL_NAME: str
    NODE_URLS: List[dict]
    API_KEY: str
    API_URL: str
    CORS_URL: List[str]

    class Config:
        env_file = ".env"


settings = Settings()


TypesenseCon = Client(
    {
        "api_key": settings.API_KEY,
        "nodes": settings.NODE_URLS,
        "connection_timeout_seconds": settings.TIMEOUT_SECS,
    }
)

EndpointsSchema = {
    "name": NAME_SCEMA_ENDPOINT,
    "fields": [
        {"name": "description", "type": "string"},
        {"name": "path", "type": "string"},
        {"name": "type_method", "type": "string"},
        {"name": "summary", "type": "string"},
        {
            "name": "embedding",
            "type": "float[]",
            "embed": {
                "from": ["description"],
                "model_config": {"model_name": settings.NLTK_MODEL_NAME},
            },
        },
    ],
}

ProductsSchema = {
    "name": NAME_SCEMA_PRODUCT,
    "enable_nested_fields": True,
    "fields": [
        {"name": "description", "type": "string"},
        {"name": ".*", "type": "auto"},
        {"name": ".*_facet", "type": "auto", "facet": True},
        {
            "name": "embedding",
            "type": "float[]",
            "embed": {
                "from": ["description"],
                "model_config": {"model_name": settings.NLTK_MODEL_NAME},
            },
        },
    ],
}
