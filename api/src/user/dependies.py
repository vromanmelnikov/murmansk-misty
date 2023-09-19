from fastapi import Depends
from src.authorization.dependies import FactoryAuthorizationService

from src.dependies import *
from src.services import *
from src.user.service import UserService


def create_user_service(
    uow: IUnitOfWork = Depends(create_uow),
):
    return UserService(uow)


# def create_link_InformantService():
#     return LinkInformantService()

factory_user_auth = FactoryAuthorizationService(
    # resource_InformantService=create_link_InformantService()
)
