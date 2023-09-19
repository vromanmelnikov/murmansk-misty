from abc import ABC, abstractmethod
from sqlalchemy import or_
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List, Optional
from sqlalchemy.orm import selectinload
from datetime import datetime

from src.database.models import *
from src.database.repositories import GenericSqlRepository, GenericRepository
from src.database.exceptions import *
from src.user.exceptions import *


class IRoleRepository(GenericRepository[Role], ABC):
    @abstractmethod
    async def get_available_roles(self) -> List[Role]:
        raise NotImplementedError()


class RoleRepository(GenericSqlRepository[Role], IRoleRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Role)

    async def get_available_roles(self) -> List[Role]:
        try:
            stmt = self._construct_statement_get_all(is_invite=True).order_by(Role.name)
            return await self._execute_statement_get_all(stmt)
        except GetAllItemsException as e:
            raise GetAvailableRolesException() from e


class IFriendTypeRepository(GenericRepository[FriendType], ABC):
    pass


class FriendTypeRepository(GenericSqlRepository[FriendType], IFriendTypeRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, FriendType)


class IPurshaseHistoryRepository(GenericRepository[PurshaseHistory], ABC):
    @abstractmethod
    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, date: datetime | None
    ):
        raise NotImplementedError()


class PurshaseHistoryRepository(
    GenericSqlRepository[PurshaseHistory], IPurshaseHistoryRepository
):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, PurshaseHistory)

    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, date: datetime | None
    ):
        stmt = self._construct_statement_get_all(
            offset, limit, user_id=user_id
        ).order_by(PurshaseHistory.date.desc())
        stmt = stmt.options(selectinload(PurshaseHistory.product_item))
        if date:
            stmt = stmt.filter(PurshaseHistory.date >= date)
        res = await self._execute_statement_get_all(stmt)
        return res


class IEventRepository(GenericRepository[Event], ABC):
    @abstractmethod
    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        raise NotImplementedError()


class EventRepository(GenericSqlRepository[Event], IEventRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Event)

    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        stmt = self._construct_statement_get_all(
            offset, limit, user_id=user_id
        ).order_by(Event.time.desc())
        stmt = self._add_substr_to_stmt(stmt, Event.description, substr)
        res = await self._execute_statement_get_all(stmt)
        return res


class IFavouriteRepository(GenericRepository[Favourite], ABC):
    @abstractmethod
    async def get_by_user_id_product_item_id(self, user_id: int, p_item_id: int):
        raise NotImplementedError()

    @abstractmethod
    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        raise NotImplementedError()


class FavouriteRepository(GenericSqlRepository[Favourite], IFavouriteRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Favourite)

    async def get_by_user_id_product_item_id(self, user_id: int, p_item_id: int):
        stmt = await self._session.execute(
            select(Favourite).filter(
                Favourite.user_id == user_id, Favourite.product_item_id == p_item_id
            )
        )
        return stmt.scalar_one_or_none()

    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        stmt = self._construct_statement_get_all(offset, limit, user_id=user_id)
        stmt = stmt.options(
            selectinload(Favourite.product_item).selectinload(ProductItem.product)
        )
        if substr:
            sub = (
                select(ProductItem)
                .where(ProductItem.name.ilike(f"%{substr}%"))
                .subquery()
            )
            stmt = stmt.join(sub)
        res = await self._execute_statement_get_all(stmt)
        return res


class IBasketRepository(GenericRepository[Basket], ABC):
    @abstractmethod
    async def get_by_user_id_product_item_id(self, user_id: int, p_item_id: int):
        raise NotImplementedError()

    @abstractmethod
    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        raise NotImplementedError()


