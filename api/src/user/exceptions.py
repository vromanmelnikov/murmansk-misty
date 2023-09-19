from fastapi import status

from src.database.exceptions import DBException
from src.exceptions import ServiceException
from src.user.phrases import (
    ADD_CUSTOMER_TAG_FAILED,
    ADD_EVENT_EXCEPTION,
    ADD_FRIEND_EXCEPTION,
    ADD_PRODUCT_ITEM_EXCEPTION,
    EXIST_EVENT_EXCEPTION,
    GET_USER_BY_ID_EXCEPTION,
    RESET_EMAIL_FAILED,
)


class GetUserByEmailException(DBException):
    """Ошибка получения пользователя по email"""

    def __init__(self, email: str):
        super().__init__(f"Не удалось получить пользователя по email {email}")


class GetAvailableRolesException(DBException):
    """Ошибка получения доступных ролей"""

    def __init__(self, email: str):
        super().__init__(f"Не удалось получить доступные роли")


class GetResetEmailException(ServiceException):
    def __init__(
        self,
        message: str = RESET_EMAIL_FAILED,
        code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
    ):
        super().__init__(message=message, code=code)


class GetUserByIdException(ServiceException):
    def __init__(
        self,
        message: str = GET_USER_BY_ID_EXCEPTION,
        code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
    ):
        super().__init__(message=message, code=code)


class AddCustomerTagLinkException(ServiceException):
    def __init__(
        self,
        message: str = ADD_CUSTOMER_TAG_FAILED,
        code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
    ):
        super().__init__(message=message, code=code)


class UserUpdateException(ServiceException):
    def __init__(
        self,
        message: str = GET_USER_BY_ID_EXCEPTION,
        code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
    ):
        super().__init__(message=message, code=code)


class AddFriendException(ServiceException):
    def __init__(
        self,
        message: str = ADD_FRIEND_EXCEPTION,
        code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
    ):
        super().__init__(message=message, code=code)


class AddProductItemException(ServiceException):
    def __init__(
        self,
        message: str = ADD_PRODUCT_ITEM_EXCEPTION,
        code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
    ):
        super().__init__(message=message, code=code)


class AddEventException(ServiceException):
    def __init__(
        self,
        message: str = ADD_EVENT_EXCEPTION,
        code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
    ):
        super().__init__(message=message, code=code)


class InvalidEventException(ServiceException):
    def __init__(
        self,
        message: str = EXIST_EVENT_EXCEPTION,
        code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
    ):
        super().__init__(message=message, code=code)


class GetAllFriendsException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetFriendByIdException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetAllItemsException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)
