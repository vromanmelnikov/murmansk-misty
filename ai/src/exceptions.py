# from fastapi import status


# class BaseAppException(Exception):
#     def __init__(self, message: str):
#         self.message = message


# class ServiceException(BaseAppException):
#     def __init__(self, message: str, code: int):
#         super().__init__(message)
#         self.code = code


# class NotFoundException(ServiceException):
#     def __init__(self, message: str):
#         super().__init__(message, status.HTTP_404_NOT_FOUND)


# class BadRequest(ServiceException):
#     def __init__(self, message: str):
#         super().__init__(message, status.HTTP_400_BAD_REQUEST)
