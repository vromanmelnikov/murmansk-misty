from fastapi import Depends

from src.task.service import TaskService
from src.dependies import *
from src.services import *
from src.store.informants import *


def create_task_service(
    uow: IUnitOfWork = Depends(create_uow),
):
    return TaskService(uow)
