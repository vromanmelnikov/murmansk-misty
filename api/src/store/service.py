from fastapi import status
from src.database.models import *
from src.store.exceptions import *
from src.store.phrases import *
from src.store.product_schema import ProductFeedbackSchema
from src.store.schemas import *
from src.const import ROLE_SELLER
from src.database.models import *
from src.schemas.response_items import ResponseItemsSchema
from src.authentication.exceptions import InvalidUserIdException
from src.database.exceptions import *
from src.schemas.message import MessageSchema
from src.services.unit_of_work import IUnitOfWork
from src.store.exceptions import *
from src.store.phrases import ADD_STORE_SUCCESS, UPDATE_STORE_SUCCESS
from src.store.schemas import StorePostSchema, StoreUpdateSchema
from src.user.exceptions import GetUserByIdException
from src.utils import check_count_items
from src.tag.phrases import *


class StoreService:
    def __init__(self, uow: IUnitOfWork):
        self.__uow = uow

    async def post(self, user_id: int, store: StorePostSchema):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                user_db.role_id = ROLE_SELLER
                await self.__uow.users.update(user_db)
                store_db = Store(
                    name=store.name,
                    description=store.description,
                    img=store.img,
                    is_active=store.is_active,
                    address=store.address,
                    coordinates=store.coords,
                    site=store.site,
                    details=store.details,
                    owner_id=user_id,
                )
                if "characteristics" in store.details.keys():
                    await self._extract_characteristics_from_details(
                        store.details["characteristics"]
                    )
                await self.__uow.stores.add(store_db)
                await self.__uow.commit()
                return MessageSchema(message=ADD_STORE_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException() from e
            except AddItemException as e:
                raise AddStoreException() from e

    async def put(self, store: StoreUpdateSchema):
        async with self.__uow:
            try:
                store_db = await self.__uow.stores.get_by_id(store.id)
                store_db.name = store.name
                store_db.description = store.description
                store_db.img = store.img
                store_db.is_active = store.is_active
                store_db.address = store.address
                store_db.coordinates = store.coords
                store_db.site = store.site
                store_db.details = store.details
                await self.__uow.stores.update(store_db)
                if "characteristics" in store.details.keys():
                    await self._extract_characteristics_from_details(
                        store.details["characteristics"]
                    )
                await self.__uow.commit()
                return MessageSchema(message=UPDATE_STORE_SUCCESS)
            except GetItemByIdException as e:
                raise GetShopByIdException() from e
            except UpdateItemException as e:
                raise UpdateStoreException() from e

    async def post_product(self, user_id: int, product: ProductPostSchema):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=status.HTTP_404_NOT_FOUND)
                store_db = await self.__uow.stores.get_by_id(product.store_id)
                if store_db is None:
                    raise InvalidShopIdException(code=status.HTTP_404_NOT_FOUND)
                product_db = Product(
                    name=product.name,
                    description=product.description,
                    details=product.details,
                    preview_img=product.preview_img,
                    store_id=product.store_id,
                    is_service=product.is_service,
                )
                if "characteristics" in product.details.keys():
                    await self._extract_characteristics_from_details(
                        product.details["characteristics"]
                    )
                await self.__uow.products.add(product_db)
                await self.__uow.commit()
                return MessageSchema(message=ADD_PRODUCT_SUCCESS)
            except GetItemByIdException as e:
                raise GetShopByIdException() from e
            except AddItemException as e:
                raise AddProductException() from e

    async def post_product_item(
        self, user_id: int, product_item: ProductItemPostSchema
    ):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                product_db = await self.__uow.products.get_by_id(
                    product_item.product_id
                )
                if product_db is None:
                    raise InvalidProductIdException(code=404)
                product_item_db = ProductItem(
                    name=product_item.name,
                    count=product_item.count,
                    details=product_item.details,
                    price=product_item.price,
                    product_id=product_item.product_id,
                )
                if "characteristics" in product_item.details.keys():
                    await self._extract_characteristics_from_details(
                        product_item.details["characteristics"]
                    )
                await self.__uow.product_items.add(product_item_db)
                await self.__uow.commit()
                return MessageSchema(message=ADD_PRODUCT_ITEM_SUCCESS)
            except GetItemByIdException as e:
                raise GetProductByIdException() from e
            except AddItemException as e:
                raise AddProductItemException() from e

    async def put_product(self, user_id: int, product: ProductUpdateSchema):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                product_db = await self.__uow.products.get_by_id(product.id)
                if product_db is None:
                    raise InvalidProductIdException(code=404)
                product_db.name = product.name
                product_db.description = product.description
                product_db.details = product.details
                product_db.preview_img = product.preview_img
                if "characteristics" in product.details.keys():
                    await self._extract_characteristics_from_details(
                        product.details["characteristics"]
                    )
                await self.__uow.products.update(product_db)
                await self.__uow.commit()
                return MessageSchema(message=UPDATE_PRODUCT_SUCCESS)
            except GetItemByIdException as e:
                raise GetShopByIdException() from e
            except UpdateItemException as e:
                raise UpdateProductException() from e

    async def put_product_item(
        self, user_id: int, product_item: ProductItemUpdateSchema
    ):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                product_item_db = await self.__uow.product_items.get_by_id(
                    product_item.id
                )
                if product_item_db is None:
                    raise InvalidProuctItemByIdException(code=404)
                product_item_db.name = product_item.name
                product_item_db.price = product_item.price
                product_item_db.details = product_item.details
                product_item_db.count = product_item.count
                if "characteristics" in product_item_db.details.keys():
                    await self._extract_characteristics_from_details(
                        product_item_db.details["characteristics"]
                    )
                await self.__uow.product_items.update(product_item_db)
                await self.__uow.commit()
                return MessageSchema(message=UPDATE_PRODUCT_SUCCESS)
            except GetItemByIdException as e:
                raise GetProductItemByIdException() from e
            except UpdateItemException as e:
                raise UpdateProductItemException() from e

    async def buy_product_item(self, user_id: int, product_item: BuyProductItemSchema):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                product_item_db = await self.__uow.product_items.get_by_id(
                    product_item.product_id
                )
                if product_item_db is None:
                    raise InvalidProuctItemByIdException(code=404)
                if product_item_db.count - product_item.count < 0:
                    raise InvalidBuyProductItemException(code=400)
                product_item_db.count -= product_item.count
                if product_item.count * product_item_db.price > user_db.cash:
                    raise InvalidBusketException(
                        message=INVALID_BUSKET_MONEY_COUNT, code=400
                    )
                user_db.cash -= product_item.count * product_item_db.price
                owner_db_id = await self._get_owner_by_product_item_id(
                    product_item_db.id
                )
                owner_db = await self.__uow.users.get_by_id(owner_db_id)
                owner_db.cash += product_item.count * product_item_db.price * 0.95
                await self.__uow.users.update(owner_db)
                await self.__uow.users.update(user_db)
                await self.__uow.product_items.update(product_item_db)
                await self._create_purshase_history(
                    product_item.count * product_item_db.price,
                    None,
                    product_item_db,
                    product_item.count,
                    user_id,
                )
                await self.__uow.commit()
                return MessageSchema(message=UPDATE_PRODUCT_SUCCESS)
            except GetItemByIdException as e:
                raise GetProductItemByIdException() from e
            except UpdateItemException as e:
                raise UpdateProductItemException() from e

    async def get_all(
        self,
        limit: int | None,
        offset: int | None,
        substr: str | None,
        tag_ids: list[int] | None,
    ) -> ResponseItemsSchema[StoreWithTags]:
        async with self.__uow:
            try:
                stores = await self.__uow.stores.get_all(limit, offset, substr, tag_ids)
                l = check_count_items(stores, STORES_NOT_FOUND)
                return ResponseItemsSchema.Of(
                    [StoreWithTags.from_orm(s) for s in stores], offset, l
                )
            except GetAllItemsException as e:
                raise GetAllStoreException(e.message) from e

    async def get_product_items_by_product_id(
        self, product_id: int
    ) -> ProductWithProductItems:
        async with self.__uow:
            try:
                product_item = await self.__uow.products.get_by_id(product_id)
                if product_item is None:
                    raise InvalidProductIdException(
                        message="Неверный id товара", code=404
                    )
                return ProductWithProductItems.from_orm(product_item)
            except GetItemByIdException as e:
                raise GetAllItemsException(e.message) from e

    async def get_product_feedbacks_by_product_id(
        self,
        user_id: int,
        product_id: int,
        limit: int | None,
        offset: int | None,
        count: int | None,
    ) -> ResponseItemsSchema[ProductFeedbackSchema]:
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                p_feedbacks = await self.__uow.product_feedbacks.get_all(
                    product_id, limit, offset, count
                )
                l = check_count_items(p_feedbacks, PRODUCT_FEEDBACK_NOT_FOUND)
                items = []
                for p in p_feedbacks:
                    model = ProductFeedbackSchema.from_orm(p)
                    is_has_like = await self.__uow.likes.get_by_id(user_db.id, p.id)
                    model.is_like = True if is_has_like else False
                    items.append(model)
                return ResponseItemsSchema.Of(items, offset, l)
            except GetItemByIdException as e:
                raise GetUserByIdException() from e
            except GetAllItemsException as e:
                raise GetAllStoreException(e.message) from e

    async def get_all_products(
        self,
        store_id: int | None,
        limit: int | None,
        offset: int | None,
        substr: str | None,
        tag_ids: list[int] | None,
        is_service: bool | None,
    ) -> ResponseItemsSchema[ProductWithTags]:
        async with self.__uow:
            try:
                products = await self.__uow.products.get_all(
                    store_id, limit, offset, substr, tag_ids, is_service
                )
                l = check_count_items(products, PRODUCTS_NOT_FOUND)
                return ResponseItemsSchema.Of(
                    [ProductWithTags.from_orm(p) for p in products], offset, l
                )
            except GetAllItemsException as e:
                raise GetAllProductException(e.message) from e

    async def get_all_characteristics(
        self, limit: int | None, offset: int | None, substr: str | None
    ) -> ResponseItemsSchema[CharacteristicSchema]:
        async with self.__uow:
            try:
                characteristics = await self.__uow.characteristics.get_all(
                    limit, offset, substr
                )
                l = check_count_items(characteristics, CHARACTERISTICS_NOT_FOUND)
                return ResponseItemsSchema.Of(
                    [CharacteristicSchema.from_orm(c) for c in characteristics],
                    offset,
                    l,
                )
            except GetAllItemsException as e:
                raise GetAllCharacteristicException(e.message) from e

    async def post_product_feedback(
        self, user_id: int, prod_feed: ProductFeedbackPostSchema
    ):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                product_exist = await self.__uow.products.get_by_id(
                    prod_feed.product_id
                )
                if product_exist is None:
                    raise InvalidProductIdException(code=404)
                p_f_exist = await self.__uow.product_feedbacks.get_by_user_product(
                    user_id, prod_feed.product_id
                )
                if p_f_exist is not None:
                    raise InvalidProductFeedbackException(code=404)
                prod_feed_db = ProductFeedback(
                    mark=prod_feed.mark,
                    review=prod_feed.review,
                    product_id=prod_feed.product_id,
                    user_id=user_id,
                )
                await self.__uow.product_feedbacks.add(prod_feed_db)
                await self.__uow.commit()
                return MessageSchema(message=FEEDBACK_ADD_SUCCESS)
            except GetItemByIdException as e:
                raise GetProductFeedbackByIdException() from e
            except AddItemException as e:
                raise AddProductFeedbackException() from e

    async def post_like_delete(self, user_id: int, like: LikePostSchema):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                prod_exist = await self.__uow.product_feedbacks.get_by_id(
                    like.product_feedback_id
                )
                if prod_exist is None:
                    raise InvalidProductFeedbackNoException(code=404)
                like_exist = await self.__uow.likes.get_by_id(
                    user_id, like.product_feedback_id
                )
                if like_exist is not None:
                    await self.__uow.likes.delete(user_id, like.product_feedback_id)
                    await self.__uow.commit()
                    return MessageSchema(message=DELETE_LIKE_SUCCESS)
                else:
                    like_db = Like(
                        user_id=user_id, product_feedback_id=like.product_feedback_id
                    )
                    await self.__uow.likes.add(like_db)
                    await self.__uow.commit()
                    return MessageSchema(message=LIKE_ADD_SUCCESS)
            except GetItemByIdException as e:
                raise GetLikeByIdException() from e
            except AddItemException as e:
                raise AddLikeException() from e
            except DeleteItemException as e:
                raise DeleteLikeException() from e

    async def get_by_id(self, store_id: int) -> StoreSchema | None:
        async with self.__uow:
            try:
                store_db = await self.__uow.stores.get_by_id(store_id)
                if store_db is None:
                    raise InvalidShopIdException(message=INVALID_SHOP_ID, code=404)
                return StoreSchema.from_orm(store_db)
            except GetItemByIdException as e:
                raise GetShopByIdException() from e

    async def buy_from_basket(self, user_id: int, basket_id: int):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                basket_item_db = await self.__uow.baskets.get_by_id(basket_id)
                product_item_db = await self.__uow.product_items.get_by_id(
                    basket_item_db.product_item_id
                )
                if basket_item_db.count > product_item_db.count:
                    raise InvalidBusketException(message=INVALID_BUSKET_COUNT, code=400)
                product_item_db.count -= basket_item_db.count
                if basket_item_db.count * product_item_db.price > user_db.cash:
                    raise InvalidBusketException(
                        message=INVALID_BUSKET_MONEY_COUNT, code=400
                    )
                user_db.cash -= basket_item_db.count * product_item_db.price
                owner_db_id = await self._get_owner_by_product_item_id(
                    product_item_db.id
                )
                owner_db = await self.__uow.users.get_by_id(owner_db_id)
                owner_db.cash += basket_item_db.count * product_item_db.price * 0.95
                await self.__uow.users.update(owner_db)
                await self.__uow.baskets.delete(basket_id)
                await self.__uow.product_items.update(product_item_db)
                await self.__uow.users.update(user_db)
                await self._create_purshase_history(
                    basket_item_db.count * product_item_db.price,
                    basket_item_db,
                    None,
                    None,
                    None,
                )
                await self.__uow.commit()
                return MessageSchema(message=BUY_BASKET_SUCCESS)
            except GetItemByIdException as e:
                raise GetLikeByIdException() from e
            except DeleteItemException as e:
                raise DeleteBasketException() from e

    async def _extract_characteristics_from_details(self, characteristics: list):
        for items in characteristics:
            for key in items.keys():
                char_db = Characteristic(name=key)
                is_exist = await self.__uow.characteristics._check_exist_char(char_db)
                if not is_exist:
                    await self.__uow.characteristics.add(char_db)
                    await self.__uow.commit()

    async def _create_purshase_history(
        self,
        price: int,
        product_item: Basket | None,
        product_item_now: ProductItem | None,
        count_now: int | None,
        user_id: int | None,
    ):
        if product_item:
            p_h_db = PurshaseHistory(
                count=product_item.count,
                price=price,
                user_id=product_item.user_id,
                product_item_id=product_item.product_item_id,
            )
        else:
            p_h_db = PurshaseHistory(
                count=count_now,
                price=count_now * product_item_now.price,
                user_id=user_id,
                product_item_id=product_item_now.id,
            )
        await self.__uow.purshase_histories.add(p_h_db)

    async def _get_owner_by_product_item_id(self, product_item_id: int):
        owner_db = await self.__uow.product_items.get_owner_by_id(product_item_id)
        owner_id = owner_db.product.store.owner.id
        return owner_id
