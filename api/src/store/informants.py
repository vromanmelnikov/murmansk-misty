from src.authorization.informants import IResourceInformantService
from src.authorization.schemas import *
from src.database.exceptions import GetItemByIdException
from src.exceptions import NotFoundException
from src.services.unit_of_work import IUnitOfWork
from src.store.phrases import INVALID_PRODUCT_ID, INVALID_PRODUCT_ITEM_ID, INVALID_SHOP_ID


class StoreResourceInformantService(IResourceInformantService):
    async def get(self, resource: ResourceData, uow: IUnitOfWork) -> ResourceData:
        try:
            store = await uow.stores.get_by_id(resource.id)
            if store is None:
                raise NotFoundException(INVALID_SHOP_ID)
            resource.id = store.id
            resource.owner_id = store.owner_id
            return resource
        except GetItemByIdException as e:
            raise e


class ProductResourceInformantService(IResourceInformantService):
    async def get(self, resource: ResourceData, uow: IUnitOfWork) -> ResourceData:
        try:
            product = await uow.products.get_with_org(resource.id)
            if product is None:
                raise NotFoundException(INVALID_PRODUCT_ID)
            resource.owner_id = product.store.owner_id
            return resource
        except GetItemByIdException as e:
            raise e


class ProductItemResourceInformantService(IResourceInformantService):
    async def get(self, resource: ResourceData, uow: IUnitOfWork) -> ResourceData:
        try:
            product_item = await uow.product_items.get_by_id(resource.id)
            if product_item is None:
                raise NotFoundException(INVALID_PRODUCT_ITEM_ID)
            product = await uow.products.get_with_org(product_item.product_id)
            if product is None:
                raise NotFoundException(INVALID_PRODUCT_ID)
            resource.owner_id = product.store.owner_id
            return resource
        except GetItemByIdException as e:
            raise e
