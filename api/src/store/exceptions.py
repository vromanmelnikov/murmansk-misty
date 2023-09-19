from fastapi import status

from src.database.exceptions import DBException
from src.exceptions import ServiceException
from src.store.phrases import (
    INVALID_COUNT_ITEM_ID,
    INVALID_LIKE,
    INVALID_LIKE_EXIST,
    INVALID_PRODUCT_FEEDBACK,
    INVALID_PRODUCT_ID,
    INVALID_PRODUCT_ITEM_ID,
    INVALID_PRODUCT_NO_FEEDBACK,
    INVALID_SHOP_ID,
    INVALID_USER_ID,
)


class AddStoreException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class AddProductException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class AddProductItemException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class DeleteProductItemException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class UpdateUserException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetShopByIdException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetProductFeedbackByIdException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class InvalidShopIdException(ServiceException):
    def __init__(
        self, message: str = INVALID_SHOP_ID, code: int = status.HTTP_401_UNAUTHORIZED
    ):
        super().__init__(message=message, code=code)


class InvalidProductFeedbackException(ServiceException):
    def __init__(
        self,
        message: str = INVALID_PRODUCT_FEEDBACK,
        code: int = status.HTTP_401_UNAUTHORIZED,
    ):
        super().__init__(message=message, code=code)


class InvalidProductFeedbackNoException(ServiceException):
    def __init__(
        self,
        message: str = INVALID_PRODUCT_NO_FEEDBACK,
        code: int = status.HTTP_401_UNAUTHORIZED,
    ):
        super().__init__(message=message, code=code)


class AddLikeException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_401_UNAUTHORIZED):
        super().__init__(message=message, code=code)


class InvalidShopIdExceptionCheckUser(ServiceException):
    def __init__(
        self, message: str = INVALID_USER_ID, code: int = status.HTTP_401_UNAUTHORIZED
    ):
        super().__init__(message=message, code=code)


class InvalidLikeException(ServiceException):
    def __init__(
        self,
        message: str = INVALID_LIKE_EXIST,
        code: int = status.HTTP_401_UNAUTHORIZED,
    ):
        super().__init__(message=message, code=code)


class InvalidProuctItemByIdException(ServiceException):
    def __init__(
        self,
        message: str = INVALID_PRODUCT_ITEM_ID,
        code: int = status.HTTP_401_UNAUTHORIZED,
    ):
        super().__init__(message=message, code=code)


class GetLikeByIdException(ServiceException):
    def __init__(
        self,
        message: str = INVALID_PRODUCT_ITEM_ID,
        code: int = status.HTTP_401_UNAUTHORIZED,
    ):
        super().__init__(message=message, code=code)


class DeleteLikeException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_401_UNAUTHORIZED):
        super().__init__(message=message, code=code)


class DeleteBasketException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_401_UNAUTHORIZED):
        super().__init__(message=message, code=code)


class InvalidBuyProductItemException(ServiceException):
    def __init__(
        self,
        message: str = INVALID_COUNT_ITEM_ID,
        code: int = status.HTTP_401_UNAUTHORIZED,
    ):
        super().__init__(message=message, code=code)

class InvalidBusketException(ServiceException):
    def __init__(
        self,
        message: str,
        code: int = status.HTTP_401_UNAUTHORIZED,
    ):
        super().__init__(message=message, code=code)

class InvalidProductIdException(ServiceException):
    def __init__(
        self,
        message: str = INVALID_PRODUCT_ID,
        code: int = status.HTTP_401_UNAUTHORIZED,
    ):
        super().__init__(message=message, code=code)


class UpdateStoreException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class UpdateProductException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class UpdateProductItemException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetProductByIdException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetProductItemByIdException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetAllStoreException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetAllProductException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetAllCharacteristicException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class AddProductFeedbackException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class InvalidLikeNoException(ServiceException):
    def __init__(
        self,
        message: str = INVALID_LIKE,
        code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
    ):
        super().__init__(message=message, code=code)
