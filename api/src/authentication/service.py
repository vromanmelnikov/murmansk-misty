import secrets
from fastapi.security import HTTPAuthorizationCredentials, OAuth2PasswordRequestForm
from fastapi import status
from pydantic import ValidationError
from passlib.context import CryptContext
import jwt
from jose import JWTError
from datetime import datetime, timedelta

from src.authentication.constants import *
from src.authentication.exceptions import *
from src.authentication.mappers import *
from src.authentication.phrases import *
from src.authentication.schemas import *
from src.const import *
from src.database.exceptions import *
from src.mappers import RecordRedisMapper

from src.schemas import *
from src.config import settings
from src.services.unit_of_work import IUnitOfWork
from src.user.exceptions import GetUserByEmailException


class AuthenticationService:
    def __init__(self, uow: IUnitOfWork):
        self.__pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
        self.__uow = uow

    def refresh_token(self, credentials: HTTPAuthorizationCredentials):
        data = self.decode_token(credentials.credentials, REFRESH_TOKEN)
        return self.__generate_tokens(data)

    async def login(self, form_data: OAuth2PasswordRequestForm):
        async with self.__uow:
            try:
                user_login = UserLoginMapper().create_from_input(form_data)
                user_db = await self.__check_exist_user(
                    user_login.email, self.__uow, False
                )

                if user_db is None:
                    raise InvalidUsernameException() from None
                if not self.__verify_password(
                    form_data.password, user_db.hashed_password
                ):
                    raise InvalidPasswordException() from None
                return (
                    self.__generate_tokens(
                        TokenDataSchema.Of(user_db.id, user_db.role_id)
                    ),
                    user_db.email,
                )
            except GetUserByEmailException as e:
                raise LoginException(e.message) from e
            except ValidationError:
                raise IncorrectEmailException()

    async def reset_password(self, data: ResetPasswordSchema):
        async with self.__uow:
            try:
                record = await self.__uow.pswd_recoveries.pop(data.code)
                if record:
                    email = PasswordRecoveryMapper().create_from_database(record)
                    user = await self.__check_exist_user(email, self.__uow, False)
                    user.hashed_password = self.__get_password_hash(data.password)
                    await self.__uow.users.update(user)
                    await self.__uow.commit()
                    return MessageSchema(message=PASSWORD_SUCCESS_RESET)
                raise ResetPasswordException(CODE_INVALID, status.HTTP_400_BAD_REQUEST)
            except UpdateItemException as e:
                raise ResetPasswordException() from e

    async def recover_password(self, data: RecoverPasswordSchema):
        async with self.__uow:
            try:
                await self.__check_exist_user(data.email, self.__uow, False)
                key = secrets.token_urlsafe(16)
                record = RecordRedisMapper().create_from_input(
                    key, data.email, EXPIRES_10_MIN_CACHE_ON_SECONDS
                )
                if await self.__uow.pswd_recoveries.add(record):
                    return (
                        MessageSchema(message=URL_SEND_SUCCESS),
                        f"{settings.URL_FRONTEND}/auth/reset?code={key}",
                        data.email,
                    )
                raise RecoveryPasswordException()
            except AddItemException as e:
                raise RecoveryPasswordException() from e

    async def register(self, user: UserLoginSchema):
        async with self.__uow:
            try:
                await self.__add_simple_person(user, self.__uow, UserMapper())
                await self.__uow.commit()
                return (MessageSchema(message=REGISTATION_SUCCESS), user.email)
            except (UniqueViolationException, ForeignKeyViolationException) as e:
                raise RegisterPublicException(
                    e.message, status.HTTP_400_BAD_REQUEST
                ) from e
            except AddItemException as e:
                raise RegisterPublicException(REGISTATION_FAILED) from e

    def decode_token(self, token: str, scope: str) -> TokenDataSchema:
        try:
            payload = jwt.decode(
                token, settings.SECRET_STRING, algorithms=[settings.ALGORITHM]
            )
            if payload[PAYLOAD_NAME_SCOPE] == scope:
                user_id = payload.get(PAYLOAD_NAME_SUB_ID)
                role_id = payload.get(PAYLOAD_NAME_SUB_ROLE_ID)
                if user_id and role_id:
                    return TokenDataSchema.Of(user_id, role_id)
                raise InvalidCredentialsException() from None
            raise ScopeTokenInvalidException() from None

        except jwt.ExpiredSignatureError:
            raise TokenExpiredException() from None
        except jwt.InvalidTokenError:
            raise InvalidTokenException() from None
        except (JWTError, ValidationError):
            raise InvalidCredentialsException() from None

    async def __add_simple_person(
        self, user: UserLoginSchema, uow: IUnitOfWork, mapper: BaseMapper
    ):
        await self.__check_exist_user(user.email, uow)
        user.password = self.__get_password_hash(user.password)
        user_db = mapper.create_from_input(user)
        await uow.users.add(user_db)

    async def __check_exist_user(
        self, email: str, uow: IUnitOfWork, exist_error: bool = True
    ):
        try:
            user = await uow.users.get_by_login(email)
            if user:
                if exist_error:
                    raise AccountExistException()
                return user
            elif not exist_error:
                raise InvalidUsernameException()
        except GetUserByEmailException as e:
            raise CheckExistException()

    def __get_password_hash(self, password):
        return self.__pwd_context.hash(password)

    def __verify_password(self, plain_password, hashed_password):
        return self.__pwd_context.verify(plain_password, hashed_password)

    def __generate_tokens(self, data: TokenDataSchema):
        access_payload = self.__constructor_payload(
            data, timedelta(days=0, minutes=ACCESS_TOKEN_EXPIRE_MINUTES), ACCESS_TOKEN
        )
        refresh_payload = self.__constructor_payload(
            data, timedelta(days=REFRESH_TOKEN_EXPIRE_DAYS), REFRESH_TOKEN
        )
        access_token = self.__generate_token(access_payload)
        refresh_token = self.__generate_token(refresh_payload)
        return TokenSchema.Of(access_token, refresh_token)

    def __generate_token(self, payload):
        return jwt.encode(payload, settings.SECRET_STRING, algorithm=settings.ALGORITHM)

    def __constructor_payload(
        self, data: TokenDataSchema, expires: timedelta, scope: str
    ):
        payload = {
            PAYLOAD_NAME_SCOPE: scope,
            PAYLOAD_NAME_SUB_ID: data.id,
            PAYLOAD_NAME_SUB_ROLE_ID: data.role_id,
        }
        if data.role_id != ROLE_BOT:
            exp_payload = {
                PAYLOAD_NAME_EXPIRES: datetime.utcnow() + expires,
                PAYLOAD_NAME_ISSUEDAT: datetime.utcnow(),
            }
            payload.update(exp_payload)
        return payload
