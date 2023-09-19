from src.authentication.router import router as authentication_router
from src.user.router import router as user_router
from src.tag.router import router as tag_router
from src.store.router import router as store_router
from src.file_operator.router import router as file_operator_router
from src.task.router import router as ai_router

Routers = [
    authentication_router,
    tag_router,
    file_operator_router,
    user_router,
    store_router,
    ai_router,
]
