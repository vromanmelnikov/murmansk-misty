from abc import ABC, abstractmethod
from typing import Optional
from sqlalchemy.ext.asyncio import AsyncSession

from src.database.models import *
from src.database.repositories import GenericSqlRepository, GenericRepository


class IFileRepository(GenericRepository[FileModel], ABC):
    @abstractmethod
    async def get_by_id(self, token: int) -> Optional[FileModel]:
        raise NotImplementedError()


class FileRepository(GenericSqlRepository[FileModel], IFileRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, FileModel)

    async def get_by_id(self, token: int) -> Optional[FileModel]:
        stmt = self._construct_statement_get_one(token=token)
        return await self._execute_statement_get_by_id(stmt, token)
