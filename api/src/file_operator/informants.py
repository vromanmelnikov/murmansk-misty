from src.authorization.informants import IResourceInformantService
from src.authorization.schemas import *
from src.database.exceptions import GetItemByIdException
from src.exceptions import NotFoundException
from src.file_operator.phrases import FILE_NOT_FOUND
from src.services.unit_of_work import IUnitOfWork


class FileResourceInformantService(IResourceInformantService):
    async def get(self, resource: ResourceData, uow: IUnitOfWork) -> ResourceData:
        try:
            file = await uow.files.get_by_id(resource.id)
            if file is None:
                raise NotFoundException(FILE_NOT_FOUND)
            resource.owner_id = file.owner_id
            resource.details = file.details
            return resource
        except GetItemByIdException as e:
            raise e
