from abc import ABC, abstractmethod
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List, Optional
from sqlalchemy.orm import selectinload
from sqlalchemy import Boolean, select, and_, func

from src.database.models import *
from src.database.repositories import GenericSqlRepository, GenericRepository
from src.database.exceptions import *
from src.user.exceptions import *


class IStoreRepository(GenericRepository[Store], ABC):
    @abstractmethod
    async def get_all(
        self, limit: int | None, offset: int | None, substr: str | None
    ) -> List[Store]:
        raise NotImplementedError()

    @abstractmethod
    async def get_by_id(self, store_id: int) -> Store:
        raise NotImplementedError()


class StoreRepository(GenericSqlRepository[Store], IStoreRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Store)

    async def get_all(
        self,
        limit: int | None,
        offset: int | None,
        substr: str | None,
        tag_ids: list[int] | None,
    ) -> List[Store]:
        stmt = self._construct_statement_get_all().order_by(Store.name)
        stmt = stmt.options(
            selectinload(Store.products).selectinload(Product.product_feedbacks),
            selectinload(Store.store_tag_links).selectinload(StoreTagLink.tag),
        )
        stmt = self._add_limit_offset_to_stmt(stmt, limit, offset)
        stmt = self._add_substr_to_stmt(stmt, Store.name, substr)
        if tag_ids:
            for tag in tag_ids:
                sub = self._constructor_subquery(StoreTagLink, [], tag_id=tag)
                stmt = stmt.join(sub)
        return await self._execute_statement_get_all(stmt)

    async def get_by_id(self, store_id: int) -> Store:
        stmt = self._construct_statement_get_by_id(store_id)
        stmt = stmt.options(
            selectinload(Store.products).selectinload(Product.product_feedbacks)
        )
        return await self._execute_statement_get_by_id(stmt, store_id)


class IProductRepository(GenericRepository[Product], ABC):
    @abstractmethod
    async def get_all(
        self,
        store_id: int,
        limit: int | None,
        offset: int | None,
        substr: str | None,
        tag_ids: list[int] | None,
        is_service: bool,
    ) -> List[Product]:
        raise NotImplementedError()

    @abstractmethod
    async def get_with_org(self, id: int) -> Optional[Product]:
        raise NotImplementedError()

    @abstractmethod
    async def get_by_id(self, product_id: int) -> Optional[Product]:
        raise NotImplementedError()


class ProductRepository(GenericSqlRepository[Product], IProductRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Product)

    async def get_all(
        self,
        store_id: int,
        limit: int | None,
        offset: int | None,
        substr: str | None,
        tag_ids: list[int] | None,
        is_service: bool,
    ) -> List[Product]:
        stmt = self._construct_statement_get_all(store_id=store_id).order_by(
            Product.name
        )
        stmt = stmt.options(
            selectinload(Product.product_items),
            selectinload(Product.product_feedbacks),
            selectinload(Product.product_tag_links).selectinload(ProductTagLink.tag),
        )
        stmt = self._add_limit_offset_to_stmt(stmt, limit, offset)
        stmt = self._add_substr_to_stmt(stmt, Product.name, substr)
        if tag_ids:
            for tag in tag_ids:
                sub = self._constructor_subquery(ProductTagLink, [], tag_id=tag)
                stmt = stmt.join(sub)
        if is_service is not None:
            stmt = stmt.filter(Product.is_service == is_service)
        return await self._execute_statement_get_all(stmt)

    async def get_with_org(self, id: int) -> Optional[Product]:
        stmt = self._construct_statement_get_by_id(id)
        stmt = stmt.options(selectinload(Product.store))
        return await self._execute_statement_get_by_id(stmt, id)

    async def get_by_id(self, product_id: int) -> Product | None:
        stmt = self._construct_statement_get_by_id(product_id)
        stmt = stmt.options(
            selectinload(Product.product_items), selectinload(Product.product_feedbacks)
        )
        return await self._execute_statement_get_by_id(stmt, product_id)


