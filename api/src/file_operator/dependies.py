from fastapi import Depends
from src.authorization.dependies import FactoryAuthorizationService

from src.dependies import *
from src.file_operator.informants import FileResourceInformantService
from src.file_operator.service import FileService
from src.services import *


def create_file_service(
    uow: IUnitOfWork = Depends(create_uow),
):
    return FileService(uow)


def create_file_informant_service():
    return FileResourceInformantService()


factory_file_auth = FactoryAuthorizationService(
    resource_InformantService=create_file_informant_service()
)
