from abc import ABC, abstractmethod
from datetime import datetime
from typing import Optional
from sqlalchemy import or_
from sqlalchemy.ext.asyncio import AsyncSession

from src.database.models import *
from src.database.repositories import GenericSqlRepository, GenericRepository
from src.database.exceptions import *
from src.user.exceptions import *


class IUnitIntervalRepository(GenericRepository[UnitInterval], ABC):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, UnitInterval)


class UnitIntervalRepository(
    GenericSqlRepository[UnitInterval], IUnitIntervalRepository
):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, UnitInterval)


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
            stmt = self._construct_statement_get_all(
                is_active=is_active, **filters
            ).where(
                or_(
                    Task.date_execute <= now,
                    now - Task.last_date_execute >= Task.duration,
                )
            )
        return await self._execute_statement_get_all(stmt)