class IProductItemRepository(GenericRepository[ProductItem], ABC):
    @abstractmethod
    async def get_all(
        self, product_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        raise NotImplementedError()

    @abstractmethod
    async def get_owner_by_id(self, product_item_id: int):
        raise NotImplementedError()


class ProductItemRepository(GenericSqlRepository[ProductItem], IProductItemRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, ProductItem)

    async def get_all(
        self, product_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        stmt = self._construct_statement_get_all(offset, limit, product_id=product_id)
        stmt = self._add_substr_to_stmt(stmt, ProductItem.name, substr)
        res = await self._execute_statement_get_all(stmt)
        return res

    async def get_owner_by_id(self, product_item_id: int):
        stmt = self._construct_statement_get_by_id(product_item_id)
        stmt = stmt.options(
            selectinload(ProductItem.product)
            .selectinload(Product.store)
            .selectinload(Store.owner)
        )
        return await self._execute_statement_get_by_id(stmt, product_item_id)


class ICharacteristicRepository(GenericRepository[Characteristic], ABC):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Characteristic)

    @abstractmethod
    async def get_all(
        self, limit: int | None, offset: int | None, substr: str | None
    ) -> List[Characteristic]:
        raise NotImplementedError()

    @abstractmethod
    async def _check_exist_char(self, char: Characteristic) -> bool:
        raise NotImplementedError()


class CharacteristicRepository(
    GenericSqlRepository[Characteristic], ICharacteristicRepository
):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Characteristic)

    async def get_all(
        self, limit: int | None, offset: int | None, substr: str | None
    ) -> List[Characteristic]:
        stmt = self._construct_statement_get_all()
        stmt = self._add_limit_offset_to_stmt(stmt, limit, offset).order_by(
            Characteristic.name
        )
        stmt = self._add_substr_to_stmt(stmt, Characteristic.name, substr)
        return await self._execute_statement_get_all(stmt)

    async def _check_exist_char(self, char: Characteristic) -> bool:
        stmt = await self._session.execute(
            select(Characteristic).where(Characteristic.name == char.name)
        )
        result = stmt.scalar_one_or_none()
        return True if result else None


class IProductFeedbackRepository(GenericRepository[ProductFeedback], ABC):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, ProductFeedback)

    @abstractmethod
    async def get_by_user_product(self, user_id: int, product_id: int):
        raise NotImplementedError()

    @abstractmethod
    async def get_all(
        self, product_id: int, limit: int | None, offset: int | None, count: int | None
    ):
        pass


class ProductFeedbackRepository(
    GenericSqlRepository[ProductFeedback], IProductFeedbackRepository
):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, ProductFeedback)

    async def get_by_user_product(self, user_id: int, product_id: int):
        stmt = await self._session.execute(
            select(ProductFeedback).filter(
                ProductFeedback.user_id == user_id,
                ProductFeedback.product_id == product_id,
            )
        )
        result = stmt.scalar_one_or_none()
        return result

    async def get_all(
        self, product_id: int, limit: int | None, offset: int | None, count: int | None
    ):
        stmt = self._construct_statement_get_all(offset, limit, product_id=product_id)
        stmt = stmt.options(selectinload(ProductFeedback.likes))
        stmt = stmt.options(
            selectinload(ProductFeedback.likes),
            selectinload(ProductFeedback.user).selectinload(User.role),
        ).order_by(ProductFeedback.mark.desc())
        if count:
            sub = (
                select(ProductFeedback)
                .join(Like)
                .group_by(ProductFeedback.id)
                .having(func.count(Like.product_feedback_id) > count)
                .subquery()
            )
            stmt = stmt.select_from(sub)
        res = await self._execute_statement_get_all(stmt)
        return res


class ILikeRepository(GenericRepository[Like], ABC):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Like)

    @abstractmethod
    async def get_by_id(self, user_id: int, product_feedback_id: int):
        raise NotImplementedError()

    @abstractmethod
    async def delete(self, user_id: int, product_feedback_id: int):
        raise NotImplementedError()


class LikeRepository(GenericSqlRepository[Like], ILikeRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Like)

    async def get_by_id(self, user_id: int, product_feedback_id: int):
        stmt = await self._session.execute(
            select(Like).filter(
                Like.user_id == user_id,
                Like.product_feedback_id == product_feedback_id,
            )
        )
        result = stmt.scalar_one_or_none()
        return result

    async def delete(self, user_id: int, product_feedback_id: int):
        stmt = select(Like).filter(
            Like.user_id == user_id,
            Like.product_feedback_id == product_feedback_id,
        )
        res = await self._execute_statement_get_one(stmt)
        await self._session.delete(res)
        await self._session.flush()
