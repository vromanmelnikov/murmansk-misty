from abc import ABC, abstractmethod
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List, Optional
from sqlalchemy.orm import selectinload
from sqlalchemy import Boolean, select, and_

from src.database.models import *
from src.database.repositories import GenericSqlRepository, GenericRepository
from src.database.exceptions import *
from src.user.exceptions import *


class ITagGroupRepository(GenericRepository[TagGroup], ABC):
    pass


class TagGroupRepository(GenericSqlRepository[TagGroup], ITagGroupRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, TagGroup)


class IStoreTagLinkRepository(GenericRepository[StoreTagLink], ABC):
    @abstractmethod
    async def get_by_id(
        self,
        store_id: int,
        tag_id: int,
    ) -> StoreTagLink:
        raise NotImplementedError()

    @abstractmethod
    async def delete(
        self,
        store_id: int,
        tag_id: int,
    ):
        raise NotImplementedError()


class StoreTagLinkRepository(
    GenericSqlRepository[StoreTagLink], IStoreTagLinkRepository
):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, StoreTagLink)

    async def get_by_id(
        self,
        store_id: int,
        tag_id: int,
    ) -> StoreTagLink:
        if tag_id:
            stmt = select(StoreTagLink).filter(
                StoreTagLink.store_id == store_id, StoreTagLink.tag_id == tag_id
            )
        result = await self._session.execute(stmt)
        return result.scalar_one_or_none()

    async def delete(self, user_id: int, tag_id: int):
        stmt = select(StoreTagLink).where(
            and_(
                StoreTagLink.store_id == user_id, StoreTagLink.tag_id == tag_id
            )
        )
        result = await self._session.execute(stmt)
        record = result.scalar()
        if record is not None:
            await self._session.delete(record)
            await self._session.flush()


class IProductTagLinkRepository(GenericRepository[ProductTagLink], ABC):
    @abstractmethod
    async def get_by_id(self, product_id: int, tag_id: int) -> ProductTagLink:
        raise NotImplementedError()

    @abstractmethod
    async def delete(
        self,
        product_id: int,
        tag_id: int,
    ):
        raise NotImplementedError()


class ProductTagLinkRepository(
    GenericSqlRepository[ProductTagLink], IProductTagLinkRepository
):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, ProductTagLink)

    async def get_by_id(self, product_id: int, tag_id: int) -> ProductTagLink:
        stmt = select(ProductTagLink).filter(
            ProductTagLink.product_id == product_id, ProductTagLink.tag_id == tag_id
        )
        result = await self._session.execute(stmt)
        return result.scalar_one_or_none()

    async def delete(self, user_id: int, tag_id: int):
        stmt = select(ProductTagLink).where(
            and_(
                ProductTagLink.product_id == user_id, ProductTagLink.tag_id == tag_id
            )
        )
        result = await self._session.execute(stmt)
        record = result.scalar()
        if record is not None:
            await self._session.delete(record)
            await self._session.flush()


class ICustomerTagLinkRepository(GenericRepository[CustomerTagLink], ABC):
    @abstractmethod
    async def delete(
        self,
        user_id: int,
        tag_id: int,
    ):
        raise NotImplementedError()


class CustomerTagLinkRepository(
    GenericSqlRepository[CustomerTagLink], ICustomerTagLinkRepository
):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, CustomerTagLink)

    async def delete(self, user_id: int, tag_id: int):
        stmt = select(CustomerTagLink).where(
            and_(
                CustomerTagLink.customer_id == user_id, CustomerTagLink.tag_id == tag_id
            )
        )
        result = await self._session.execute(stmt)
        record = result.scalar()
        if record is not None:
            await self._session.delete(record)
            await self._session.flush()


class ITagRepository(GenericRepository[Tag], ABC):
    @abstractmethod
    async def get_all(
        self,
        limit: int | None,
        offset: int | None,
        group_ids: list[int] | None,
        not_group_ids: list[int] | None,
        substr: str | None,
        is_product_tags: bool | None,
    ) -> List[Tag]:
        raise NotImplementedError()


class TagRepository(GenericSqlRepository[Tag], ITagRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Tag)

    async def get_all(
        self,
        limit: int | None,
        offset: int | None,
        group_ids: list[int] | None,
        not_group_ids: list[int] | None,
        substr: str | None,
        is_product_tags: bool | None,
    ):
        stmt = self._construct_statement_get_all()
        stmt = self._add_limit_offset_to_stmt(stmt, limit, offset)
        stmt = stmt.options(selectinload(Tag.group)).order_by(Tag.name)
        stmt = self._add_substr_to_stmt(stmt, Tag.name, substr)
        if group_ids is not None:
            for id in group_ids:
                sub = self._constructor_subquery(TagGroup, [Tag], id=id)
                stmt = stmt.join(sub)
        if not_group_ids is not None:
            for id in not_group_ids:
                sub = select(TagGroup).filter(TagGroup.id != id).subquery()
                stmt = stmt.join(sub)
        if is_product_tags is not None:
            # JSON out format use as_string(), other format use astext
            # https://stackoverflow.com/questions/53195944/sqlalchemy-filtering-by-a-key-in-a-json-column
            sub = (
                select(TagGroup)
                .filter(
                    TagGroup.details["is_product_tag"].as_string().cast(Boolean)
                    == is_product_tags
                )
                .subquery()
            )
            stmt = stmt.join(sub)
        return await self._execute_statement_get_all(stmt)
