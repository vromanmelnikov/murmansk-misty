import vakt
from vakt.rules import Eq, Truthy, Any

from src.task.consts import RESOURCE_TASK
from src.const import *
from src.file_operator.const import RESOURCE_FILE
from src.store.const import *
from src.tag.const import RESOURCE_PRODUCT_TAG, RESOURCE_STORE_TAG
from src.user.const import *
from src.utils import IncrementorId

Incrementor = IncrementorId()

politicians = [
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_RESET)],
        resources=[Eq(RESOURCE_EMAIL)],
        subjects=[Any()],
        effect=vakt.ALLOW_ACCESS,
        description="Всем разрешено менять почту",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_GET_BY_ID)],
        resources=[Eq(RESOURCE_PROFILE)],
        subjects=[Any()],
        effect=vakt.ALLOW_ACCESS,
        description="Всем разрешено получать аккаунт по id",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_UPDATE)],
        resources=[{"name": Eq(RESOURCE_PROFILE), "is_owner": Truthy()}],
        subjects=[Any()],
        effect=vakt.ALLOW_ACCESS,
        description="Редактировать аккаунт разрешено только создателю",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_ADD)],
        resources=[
            Eq(RESOURCE_FILE),
            Eq(RESOURCE_TASK),
            Eq(RESOURCE_STORE),
            Eq(RESOURCE_TAG_USER),
        ],
        subjects=[
            {"role": Eq(ROLE_CUSTOMER)},
            {"role": Eq(ROLE_SELLER)},
            {"role": Eq(ROLE_BOT)},
        ],
        effect=vakt.ALLOW_ACCESS,
        description="Разрешено добавлять файлы, предприятия и теги к себе в профиль только покупателям и продавцам",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_DELETE)],
        resources=[{"name": Eq(RESOURCE_FILE), "is_owner": Truthy()}],
        subjects=[
            {"role": Eq(ROLE_CUSTOMER)},
            {"role": Eq(ROLE_SELLER)},
            {"role": Eq(ROLE_BOT)},
        ],
        effect=vakt.ALLOW_ACCESS,
        description="Разрешено удалять свои файлы только покупателям и продавцам",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_UPDATE)],
        resources=[{"name": Eq(RESOURCE_STORE), "is_owner": Truthy()}],
        subjects=[{"role": Eq(ROLE_SELLER)}, {"role": Eq(ROLE_BOT)}],
        effect=vakt.ALLOW_ACCESS,
        description="Разрешено изменять данные предприятия только продавцам своих магазинов",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_ADD), Eq(METHOD_UPDATE)],
        resources=[
            {"name": Eq(RESOURCE_PRODUCT), "is_owner": Truthy()},
            {"name": Eq(RESOURCE_PRODUCT_ITEM), "is_owner": Truthy()},
        ],
        subjects=[{"role": Eq(ROLE_SELLER)}, {"role": Eq(ROLE_BOT)}],
        effect=vakt.ALLOW_ACCESS,
        description="Разрешено добавлять и изменять свои продукты (по предприятиям), подтипы своих продуктов только продавцам",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_BUY)],
        resources=[Eq(RESOURCE_PRODUCT_ITEM)],
        subjects=[
            {"role": Eq(ROLE_CUSTOMER)},
            {"role": Eq(ROLE_SELLER)},
            {"role": Eq(ROLE_BOT)},
        ],
        effect=vakt.ALLOW_ACCESS,
        description="Разрешено покупать единицы товара только покупателям и продавцам",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_ADD)],
        resources=[Eq(RESOURCE_STORE_TAG), Eq(RESOURCE_PRODUCT_TAG)],
        subjects=[{"role": Eq(ROLE_SELLER)}, {"role": Eq(ROLE_BOT)}],
        effect=vakt.ALLOW_ACCESS,
        description="Разрешено добавлять теги магазинам и единицам товара только продавцам",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_GET_BY_ID)],
        resources=[Eq(RESOURCE_TASK)],
        subjects=[{"role": Eq(ROLE_CUSTOMER)}, {"role": Eq(ROLE_SELLER)}],
        effect=vakt.ALLOW_ACCESS,
        description="Разрешено получать свои задачи покупателям и продавцам",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_ADD)],
        resources=[Eq(RESOURCE_FEEDBACK), Eq(RESOURCE_LIKE)],
        subjects=[{"role": Eq(ROLE_CUSTOMER)}, {"role": Eq(ROLE_SELLER)}],
        effect=vakt.ALLOW_ACCESS,
        description="Разрешено добавлять отзывы и лайки покупателям и продавцам",
    ),
    vakt.Policy(
        Incrementor.get_value(),
        actions=[Eq(METHOD_ADD)],
        resources=[Eq(RESOURCE_EVENT)],
        subjects=[
            {"role": Eq(ROLE_CUSTOMER)},
            {"role": Eq(ROLE_SELLER)},
            {"role": Eq(ROLE_BOT)},
        ],
        effect=vakt.ALLOW_ACCESS,
        description="Разрешено добавлять события покупателям продавцам и ботам",
    ),
]
