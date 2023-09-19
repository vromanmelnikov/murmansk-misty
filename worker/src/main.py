from fastapi import Depends, FastAPI

from src.dependies import create_worker_service
from src.services import WorkerService


app = FastAPI()


@app.get("/tasks/handle", tags=["Tasks"])
async def get_all_tasks(
    task_service: WorkerService = Depends(create_worker_service),
):
    return await task_service.handle_tasks()
