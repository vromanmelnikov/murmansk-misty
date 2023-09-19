from fastapi import Depends

from src.authentication.service import AuthenticationService
from src.dependies import create_uow
from src.services import IUnitOfWork
from src.authentication.mappers import *


def create_authentication_service(
    uow: IUnitOfWork = Depends(create_uow),
):
    # media = TypeSelectMapperSchema(SourceMapper(), REPOSITORY_MEDIA)
    return AuthenticationService(uow)
