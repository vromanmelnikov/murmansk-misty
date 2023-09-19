from abc import ABC, abstractmethod
from typing import Callable
from sqlalchemy.ext.asyncio import AsyncSession
from redis import Redis

from src.task.repositories import *
from src.authentication.repositories import *
from src.file_operator.repositories import *
from src.user.repositories import *
from src.tag.repositories import *
from src.store.repositories import *


class IUnitOfWork(ABC):
    # user
    roles: IRoleRepository
    users: IUserRepository
    friend_types: IFriendTypeRepository
    friends: IFriendRepository
    baskets: IBasketRepository
    favourites: IFavouriteRepository
    purshase_histories: IPurshaseHistoryRepository
    events: IEventRepository

    # auth
    pswd_recoveries: IPasswordRecoveryRepository

    # tag
    tags: ITagRepository
    tag_groups: ITagGroupRepository
    customer_tag_links: ICustomerTagLinkRepository
    store_tag_links: IStoreTagLinkRepository
    product_tag_links: IProductTagLinkRepository

    # store
    stores: IStoreRepository
    products: IProductRepository
    product_items: IProductItemRepository
    characteristics: ICharacteristicRepository
    product_feedbacks: IProductFeedbackRepository
    likes: ILikeRepository

    # file
    files: IFileRepository

    # ai
    unit_intervals: IUnitIntervalRepository
    tasks: ITaskRepository

    @abstractmethod
    async def __aenter__(self):
        pass

    @abstractmethod
    async def __aexit__(self):
        pass

    @abstractmethod
    async def commit(self):
        raise NotImplementedError()

    @abstractmethod
    async def rollback(self):
        raise NotImplementedError()


class UnitOfWork(IUnitOfWork):
    def __init__(self, session_maker: Callable[[], AsyncSession], redis_conect: Redis):
        self.__session_maker = session_maker
        self.__redis_conect = redis_conect

    async def __aenter__(self):
        self.__session: AsyncSession = self.__session_maker()
        # user
        self.roles = RoleRepository(self.__session)
        self.users = UserRepository(self.__session)
        self.friend_types = FriendTypeRepository(self.__session)
        self.friends = FriendRepository(self.__session)
        self.baskets = BasketRepository(self.__session)
        self.favourites = FavouriteRepository(self.__session)
        self.purshase_histories = PurshaseHistoryRepository(self.__session)
        self.events = EventRepository(self.__session)

        # auth
        self.pswd_recoveries = PasswordRecoveryRepository(self.__redis_conect)

        # tag
        self.tags = TagRepository(self.__session)
        self.tag_groups = TagGroupRepository(self.__session)
        self.customer_tag_links = CustomerTagLinkRepository(self.__session)
        self.store_tag_links = StoreTagLinkRepository(self.__session)
        self.product_tag_links = ProductTagLinkRepository(self.__session)

        # store
        self.stores = StoreRepository(self.__session)
        self.products = ProductRepository(self.__session)
        self.product_items = ProductItemRepository(self.__session)
        self.characteristics = CharacteristicRepository(self.__session)
        self.product_feedbacks = ProductFeedbackRepository(self.__session)
        self.likes = LikeRepository(self.__session)

        # file
        self.files = FileRepository(self.__session)
        # ai
        self.unit_intervals = UnitIntervalRepository(self.__session)
        self.tasks = TaskRepository(self.__session)
        return await super().__aenter__()

    async def __aexit__(self, *args):
        await self.rollback()
        await self.__session.close()

    async def commit(self):
        await self.__session.commit()

    async def rollback(self):
        await self.__session.rollback()
