from fastapi import APIRouter, Depends, Query
from datetime import datetime
from fastapi_cache.decorator import cache

from src.authorization.authorization import AuthorizationService
from src.authorization.dependies import factory_default_auth
from src.authorization.schemas import ResourceData, UpdateUserData
from src.config import OAuth2Scheme
from src.const import *
from src.schemas.message import MessageSchema
from src.user.const import *
from src.user.dependies import create_user_service
from src.user.schemas import (
    BasketPostSchema,
    EventPostSchema,
    FavouritePostSchema,
    FriendPostSchema,
    ResetEmailSchema,
)
from src.user.service import UserService


router = APIRouter(prefix="/users", tags=["Users"])


@router.put(
    f"/{METHOD_RESET}_{RESOURCE_EMAIL}",
    summary="Смена email",
    description="Сменить email в своем аккаунте",
    response_model=MessageSchema,
)
async def reset_email(
    data: ResetEmailSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_RESET, ResourceData(name=RESOURCE_EMAIL), token
    )
    return await user_service.reset_email(subject_data, data)


@router.get(
    f"/{RESOURCE_PROFILE}/by_id",
    summary="Получить страницу пользователя",
    description="Получения профиль аккаунта пользователя: продавца, покупателя по id. Также получить (открыть) свой аккаунт",
)
async def get_profile_by_id(
    id: int | None = None,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_GET_BY_ID, ResourceData(id=id, name=RESOURCE_PROFILE), token
    )
    self_or_not_user_id = resource_data if resource_data.id else subject_data
    return await user_service.get_by_id(self_or_not_user_id.id)


@router.put(
    f"/{RESOURCE_PROFILE}",
    summary="Обновление данных акаунта",
    description="Изменение данных своего аккаунта, профиля: фамилия, имя, отчество, ФИО, даты рождения, пол",
)
async def update_profile(
    data: UpdateUserData,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_UPDATE, ResourceData(name=RESOURCE_PROFILE), token
    )
    return await user_service.update_profile(subject_data.id, data)


