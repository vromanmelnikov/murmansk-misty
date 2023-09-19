from fastapi import status

from src.database.exceptions import DBException
from src.exceptions import ServiceException


class GetAllTagsException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class GetAllTagGroupException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class AddStoreTagLinkException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)


class AddProductTagLinkException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)

class InvalidTagException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)