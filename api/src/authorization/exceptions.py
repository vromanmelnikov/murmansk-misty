from fastapi import status
from src.authorization.phrases import *

from src.exceptions import ServiceException


class NoAccessAuthorizationException(ServiceException):
    def __init__(
        self,
        message: str = NO_ACCESS,
        code: int = status.HTTP_401_UNAUTHORIZED,
    ):
        super().__init__(message=message, code=code)


class DBAuthorizationException(ServiceException):
    def __init__(self, message: str, code: int = status.HTTP_500_INTERNAL_SERVER_ERROR):
        super().__init__(message=message, code=code)
