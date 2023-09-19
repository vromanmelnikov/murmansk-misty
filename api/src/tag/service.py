from src.authentication.exceptions import InvalidUserIdException
from src.database.models import *
from src.schemas.response_items import ResponseItemsSchema
from src.store.exceptions import DeleteProductItemException
from src.tag.exceptions import *
from src.tag.schemas import TagGroupSchema, TagWithGroupSchema
from src.user.exceptions import GetUserByIdException
from src.database.exceptions import *
from src.schemas.message import MessageSchema
from src.services.unit_of_work import IUnitOfWork
from src.utils import check_count_items
from src.tag.phrases import *


class TagService:
    def __init__(self, uow: IUnitOfWork):
        self.__uow = uow

    async def get_all(
        self,
        limit: int | None,
        offset: int | None,
        group_ids: list[int] | None,
        not_group_ids: list[int] | None,
        substr: str | None,
        is_product_tags: bool | None,
    ) -> ResponseItemsSchema[TagWithGroupSchema]:
        async with self.__uow:
            try:
                tags = await self.__uow.tags.get_all(
                    limit, offset, group_ids, not_group_ids, substr, is_product_tags
                )
                l = check_count_items(tags, TAGS_NOT_FOUND)
                return ResponseItemsSchema.Of(
                    [TagWithGroupSchema.from_orm(t) for t in tags], offset, l
                )
            except GetAllItemsException as e:
                raise GetAllTagsException(e.message) from e

    async def post_store_tag_links(
        self, store_id: int, tags: list[int] | None, tag_names: list[str] | None
    ):
        async with self.__uow:
            try:
                if tags:
                    for tag in tags:
                        is_exist_tag = await self.__uow.store_tag_links.get_by_id(
                            store_id, tag
                        )
                        if is_exist_tag is None:
                            await self.__uow.store_tag_links.add(
                                StoreTagLink(store_id=store_id, tag_id=tag)
                            )
                    await self.__uow.commit()
                if tag_names:
                    for tag in tag_names:
                        tag_db = await self.__uow.tags.get_one(name=tag)
                        if tag_db:
                            is_exist_tag = await self.__uow.store_tag_links.get_by_id(
                                store_id, tag_db.id
                            )
                            if is_exist_tag is None:
                                await self.__uow.store_tag_links.add(
                                    StoreTagLink(store_id=store_id, tag_id=tag_db.id)
                                )
                            await self.__uow.commit()
                        else:
                            tag_from_db = await self.__uow.tags.add(
                                Tag(name=tag, group_id=GROUP_MARKET_TAG_ID)
                            )
                            await self.__uow.store_tag_links.add(
                                StoreTagLink(store_id=store_id, tag_id=tag_from_db.id)
                            )
                            await self.__uow.commit()
                await self.__uow.commit()
                return MessageSchema(message=ADD_TAG_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException() from e
            except UniqueViolationException as e:
                raise AddStoreTagLinkException() from e
            except AddItemException as e:
                raise AddStoreTagLinkException() from e

    async def post_product_tag_links(
        self, product_id: int, tags: list[int] | None, tag_names: list[str]
    ):
        async with self.__uow:
            try:
                if tags:
                    for tag in tags:
                        is_exist_tag = await self.__uow.product_tag_links.get_by_id(
                            product_id, tag
                        )
                        if is_exist_tag is None:
                            await self.__uow.product_tag_links.add(
                                ProductTagLink(product_id=product_id, tag_id=tag)
                            )
                    await self.__uow.commit()
                if tag_names:
                    for tag in tag_names:
                        tag_db = await self.__uow.tags.get_one(name=tag)
                        if tag_db:
                            is_exist_tag = await self.__uow.product_tag_links.get_by_id(
                                product_id, tag_db.id
                            )
                            if is_exist_tag is None:
                                await self.__uow.product_tag_links.add(
                                    ProductTagLink(
                                        product_id=product_id, tag_id=tag_db.id
                                    )
                                )
                            await self.__uow.commit()
                        else:
                            tag_from_db = await self.__uow.tags.add(
                                Tag(name=tag, group_id=GROUP_MARKET_TAG_ID)
                            )
                            await self.__uow.product_tag_links.add(
                                ProductTagLink(
                                    product_id=product_id, tag_id=tag_from_db.id
                                )
                            )
                            await self.__uow.commit()
                await self.__uow.commit()
                return MessageSchema(message=ADD_TAG_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException() from e
            except UniqueViolationException as e:
                raise AddProductTagLinkException() from e
            except AddItemException as e:
                raise AddProductTagLinkException() from e

    async def get_all_groups(self):
        async with self.__uow:
            tag_groups = await self.__uow.tag_groups.get_all()
            return [TagGroupSchema.from_orm(t) for t in tag_groups]

    async def delete_tag_any(
        self,
        user_id: int,
        tag_id: int,
        is_store_or_product: int | None,
        store_or_product_id: int | None,
    ):
        async with self.__uow:
            try:
                user_db = await self.__uow.users.get_by_id(user_id)
                if user_db is None:
                    raise InvalidUserIdException(code=404)
                if is_store_or_product:
                    if store_or_product_id is None:
                        raise InvalidTagException(message=INVALID_TAG_ID, code=400)
                    if is_store_or_product == 1:
                        await self.__uow.store_tag_links.delete(
                            store_or_product_id, tag_id
                        )
                    if is_store_or_product == 2:
                        await self.__uow.product_tag_links.delete(
                            store_or_product_id, tag_id
                        )
                else:
                    await self.__uow.customer_tag_links.delete(user_id, tag_id)
                await self.__uow.commit()
                return MessageSchema(message=TAG_DELETE_SUCCESS)
            except GetItemByIdException as e:
                raise GetUserByIdException(code=status.HTTP_400_BAD_REQUEST) from e
            except DeleteItemException as e:
                raise DeleteProductItemException(
                    code=status.HTTP_400_BAD_REQUEST
                ) from e
