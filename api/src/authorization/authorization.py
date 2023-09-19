from src.authentication.constants import ACCESS_TOKEN
from src.authentication.exceptions import *
from src.authentication.service import AuthenticationService
from src.authorization.exceptions import *
from src.authorization.checkers import *
from src.authorization.informants import *
from src.authorization.schemas import *
from src.database.exceptions import DBException
from src.services.unit_of_work import IUnitOfWork


class AuthorizationService:
    def __init__(
        self,
        uow: IUnitOfWork,
        authenticate_service: AuthenticationService,
        resource_InformantService: IResourceInformantService,
        action_InformantService: IActionInformantService,
        subject_InformantService: ISubjectInformantService,
    ):
        self.__uow = uow
        self.__authenticate_service = authenticate_service
        self.__checkers: list[BaseCheckerAuthService] = [
            RoleCheckerAuthService(),
            RoleOwnerCheckerAuthService(),
            ProfileCheckerAuthService(),
        ]
        self.__resource_InformantService = resource_InformantService
        self.__action_InformantService = action_InformantService
        self.__subject_InformantService = subject_InformantService

    async def check_authorization(
        self, action: str, resource: ResourceData, token: str
    ):
        try:
            token_data = self.__authenticate_service.decode_token(token, ACCESS_TOKEN)
            async with self.__uow:
                subject_data = await self.__subject_InformantService.get(token_data)
                resource_data = await self.__resource_InformantService.get(
                    resource, self.__uow
                )
                action_data = await self.__action_InformantService.get(action)

                for checker in self.__checkers:
                    result: StatusAccess = checker.check(
                        action_data, resource_data, subject_data
                    )
                    if result.value:
                        return resource_data, subject_data
                raise NoAccessAuthorizationException()
        except DBException as db_e:
            raise DBAuthorizationException(db_e.message) from db_e
