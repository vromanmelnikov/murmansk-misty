from fastapi import UploadFile, status
import requests
from qrcode.main import QRCode
from qrcode.constants import ERROR_CORRECT_L
from io import BytesIO
from starlette.responses import StreamingResponse

from src.authorization.schemas import ResourceData, SubjectData
from src.config import settings
from src.database.models import FileModel
from src.exceptions import NotFoundException, ServiceException
from src.file_operator.phrases import *
from src.services.unit_of_work import IUnitOfWork


class FileService:
    def __init__(self, uow: IUnitOfWork):
        self.__uow = uow

    async def add_file(self, file: UploadFile, subject_data: SubjectData):
        async with self.__uow:
            try:
                files = {"file": (file.filename, file.file, file.content_type)}
                res = requests.post(f"{settings.FILE_SHARING_URL}/upload", files=files)
                r = res.json()
                if res.status_code != 200:
                    raise ServiceException(r, status.HTTP_400_BAD_REQUEST)
                token = r["token"]
                f = FileModel(token=token, owner_id=subject_data.id, details=r)
                await self.__uow.files.add(f)
                await self.__uow.commit()
                return token
            except Exception as e:
                raise ServiceException(
                    ADD_FILE_FAILED, status.HTTP_500_INTERNAL_SERVER_ERROR
                )

    async def get_file(self, token: str):
        try:
            res = requests.get(f"{settings.FILE_SHARING_URL}/info/{token}")
            r = res.json()
            if res.status_code != 200:
                raise ServiceException(r, status.HTTP_400_BAD_REQUEST)
            result = r.get("downloadUrl", None)
            if result is None:
                raise NotFoundException(FILE_NOT_FOUND)
            return result
        except NotFoundException as e:
            raise e
        except Exception as e:
            raise ServiceException(
                GET_FILE_FAILED, status.HTTP_500_INTERNAL_SERVER_ERROR
            )

    async def delete_file(self, resource_data: ResourceData):
        async with self.__uow:
            try:
                res = requests.post(
                    f"{settings.FILE_SHARING_URL}/delete/{resource_data.id}/{resource_data.details['deleteToken']}"
                )
                if res.status_code != 200:
                    raise ServiceException(
                        DELETE_FILE_FAILED, status.HTTP_400_BAD_REQUEST
                    )
                await self.__uow.files.delete(resource_data.id)
                await self.__uow.commit()
                return {"message": DELETE_FILE_SUCCESS}
            except Exception as e:
                raise ServiceException(
                    DELETE_FILE_FAILED, e.code or status.HTTP_500_INTERNAL_SERVER_ERROR
                )

    async def generate_qrcode(self, data: str):
        # Create a QR code instance
        qr = QRCode(
            version=1,
            error_correction=ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )
        # Add data to the QR code
        qr.add_data(data)
        qr.make(fit=True)

        # Create an image from the QR code matrix
        img = qr.make_image(fill_color="black", back_color="white")

        # Save the image to a BytesIO buffer
        img_buffer = BytesIO()
        img.save(img_buffer, format="PNG")
        img_buffer.seek(0)

        # Return the image as a streaming response
        return StreamingResponse(img_buffer, media_type="application/xls")
