from fastapi import Depends

from src.consts import *
from src.api_handlers import *
from src.database.base import AsyncSessionMaker
from src.services import NoteService, WorkerService
from src.dependies import *
from src.unit_of_work import IUnitOfWork, UnitOfWork


def create_uow():
    return UnitOfWork(AsyncSessionMaker)


def create_worker_service(
    uow: IUnitOfWork = Depends(create_uow),
):
    return WorkerService(
        uow,
        NoteService(),
        {
            API_BUY_ITEMS: BuyEndpointHandler(),
            API_BUY_ITEMS_FROM_BASKET: BuyFromBasketEndpointHandler(),
            API_BOOKING: BookingEndpointHandler(),
        },
    )