class BasketRepository(GenericSqlRepository[Basket], IBasketRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Basket)

    async def get_by_user_id_product_item_id(self, user_id: int, p_item_id: int):
        stmt = await self._session.execute(
            select(Basket).filter(
                Basket.user_id == user_id, Basket.product_item_id == p_item_id
            )
        )
        return stmt.scalar_one_or_none()

    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        stmt = self._construct_statement_get_all(offset, limit, user_id=user_id)
        stmt = stmt.options(
            selectinload(Basket.product_item).selectinload(ProductItem.product)
        )
        if substr:
            sub = (
                select(ProductItem)
                .where(ProductItem.name.ilike(f"%{substr}%"))
                .order_by(ProductItem.name)
                .subquery()
            )
            stmt = stmt.join(sub)
        res = await self._execute_statement_get_all(stmt)
        return res


class IFriendRepository(GenericRepository[Friend], ABC):
    @abstractmethod
    async def get_by_id(self, friend: Friend):
        raise NotImplementedError()

    @abstractmethod
    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        raise NotImplementedError()

    @abstractmethod
    async def delete(self, friend: Friend):
        raise NotImplementedError()

    @abstractmethod
    async def get_recommend_by_relative(
        self,
        user_id: int,
        limit: int | None,
        offset: int | None,
        friend_type: list[str] | None,
    ):
        raise NotImplementedError()


class FriendRepository(GenericSqlRepository[Friend], IFriendRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, Friend)

    async def get_by_id(self, friend: Friend):
        stmt = select(Friend).filter(
            Friend.initator_id == friend.initator_id,
            Friend.friend_id == friend.friend_id,
        )
        result = await self._session.execute(stmt)
        return result.scalar_one_or_none()

    async def get_all(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ):
        stmt = self._construct_statement_get_all(offset, limit).order_by(Friend.type)
        stmt = self._add_substr_to_stmt(stmt, Friend.type, substr)
        stmt = stmt.options(selectinload(Friend.friend).selectinload(User.role))
        stmt = stmt.filter(Friend.initator_id == user_id)
        return await self._execute_statement_get_all(stmt)

    async def delete(self, friend: Friend):
        stmt = select(Friend).filter(
            Friend.friend_id == friend.friend_id,
            Friend.initator_id == friend.initator_id,
        )
        res = await self._execute_statement_get_one(stmt)
        await self._session.delete(res)
        await self._session.flush()

    async def get_recommend_by_relative(
        self,
        user_id: int,
        limit: int | None,
        offset: int | None,
        friend_type: list[str] | None,
    ):
        stmt = self._construct_statement_get_all(initator_id=user_id)
        if friend_type:
            stmt = stmt.filter(or_(Friend.type == f_t for f_t in friend_type))
        stmt = self._add_limit_offset_to_stmt(stmt, limit, offset)
        stmt = stmt.options(
            selectinload(Friend.friend)
            .selectinload(User.favourites)
            .selectinload(Favourite.product_item)
            .selectinload(ProductItem.product)
        )
        return await self._execute_statement_get_all(stmt)


# User


class IUserRepository(GenericRepository[User], ABC):
    @abstractmethod
    async def get_by_id(self, id: int) -> Optional[User]:
        raise NotImplementedError()

    @abstractmethod
    async def get_by_login(self, email: str) -> Optional[User]:
        raise NotImplementedError()


class UserRepository(GenericSqlRepository[User], IUserRepository):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(session, User)

    async def get_by_id(self, id: int) -> Optional[User]:
        stmt = self._construct_statement_get_by_id(id)
        stmt = stmt.options(
            selectinload(User.role),
            selectinload(User.tag_links).selectinload(CustomerTagLink.tag),
            selectinload(User.stores),
        )
        return await self._execute_statement_get_by_id(stmt, id)

    async def get_by_login(self, email: str) -> Optional[User]:
        try:
            stmt = self._construct_statement_get_one(email=email)
            # stmt = stmt.options(selectinload(User.role))
            return await self._execute_statement_get_one(stmt)
        except GetOneItemException as e:
            raise GetUserByEmailException(email) from e
