from fastapi import APIRouter, Depends, Security
from fastapi.security import (
    HTTPAuthorizationCredentials,
    HTTPBearer,
    OAuth2PasswordRequestForm,
)

from src.authentication.constants import *
from src.authentication.dependies import create_authentication_service
from src.authentication.schemas import *
from src.authentication.service import AuthenticationService
from src.background_tasks.base import *
from src.schemas.message import MessageSchema

router = APIRouter(prefix=f"/{AUTH}", tags=["Auth"])
security = HTTPBearer()


@router.post(
    PATH_SIGNIN,
    response_model=TokenSchema,
    summary="Аутенфикация",
    description="Авторизация, аутенфикация, вход в аккаунт, залогиниться",
)
async def login_for_access_token(
    form_data: OAuth2PasswordRequestForm = Depends(),
    authentication_service: AuthenticationService = Depends(
        create_authentication_service
    ),
):
    token, email = await authentication_service.login(form_data)
    send_warn_signin.delay(email)
    return token


@router.post(
    "/refresh_token",
    response_model=TokenSchema,
    summary="Обновление токена",
    description="Обновление токена, токен истек, служебное, аутенфикация, refresh токен",
)
async def refresh_access_token(
    credentials: HTTPAuthorizationCredentials = Security(security),
    authentication_service: AuthenticationService = Depends(
        create_authentication_service
    ),
):
    return authentication_service.refresh_token(credentials)


@router.post(
    "/signup",
    summary="Регистрация",
    description="Зарегистрироваться, регистрация, создать аккаунт",
    response_model=MessageSchema,
)
async def register(
    user: UserLoginSchema,
    authentication_service: AuthenticationService = Depends(
        create_authentication_service
    ),
):
    message, email = await authentication_service.register(user)
    send_greeting.delay(email)
    return message


@router.post(
    "/password/recover",
    response_model=MessageSchema,
    summary="Востановление пароля",
    description="Востановить пароль, заявка на смену пароля, запрос, забыл пароль",
)
async def recover_password(
    data: RecoverPasswordSchema,
    authentication_service: AuthenticationService = Depends(
        create_authentication_service
    ),
):
    message, url, email = await authentication_service.recover_password(data)
    send_url.delay(email, url)
    return message


@router.post(
    "/password/reset",
    response_model=MessageSchema,
    summary="Сменить пароль",
    description="Смена пароля, новый пароль, после получения кода на почте",
)
async def reset_password(
    data: ResetPasswordSchema,
    authentication_service: AuthenticationService = Depends(
        create_authentication_service
    ),
):
    return await authentication_service.reset_password(data)
