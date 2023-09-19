from fastapi import APIRouter, Depends, Query
from fastapi_cache.decorator import cache

from src.authorization.authorization import AuthorizationService
from src.authorization.schemas import ResourceData
from src.config import OAuth2Scheme
from src.const import *
from src.authorization.dependies import factory_default_auth
from src.tag.const import *
from src.tag.dependies import create_tag_service
from src.tag.service import TagService


router = APIRouter(prefix="/tags", tags=["Tags"])


@router.get(
    "/all",
    summary="Получение всех возможных тегов",
    description="Получение всех тегов: возрастных, професиональных, занятия, темы фильтрация их по группам",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_all_tags(
    limit: int = Query(
        default=DEFAULT_LIMIT,
        ge=VALUE_NOT_LESS,
        le=DEFAULT_LIMIT,
        description="Количество тегов",
    ),
    offset: int = Query(
        default=DEFAULT_OFFSET, ge=VALUE_NOT_LESS, description="Номер партии (смещение)"
    ),
    group_ids: list[int] = Query(
        default=None, description="Список id групп тегов, которые должны быть"
    ),
    not_group_ids: list[int] = Query(
        default=None, description="Список id групп тегов, которых не должно быть"
    ),
    substr: str = Query(default=None, description="Подстрока для тэгов"),
    is_product_tags: bool = Query(
        default=None, description="Выводить теги продуктов или нет"
    ),
    tag_service: TagService = Depends(create_tag_service),
):
    return await tag_service.get_all(
        limit, offset, group_ids, not_group_ids, substr, is_product_tags
    )


@router.post(
    "/store_links",
    summary="Добавление тегов магазину",
    description="Добавление тегов магазину, предприятию, хэштеги, категории",
)
async def post_store_tag_links(
    store_id: int = Query(description="id магазина, куда добавлять теги"),
    tags: list[int] = Query(
        default=None, description="Список id групп тегов, которые нужно добавить"
    ),
    tag_names: list[str] = Query(
        default=None, description="Строки тегов, которые нужно добавить"
    ),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    tag_service: TagService = Depends(create_tag_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_STORE_TAG), token
    )
    return await tag_service.post_store_tag_links(store_id, tags, tag_names)


@router.post(
    "/product_links",
    summary="Добавление тегов продукту",
    description="Добавление тегов продукту, хэштеги, категории, типов. К чему относится товар, какой группе",
)
async def post_product_tag_links(
    product_id: int = Query(description="id продукта, куда добавлять теги"),
    tags: list[int] = Query(
        default=None, description="Список id групп тегов, которые нужно добавить"
    ),
    tag_names: list[str] = Query(
        default=None, description="Строки тегов, которые нужно добавить"
    ),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    tag_service: TagService = Depends(create_tag_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_PRODUCT_TAG), token
    )
    return await tag_service.post_product_tag_links(product_id, tags, tag_names)


@router.get(
    "/group_tag",
    summary="Получение групп тегов",
    description="Получение всех групп тегов",
)
@cache(expire=EXPIRES_HOUR_CACHE_ON_SECONDS)
async def get_group_tag(
    tag_service: TagService = Depends(create_tag_service),
):
    return await tag_service.get_all_groups()


@router.delete("/tag/any", summary="Удаление любого тега (store -> 1, product -> 2)")
async def delete_tag_any(
    tag_id: int = Query(description="Ид тега"),
    store_or_product_id: int = Query(
        default=None, description="Вводится если указан is_store_or_product"
    ),
    is_store_or_product: int = Query(
        default=None,
        description="None если тег пользователя, 1 если тег магазина, 2 если тег продукта",
    ),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    tag_service: TagService = Depends(create_tag_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_PRODUCT_TAG), token
    )
    return await tag_service.delete_tag_any(
        subject_data.id, tag_id, is_store_or_product, store_or_product_id
    )
