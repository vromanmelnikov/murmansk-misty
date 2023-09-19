from fastapi import Depends

from src.dependies import *
from src.services import *
from src.tag.service import TagService


def create_tag_service(
    uow: IUnitOfWork = Depends(create_uow),
):
    return TagService(uow)
