from abc import ABC, abstractmethod
from datetime import datetime, timedelta
import requests

from src.consts import *
from src.config import settings
from src.database.models.others.tasks import Task


class EndpointHandlerBase(ABC):
    @abstractmethod
    async def execute(self, task: Task):
        raise NotImplementedError()


class BuyEndpointHandler(EndpointHandlerBase):
    async def execute(self, task: Task):
        item_id = task.details["product_item_id"]
        count = task.details["product_count"]
        user_id = task.user_id
        r = requests.put(
            f"{settings.API_URL}{task.path}",
            json={"count": count, "product_id": item_id, "user_id": user_id},
            headers={"Authorization": f"{settings.TOKEN_TYPE} {settings.ACCESS_TOKEN}"},
        )
        product_name = task.details.get("product_name", "")
        res = r.json()
        message = f'Товар "{product_name}": {res["message"]}'
        if r.status_code != 200:
            if res["details"] == INVALID_BUSKET_MONEY_COUNT:
                task.is_active = False
            message = f"Покупка товара '{product_name}' из магазина: {res['details']}"
        return message, user_id


class BuyFromBasketEndpointHandler(EndpointHandlerBase):
    async def execute(self, task: Task):
        basket_id = task.details["basket_id"]
        user_id = task.user_id
        r = requests.delete(
            f"{settings.API_URL}{task.path}?basket_id={basket_id}&user_id={user_id}",
            headers={"Authorization": f"{settings.TOKEN_TYPE} {settings.ACCESS_TOKEN}"},
        )
        res = r.json()
        product_name = task.details.get("product_name", "")
        message = f'Товар "{product_name}": {res["message"]}'
        if r.status_code != 200:
            if res["details"] == INVALID_BUSKET_MONEY_COUNT:
                task.is_active = False
            message = f"Покупка товара '{product_name}' из корзины: {res['details']}"
        return message, user_id


class BookingEndpointHandler(EndpointHandlerBase):
    async def execute(self, task: Task):
        product_item_id = task.details["product_item_id"]
        product_name = task.details.get("product_name", "")
        user_id = task.user_id
        now = datetime.utcnow()
        time_booking = task.details.get("time_booking", now + timedelta(days=3))
        user_id = task.user_id
        data = {
            "user_id": user_id,
            "description": f"Бронирование услуги {product_name}",
            "time": str(time_booking),
            "details": {"product_id": product_item_id},
        }
        r = requests.post(
            f"{settings.API_URL}{API_EVENTS}",
            json=data,
            headers={"Authorization": f"{settings.TOKEN_TYPE} {settings.ACCESS_TOKEN}"},
        )
        res = r.json()
        product_name = task.details.get("product_name", "")
        msg_begin = f'Бронирование услуги "{product_name}"'
        message = f'{msg_begin}: {res["message"]}'
        if r.status_code != 200:
            if res["details"] == INVALID_BUSKET_MONEY_COUNT:
                task.is_active = False
            message = f"{msg_begin}: {res['details']}"
        return message, user_id