@router.post(
    "/tag_links",
    summary="Добавление тегов пользователю",
    description="Добавление тегов, характеристик, свойств пользователю в его акаунт, профиль",
)
async def post_customer_tag_links(
    tags: list[int] = Query(
        description="Список id групп тегов, которые нужно добавить"
    ),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.post_customer_tag_links(subject_data.id, tags)


@router.get(
    "/friends/types/all",
    summary="Получение списка типов близких",
    description="Получение всех примеров типов друзей, близких, отношений, родственников",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_friend_types(
    user_service: UserService = Depends(create_user_service),
):
    return await user_service.get_friend_types()


@router.get(
    "/friends/all",
    summary="Получение списка моих близких",
    description="Получение списка моих друзей, близких, родственников",
)
async def get_friends(
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество друзей",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    substr: str = Query(default=None, description="Поиск друга по его типу"),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    # denis
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.get_friends(subject_data.id, limit, offset, substr)


@router.post(
    "/friends",
    summary="Добавление в друзья",
    description="Добавление в друзья, в  близкие, отношения пользователей",
)
async def post_friend(
    friend: FriendPostSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    # denis
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.post_friend(subject_data.id, friend)


@router.delete(
    "/friends",
    summary="Удаление из друзей",
    description="Удаление из друзья, из  близких, убрать отношения пользователей",
)
async def delete_friend(
    friend_id: int,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    # denis
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.delete_friend(subject_data.id, friend_id)


@router.post(
    "/favourites",
    summary="Добавить единицу продукта в избранное",
    description="Добавить единицу продукта в избранное, обновить избранное, сделать единицу продукта избранной",
)
async def add_to_favourite(
    p_item: FavouritePostSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    # denis
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.add_to_favourite(subject_data.id, p_item)


@router.delete(
    "/favourites",
    summary="Удалить единицу продукта из избранного",
    description="Удалить единицу продукта из избранного, обновить избранное, убрать единицу продукта из избранного",
)
async def delete_from_favourite(
    item_id: int,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    # denis
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.delete_from_favourite(item_id)


@router.post(
    "/baskets",
    summary="Добавление в корзину единицы продукта (<0 убирает если тот же product_item_id)",
    description="Добавление в корзину единицы продукта, обновление корзины, изменить количество единиц товара в корзине",
)
async def add_to_basket(
    basket_item: BasketPostSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    # denis
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.add_to_basket(subject_data.id, basket_item)


@router.delete(
    "/baskets",
    summary="Удаление из корзины единицы продукта",
    description="Удаление из корзины единицы продукта, обновление корзины, убрать единицу продукта из корзины",
)
async def delete_from_basket(
    basket_item_id: int,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    # denis
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.delete_from_basket(basket_item_id)


@router.put(
    "/profile/money_on_cash",
    summary="Пополнить счет аккаунта",
    description="Пополнить счет аккаунта, перевести деньги на счет, обновить баланс, положить деньги на баланс",
)
async def put_money_on_cash(
    money: int = Query(description="Количество денег для пополнения"),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    # denis
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.put_money_on_cash(subject_data.id, money)


@router.post(
    "/events",
    summary="Забронировать услугу / Записать событие(если услуга, то в details product_id)",
    description="Забронировать услугу / Записать событие, добавить в события, добавить в календарь событий",
)
async def post_event(
    event: EventPostSchema,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_EVENT), token
    )
    return await user_service.post_event(
        subject_data.id if subject_data.role_id != ROLE_BOT else event.user_id,
        event,
    )


@router.delete(
    "/events",
    summary="Удаление события / Отмена брони услуги",
    description="Удаление события / Отмена брони услуги, снятие брони, обновление календаря событий",
)
async def delete_event(
    event_id: int,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    # denis
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.delete_event(subject_data.id, event_id)


@router.get(
    "/baskets/my",
    summary="Получение корзины конкретного пользователя",
    description="Получение корзины конкретного пользователя, моя корзина, мои товары в корзине, получение моей корзины с товарами",
)
async def get_basket_by_user_id(
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество единиц продукта",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    substr: str = Query(
        default=None, description="Поиск по подстроке единицы продукта"
    ),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.basket_by_user_id(subject_data.id, limit, offset, substr)


@router.get(
    "/events/all",
    summary="Получение событий конкретного пользователя",
    description="Получение событий конкретного пользователя, мои события, получить мой календарь событий, календарь пользователя",
)
async def get_events_all(
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество событий",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    substr: str = Query(default=None, description="Поиск по подстроке события"),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.get_events_all(subject_data.id, limit, offset, substr)


@router.get(
    "/favourites/by_user_id",
    summary="Получение избранных единиц продуктов конкретного пользователя",
    description="Получение избранных единиц продуктов конкретного пользователя, мои избранные, получение избранных единиц продуктов",
)
async def get_basket_by_user_id(
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество единиц продукта",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    substr: str = Query(
        default=None, description="Поиск по подстроке единицы продукта"
    ),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.favourite_by_user_id(
        subject_data.id, limit, offset, substr
    )


@router.get(
    "/profile/purshases/history",
    summary="История покупок конкретного пользователя",
    description="История покупок конкретного пользователя, узнать что я купил, моя история приобретения товаров",
)
async def get_my_purshase_history(
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество единиц продукта",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    date: datetime = Query(
        default=None, description="Фильтрация по дате (по возрастанию/по убыванию)"
    ),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.get_my_purshase_history(
        subject_data.id, limit, offset, date
    )


@router.get(
    "/recommend_by_relative",
    summary="Рекомедация по родственникам",
    description="Рекомедация по родственникам",
)
async def get_recommend_by_relative(
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество единиц продукта",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    friend_type: list[str] = Query(
        default=None, description="Тип родственника (группировка через 'или')"
    ),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    user_service: UserService = Depends(create_user_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_TAG_USER), token
    )
    return await user_service.get_recommend_by_relative(
        subject_data.id, limit, offset, friend_type
    )
