from abc import ABC, abstractmethod
from datetime import datetime
from typing import Optional
from sqlalchemy import Date, cast, or_
from sqlalchemy.ext.asyncio import AsyncSession

from src.database.models import *
from src.database.repositories import GenericSqlRepository, GenericRepository


class INoteRepository(GenericRepository[NoteModel], ABC):
    pass


class NoteRepository(GenericSqlRepository[NoteModel], INoteRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, NoteModel)


class ITaskRepository(GenericRepository[Task], ABC):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Task)

    @abstractmethod
    async def get_all(
        self, is_active: bool | None = None, is_consideration_time: bool | None = None
    ) -> Optional[Task]:
        raise NotImplementedError()


class TaskRepository(GenericSqlRepository[Task], ITaskRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Task)

    async def get_all(
        self, is_active: bool = None, is_consideration_time: bool = None, **filters
    ) -> Optional[Task]:
        if is_active is None and is_consideration_time is None:
            stmt = self._construct_statement_get_all(**filters)
        else:
            now = datetime.utcnow()
            stmt = self._construct_statement_get_all(is_active=is_active).where(
                or_(
                    now >= Task.date_execute,
                    now - Task.last_date_execute >= Task.duration,
                )
            )
        return await self._execute_statement_get_all(stmt)
