from copy import copy
from datetime import datetime

from src.database.models.others.note import NoteModel
from src.api_handlers import EndpointHandlerBase
from src.database.models.others.tasks import Task
from src.unit_of_work import IUnitOfWork


class NoteService:
    async def send_note(self, note: str, user_id: int, uow: IUnitOfWork):
        n = NoteModel(text=note, user_id=user_id)
        await uow.notes.add(n)


class WorkerService:
    def __init__(
        self,
        uow: IUnitOfWork,
        note_service: NoteService,
        handlers: dict[str, EndpointHandlerBase],
    ):
        self.__uow = uow
        self.__note_service = note_service
        self.__handlers = handlers

    async def handle_tasks(self):
        async with self.__uow:
            tasks = await self.__uow.tasks.get_all(
                is_active=True, is_consideration_time=True
            )
            for task in tasks:
                handlers = self.__handlers.get(task.path, None)
                if handlers:
                    res, user_id = await handlers.execute(task)
                    await self.__note_service.send_note(res, user_id, self.__uow)
                    await self.__proccess_task(task, self.__uow)
            await self.__uow.commit()
        return {"status": "ok"}

    async def __proccess_task(self, task: Task, uow: IUnitOfWork):
        details = copy(task.details)
        if "current_count" in details:
            details["current_count"] += 1
            if details["current_count"] >= details["count"]:
                task.is_active = False
        task.details = details
        task.last_date_execute = datetime.utcnow()
        await uow.tasks.update(task)
