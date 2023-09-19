from fastapi import APIRouter, Depends, Query
from fastapi_cache.decorator import cache

from src.const import *
from src.store.schemas import *
from src.authorization.authorization import AuthorizationService
from src.authorization.schemas import ResourceData
from src.config import OAuth2Scheme
from src.const import METHOD_ADD, METHOD_UPDATE
from src.store.const import *
from src.store.dependies import *
from src.store.schemas import StorePostSchema, StoreUpdateSchema
from src.store.service import StoreService
from src.authorization.dependies import factory_default_auth


router = APIRouter(prefix="/stores", tags=["Stores"])


@router.post(
    "/",
    summary="Создание предприятия",
    description="Создание, добавление предприятия, магазина, сервиса услуг, площадки для продажи",
)
async def post(
    store: StorePostSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_STORE), token
    )
    return await shop_service.post(subject_data.id, store)


@router.put(
    "/",
    summary="Изменение предприятия",
    description="Изменение данных предприятия, поменять, обновить данные магазина, площадки по продажам, сервиса услуг",
)
async def put(
    store: StoreUpdateSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_store_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_UPDATE, ResourceData(id=store.id, name=RESOURCE_STORE), token
    )
    return await shop_service.put(store)


@router.post(
    "/products",
    summary="Создание продукта",
    description="Создание продукта в магазин, предприятие, добавление товара, услуги",
)
async def post_product(
    product: ProductPostSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_store_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(id=product.store_id, name=RESOURCE_PRODUCT), token
    )
    return await shop_service.post_product(subject_data.id, product)


@router.put(
    "/products",
    summary="Изменение продукта",
    description="Изменение своего продукта у магазина, обновление данных продукта, товара, услуги у предприятия, сервиса",
)
async def put_product(
    product: ProductUpdateSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_product_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_UPDATE, ResourceData(id=product.id, name=RESOURCE_PRODUCT), token
    )
    return await shop_service.put_product(subject_data.id, product)


@router.post(
    "/products/items",
    summary="Создание единицы продукта",
    description="Создание единицы (элемента) продукта, подпродукта, (добавление) услуги у магазина, предприятия, сервиса",
)
async def post_product_item(
    product_item: ProductItemPostSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_product_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD,
        ResourceData(id=product_item.product_id, name=RESOURCE_PRODUCT_ITEM),
        token,
    )
    return await shop_service.post_product_item(subject_data.id, product_item)


@router.put(
    "/products/items",
    summary="Изменение единицы продукта",
    description="Изменение единицы подпродукта, единицы товара, обновление цены, количества товаров услуг",
)
async def put_product_item(
    product_item: ProductItemUpdateSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_product_item_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_UPDATE,
        ResourceData(id=product_item.id, name=RESOURCE_PRODUCT_ITEM),
        token,
    )
    return await shop_service.put_product_item(subject_data.id, product_item)


@router.put(
    "/products/items/buy",
    summary="Покупка единицы продукта",
    description="Покупка продукта, купить товар, приобрести единицу товара",
)
async def buy_product_item(
    product_item: BuyProductItemSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_BUY, ResourceData(name=RESOURCE_PRODUCT_ITEM), token
    )
    return await shop_service.buy_product_item(
        subject_data.id if subject_data.role_id != ROLE_BOT else product_item.user_id,
        product_item,
    )


@router.delete(
    "/products/items/buy_from_basket",
    summary="Покупка единицы продукта из корзины",
    description="Покупка единицы продукта, подпродукта, товара, купить находящегося в корзине. Товар отложен",
)
async def buy_from_basket(
    basket_id: int,
    user_id: int | None = None,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_BUY, ResourceData(name=RESOURCE_PRODUCT_ITEM), token
    )
    return await shop_service.buy_from_basket(
        subject_data.id if subject_data.role_id != ROLE_BOT else user_id,
        basket_id,
    )


@router.get(
    "/all",
    summary="Получение списка магазинов",
    description="Получение списка всех магазинов, предприятий, сервисов, поиск, просмотр, найти",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_all(
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество магазинов",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    substr: str = Query(default=None, description="Подстрока для магазинов"),
    tag_ids: list[int] = Query(default=None, description="Теги для магазинов"),
    shop_service: StoreService = Depends(create_store_service),
):
    return await shop_service.get_all(limit, offset, substr, tag_ids)


@router.get(
    "/by_id",
    summary="Получение магазина по id",
    description="Получение магазина по id, получение конкретного магазина, посмотреть информацию о магазине",
)
async def store_get_by_id(
    store_id: int,
    shop_service: StoreService = Depends(create_store_service),
):
    return await shop_service.get_by_id(store_id)


@router.get(
    "/products/all",
    summary="Получение списка товаров и услуг магазина",
    description="Получение списка всех продуктов, товаров, услуг магазина, прдприятия, сервиса, поиск, просмотр, найти",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_all_products(
    store_id: int = Query(default=None, description="id магазина"),
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество продуктов",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    substr: str = Query(default=None, description="Подстрока для продуктов"),
    tag_ids: list[int] = Query(default=None, description="Теги для магазинов"),
    is_service: bool = Query(
        default=None,
        description="Показывать товары или услуги, если None то все вместе",
    ),
    shop_service: StoreService = Depends(create_store_service),
):
    return await shop_service.get_all_products(
        store_id, limit, offset, substr, tag_ids, is_service
    )


@router.get(
    "/products/characteristics/all",
    summary="Получение списка всех возможных характеристик товаров",
    description="Получение всех списка всех возможных характеристик товаров, услуг, параметры, показатели продуктов",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_all_characteristics(
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество характеристик",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    substr: str = Query(default=None, description="Подстрока для характеристик"),
    shop_service: StoreService = Depends(create_store_service),
):
    return await shop_service.get_all_characteristics(limit, offset, substr)


@router.get(
    "/products/feedbacks/by_product_id",
    summary="Получение отзывов товара",
    description="Получение всех отзывов товаров, оценки продуктов, комментарии, пользователи",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_product_feedbacks_by_product_id(
    product_id: int = Query(description="Ид товара"),
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество отзывов",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    count: int = Query(default=None, description="большем чем количество лайков"),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_BUY, ResourceData(name=RESOURCE_PRODUCT_ITEM), token
    )
    return await shop_service.get_product_feedbacks_by_product_id(
        subject_data.id, product_id, limit, offset, count
    )


@router.get(
    "/products/by_product_id",
    summary="Получение единиц продукта",
    description="Получение списка всех единиц возможных (типов) конкретного продукта, товара, услуги",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_product_items_by_product_id(
    product_id: int = Query(description="Ид товара"),
    shop_service: StoreService = Depends(create_store_service),
):
    return await shop_service.get_product_items_by_product_id(product_id)


@router.post(
    "/products/feedbacks",
    summary="Добавление отзыва продукту",
    description="Добавление отзыва, комментария, оценки продукту, товару, услуге",
)
async def post_product_feedback(
    prod_feed: ProductFeedbackPostSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_FEEDBACK), token
    )
    return await shop_service.post_product_feedback(subject_data.id, prod_feed)


@router.post(
    "/products/feedbacks/like",
    summary="Оценить отзыв",
    description="Добавление или удаление (если он уже есть) лайка отзыву комментарию ",
)
async def post_like_delete(
    like: LikePostSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    shop_service: StoreService = Depends(create_store_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_LIKE), token
    )
    return await shop_service.post_like_delete(subject_data.id, like)
