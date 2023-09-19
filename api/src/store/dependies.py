from fastapi import Depends

from src.authorization.dependies import FactoryAuthorizationService
from src.dependies import *
from src.services import *
from src.store.informants import *
from src.store.service import StoreService


def create_store_service(
    uow: IUnitOfWork = Depends(create_uow),
):
    return StoreService(uow)


def create_store_informant_service():
    return StoreResourceInformantService()


def create_product_informant_service():
    return ProductResourceInformantService()

def create_product_item_informant_service():
    return ProductItemResourceInformantService()

factory_store_auth = FactoryAuthorizationService(
    resource_InformantService=create_store_informant_service()
)
factory_product_auth = FactoryAuthorizationService(
    resource_InformantService=create_product_informant_service()
)
factory_product_item_auth = FactoryAuthorizationService(
    resource_InformantService=create_product_item_informant_service()
)
