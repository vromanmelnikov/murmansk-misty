from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache

from src.task.consts import RESOURCE_TASK
from src.task.dependies import create_task_service
from src.task.schemas import TaskCreateSchema, TaskUpdateSchema
from src.task.service import TaskService
from src.authorization.authorization import AuthorizationService
from src.config import OAuth2Scheme
from src.authorization.dependies import *
from src.const import EXPIRES_HOUR_CACHE_ON_SECONDS, METHOD_ADD, METHOD_GET_BY_ID


router = APIRouter(prefix="/tasks", tags=["Tasks"])


@router.post(
    "/",
    summary="Добавление задачи",
    description="Добавление задачи, быстрые действия, без участия пользователя выполенение действий",
)
async def add_tasks(
    task: TaskCreateSchema,
    token: str = Depends(OAuth2Scheme),
    task_service: TaskService = Depends(create_task_service),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TASK), token
    )
    return await task_service.add_tasks(task, subject_data)


@router.put(
    "/",
    summary="Обновление задачи",
    description="Изменение, обновление задачи, активировать, изменить период, дату. быстрых действия, без участия пользователя выполенение действий",
)
async def put_tasks(
    task: TaskUpdateSchema,
    token: str = Depends(OAuth2Scheme),
    task_service: TaskService = Depends(create_task_service),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TASK), token
    )
    return await task_service.put_tasks(task, subject_data)


@router.get(
    "/units/all",
    summary="Получение шаблонных периодов выполнения задачи",
    description="Получение шаблонных периодов выполения задачи. Список периодов, единиц измерения, шаблон. Быстрых действия, без участия пользователя выполенение действий",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_units(
    task_service: TaskService = Depends(create_task_service),
):
    return await task_service.get_unit()


@router.get(
    "/all/my",
    summary="Получение моих задач",
    description="Получение моих, пользователя задач. Быстрых действия, без участия пользователя выполенение действий",
)
async def get_all_tasks(
    token: str = Depends(OAuth2Scheme),
    task_service: TaskService = Depends(create_task_service),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_GET_BY_ID, ResourceData(name=RESOURCE_TASK), token
    )
    return await task_service.get_tasks(subject_data)


@router.get(
    "/templates/all",
    summary="Получение примеров задач",
    description="Получение список примеров, шаблонов быстрых действий без участия пользователя выполенение действий",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_all_tasks(
    task_service: TaskService = Depends(create_task_service),
):
    return await task_service.get_tasks_template()
