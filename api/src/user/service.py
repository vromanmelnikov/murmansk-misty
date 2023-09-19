from datetime import datetime, timezone
from fastapi import status
from src.store.exceptions import DeleteProductItemException, UpdateUserException
from src.store.exceptions import DeleteProductItemException, UpdateUserException
from src.authorization.schemas import UpdateUserData
from src.schemas.response_items import ResponseItemsSchema
from src.store.phrases import INVALID_BUSKET_MONEY_COUNT
from src.user.phrases import *
from src.authentication.exceptions import *
from src.authorization.schemas import SubjectData
from src.database.exceptions import *
from src.schemas.message import MessageSchema
from src.services.unit_of_work import IUnitOfWork
from src.user.exceptions import *
from src.user.phrases import RESET_EMAIL_SUCCESS
from src.user.schemas import *
from src.database.models import *
from src.utils import check_count_items


class UserService:
    def __init__(self, uow: IUnitOfWork):
        self.__uow = uow

    async def reset_email(self, subject_data: SubjectData, data: ResetEmailSchema):
        async with self.__uow:
            try:
                user = await self.__uow.users.get_by_id(subject_data.id)
                if user is None:
                    raise InvalidUsernameException()
                user.email = data.new_email
                await self.__uow.users.update(user)
                await self.__uow.commit()
                return MessageSchema(message=RESET_EMAIL_SUCCESS)
            except GetItemByIdException as e:
                raise GetResetEmailException() from e
            except UpdateItemException as e:
                raise GetResetEmailException() from e
            except UniqueViolationException as e:
                raise GetResetEmailException(
                    e.message, status.HTTP_400_BAD_REQUEST
                ) from e

    async def get_by_id(self, user_id: int):
        async with self.__uow:
            try:
                user = await self.__uow.users.get_by_id(user_id)
                if user is None:
                    raise InvalidUserIdException(code=404)
                return UserGetByIdSchema.from_orm(user)
            except GetItemByIdException as e:
                raise GetUserByIdException() from e

    async def update_profile(self, subject_data: SubjectData, data: UpdateUserData):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(subject_data)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                if data.birthdate is not None and user_db.birthdate is None:
                    age_tag = await self._get_age_tag(data.birthdate)
                    await self.__uow.customer_tag_links.add(
                        CustomerTagLink(customer_id=subject_data, tag_id=age_tag)
                    )
                user_db.birthdate = data.birthdate
                user_db.firstname = data.firstname
                user_db.lastname = data.lastname
                user_db.patronymic = data.patronymic
                user_db.img = data.image
                await self.__uow.users.update(user_db)
                await self.__uow.commit()
                return MessageSchema(message=CHANGE_USER_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException() from e
            except UpdateItemException as e:
                raise UserUpdateException() from e

    async def post_customer_tag_links(
        self, subject_data: SubjectData, tags: list[int] | None
    ):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(subject_data)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                for tag in tags:
                    await self.__uow.customer_tag_links.add(
                        CustomerTagLink(customer_id=subject_data, tag_id=tag)
                    )
                await self.__uow.commit()
                return MessageSchema(message=ADD_TAG_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except UniqueViolationException as e:
                raise AddCustomerTagLinkException(
                    code=status.HTTP_400_BAD_REQUEST
                ) from e
            except AddItemException as e:
                raise AddCustomerTagLinkException() from e

    async def get_friend_types(self):
        async with self.__uow:
            friend_types = await self.__uow.friend_types.get_all()
            return [FriendTypeSchema.from_orm(f_t) for f_t in friend_types]

    async def post_friend(self, user_id: int, friend: FriendPostSchema):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                friend_db = Friend(
                    initator_id=user_id, friend_id=friend.friend_id, type=friend.type
                )
                friend_exist = await self.__uow.friends.get_by_id(friend_db)
                if friend_exist is not None:
                    raise InvalidFriendException(code=400)
                await self.__uow.friends.add(friend_db)
                await self.__uow.commit()
                return MessageSchema(message=ADD_FRIEND_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except AddItemException as e:
                raise AddFriendException() from e

    async def add_to_favourite(self, user_id: int, p_item: FavouritePostSchema):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                favourite_exist = (
                    await self.__uow.favourites.get_by_user_id_product_item_id(
                        user_id, p_item.product_item_id
                    )
                )
                product_item_exist = await self.__uow.product_items.get_by_id(
                    p_item.product_item_id
                )
                if product_item_exist is None:
                    raise InvalidNoProductItemException(code=404)
                if favourite_exist is not None:
                    raise InvalidProductItemException(code=404)
                favourite_db = Favourite(
                    user_id=user_id, product_item_id=p_item.product_item_id
                )
                await self.__uow.favourites.add(favourite_db)
                await self.__uow.commit()
                return MessageSchema(message=ADD_PRODUCT_ITEM_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except AddItemException as e:
                raise AddProductItemException() from e

    async def add_to_basket(self, user_id: int, basket_item: BasketPostSchema):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                basket_exist = await self.__uow.baskets.get_by_user_id_product_item_id(
                    user_id, basket_item.product_item_id
                )
                product_item_exist = await self.__uow.product_items.get_by_id(
                    basket_item.product_item_id
                )
                if product_item_exist is None:
                    raise InvalidNoProductItemException(code=404)
                if basket_exist is not None:
                    if basket_exist.count > 0:
                        if basket_item.count < 0:
                            if abs(basket_item.count) > basket_exist.count:
                                raise InvalidNoProductItemException(
                                    message="Недостаточно единиц продукта в корзине",
                                    code=404,
                                )
                            basket_exist.count += basket_item.count
                        else:
                            basket_exist.count += basket_item.count
                    await self.__uow.baskets.update(basket_exist)
                else:
                    basket_item_db = Basket(
                        user_id=user_id,
                        product_item_id=basket_item.product_item_id,
                        count=basket_item.count,
                    )
                    await self.__uow.baskets.add(basket_item_db)
                await self.__uow.commit()
                return MessageSchema(message=ADD_PRODUCT_ITEM_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except AddItemException as e:
                raise AddProductItemException() from e

    async def post_event(self, user_id: int, event: EventPostSchema):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                event_db = Event(
                    description=event.description,
                    time=event.time,
                    details=event.details,
                    user_id=user_id,
                )
                await self.__uow.events.add(event_db)
                if "product_id" in event.details.keys():
                    product_item_db = await self.__uow.product_items.get_by_id(
                        event.details["product_id"]
                    )
                    if product_item_db is None:
                        raise InvalidProductItemException(
                            message=INVALID_NO_PRODUCT_ITEM, code=404
                        )
                    if user_db.cash < product_item_db.price:
                        raise InvalidUserIdException(
                            message=INVALID_BUSKET_MONEY_COUNT, code=404
                        )
                    user_db.cash -= product_item_db.price
                    owner_db_id = await self._get_owner_by_product_item_id(
                        product_item_db.id
                    )
                    owner_db = await self.__uow.users.get_by_id(owner_db_id)
                    owner_db.cash += product_item_db.price * 0.95
                    await self.__uow.users.update(owner_db)
                    await self.__uow.users.update(user_db)
                    await self._add_purshase_history(user_id, product_item_db)
                await self.__uow.commit()
                return MessageSchema(message=POST_EVENT_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except AddItemException as e:
                raise AddEventException() from e

    async def delete_event(self, user_id: int, event_id: int):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                event_exist = await self.__uow.events.get_by_id(event_id)
                if event_exist is None:
                    raise InvalidEventException(message=EXIST_EVENT_EXCEPTION)
                if "product_id" in event_exist.details.keys():
                    if event_exist.time > datetime.now(timezone.utc):
                        product_item_db = await self.__uow.product_items.get_by_id(
                            event_exist.details["product_id"]
                        )
                        user_db.cash += product_item_db.price * 0.97
                        owner_db_id = await self._get_owner_by_product_item_id(
                            product_item_db.id
                        )
                        owner_db = await self.__uow.users.get_by_id(owner_db_id)
                        owner_db.cash -= product_item_db.price * 0.95
                        await self.__uow.users.update(owner_db)
                        await self.__uow.users.update(user_db)
                await self.__uow.events.delete(event_id)
                await self.__uow.commit()
                return MessageSchema(message=DELETE_EVENT_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except DeleteItemException as e:
                raise DeleteProductItemException() from e

    async def delete_from_favourite(self, item_id: int):
        async with self.__uow:
            try:
                favourite_exist = await self.__uow.favourites.get_by_id(item_id)
                if favourite_exist is None:
                    raise InvalidProductItemException(
                        message=DELETE_PRODUCT_ITEM_EXCEPTION
                    )
                await self.__uow.favourites.delete(item_id)
                await self.__uow.commit()
                return MessageSchema(message=DELETE_PRODUCT_ITEM_SUCCESS)
            except DeleteItemException as e:
                raise DeleteProductItemException() from e

    async def delete_from_basket(self, item_id: int):
        async with self.__uow:
            try:
                basket_exist = await self.__uow.baskets.get_by_id(item_id)
                if basket_exist is None:
                    raise InvalidProductItemException(
                        message=DELETE_PRODUCT_ITEM_EXCEPTION
                    )
                await self.__uow.baskets.delete(item_id)
                await self.__uow.commit()
                return MessageSchema(message=DELETE_PRODUCT_ITEM_SUCCESS)
            except DeleteItemException as e:
                raise DeleteProductItemException() from e

    async def put_money_on_cash(self, user_id: int, money: int):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                user_db.cash += money
                await self.__uow.users.update(user_db)
                await self.__uow.commit()
                return MessageSchema(message="Счет успешно пополнен!")
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except UpdateItemException as e:
                raise UpdateUserException() from e

    async def get_friends(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ) -> ResponseItemsSchema[FriendWithFriendSchema]:
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                friends = await self.__uow.friends.get_all(
                    user_id, limit, offset, substr
                )
                l = check_count_items(friends, FRIENDS_NOT_FOUND)
                return ResponseItemsSchema.Of(
                    [FriendWithFriendSchema.from_orm(f) for f in friends], offset, l
                )
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except GetAllItemsException as e:
                raise GetAllFriendsException(e.message) from e

    async def get_my_purshase_history(
        self, user_id: int, limit: int | None, offset: int | None, date: datetime | None
    ) -> ResponseItemsSchema[HistorySchema]:
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                history = await self.__uow.purshase_histories.get_all(
                    user_id, limit, offset, date
                )
                l = check_count_items(history, PURSHASES_NOT_FOUND)
                return ResponseItemsSchema.Of(
                    [HistorySchema.from_orm(h) for h in history], offset, l
                )
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except GetAllItemsException as e:
                raise GetAllFriendsException(e.message) from e

    async def get_events_all(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ) -> ResponseItemsSchema[EventSchema]:
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                events = await self.__uow.events.get_all(user_id, limit, offset, substr)
                l = check_count_items(events, EVENTS_NOT_FOUND)
                return ResponseItemsSchema.Of(
                    [EventSchema.from_orm(e) for e in events], offset, l
                )
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except GetAllItemsException as e:
                raise GetAllFriendsException(e.message) from e

    async def delete_friend(self, user_id: int, friend_id: int):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                friend_db = Friend(initator_id=user_id, friend_id=friend_id)
                friend_exist = await self.__uow.friends.get_by_id(friend_db)
                if friend_exist is None:
                    raise InvalidFriendNoException(code=400)
                await self.__uow.friends.delete(friend_db)
                await self.__uow.commit()
                return MessageSchema(message=FRIEND_DELETE_SUCCESS)
            except GetItemByIdException as e:
                raise GetFriendByIdException(code=status.HTTP_400_BAD_REQUEST) from e

    async def basket_by_user_id(
        self,
        user_id: int,
        limit: int | None,
        offset: int | None,
        substr: str | None,
    ) -> ResponseItemsSchema[GetBasketSchema]:
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                product_items = await self.__uow.baskets.get_all(
                    user_id, limit, offset, substr
                )
                l = check_count_items(product_items, BASKET_IS_EMPTY)
                return ResponseItemsSchema.Of(
                    [GetBasketSchema.from_orm(b) for b in product_items], offset, l
                )
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except GetAllItemsException as e:
                raise GetAllItemsException(e.message) from e

    async def favourite_by_user_id(
        self, user_id: int, limit: int | None, offset: int | None, substr: str | None
    ) -> ResponseItemsSchema[GetFavouriteSchema]:
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                product_items = await self.__uow.favourites.get_all(
                    user_id, limit, offset, substr
                )
                l = check_count_items(product_items, FAVOURITE_IS_EMPTY)
                return ResponseItemsSchema.Of(
                    [GetFavouriteSchema.from_orm(b) for b in product_items], offset, l
                )
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except GetAllItemsException as e:
                raise GetAllItemsException(e.message) from e

    async def get_recommend_by_relative(
        self,
        user_id: int,
        limit: int | None,
        offset: int | None,
        friend_type: list[str] | None,
    ) -> ResponseItemsSchema[RecommendFriendSchema]:
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                product_items_db = await self.__uow.friends.get_recommend_by_relative(
                    user_id, limit, offset, friend_type
                )
                return [RecommendFriendSchema.from_orm(p) for p in product_items_db]
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e

    async def _calculate_age_user(self, birthdate):
        return datetime.utcnow().year - birthdate.year

    async def _get_age_tag(self, age):
        all_age_tags = await self.__uow.tags.get_all(
            None, None, [AGE_TAG_GROUP_ID], None, None, None
        )
        age_user = await self._calculate_age_user(age)
        for tag in all_age_tags:
            if (
                age_user >= tag.details["age_min"]
                and age_user <= tag.details["age_max"]
            ):
                age_tag = tag.id
                return age_tag

    async def _add_purshase_history(self, user_id: int, p_i: ProductItem):
        p_h = PurshaseHistory(
            count=1, price=p_i.price, user_id=user_id, product_item_id=p_i.id
        )
        await self.__uow.purshase_histories.add(p_h)

    async def _get_owner_by_product_item_id(self, product_item_id: int):
        owner_db = await self.__uow.product_items.get_owner_by_id(product_item_id)
        owner_id = owner_db.product.store.owner.id
        return owner_id
