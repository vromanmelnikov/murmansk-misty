from datetime import timedelta
from fastapi import APIRouter, Depends, File, UploadFile
from fastapi.responses import RedirectResponse

from src.authorization.authorization import AuthorizationService
from src.authorization.schemas import ResourceData
from src.config import OAuth2Scheme
from src.const import *
from src.file_operator.const import RESOURCE_FILE
from src.file_operator.dependies import create_file_service, factory_file_auth
from src.file_operator.service import FileService
from src.authorization.dependies import factory_default_auth

router = APIRouter(prefix="/files", tags=["Files"])


@router.post(
    "/",
    summary="Загрузка файла",
    description="Загрузить файл, изображение, аватарка, документ",
)
async def add_file(
    file: UploadFile = File(...),
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_default_auth),
    file_service: FileService = Depends(create_file_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_ADD, ResourceData(name=RESOURCE_FILE), token
    )
    return await file_service.add_file(file, subject_data)


@router.get(
    "/{path}",
    summary="Получение файла",
    description="Скачать файл, изображение, аватарка, документ, отобразить",
)
async def get_file(
    path: str,
    file_service: FileService = Depends(create_file_service),
):
    r = await file_service.get_file(path)
    return RedirectResponse(r)


@router.delete(
    "/{path}",
    summary="Удалить свой файл",
    description="Удаление файла, изображения, аватарки, документа",
)
async def delete_file(
    path: str,
    token: str = Depends(OAuth2Scheme),
    authorization_service: AuthorizationService = Depends(factory_file_auth),
    file_service: FileService = Depends(create_file_service),
):
    resource_data, subject_data = await authorization_service.check_authorization(
        METHOD_DELETE, ResourceData(id=path, name=RESOURCE_FILE), token
    )
    return await file_service.delete_file(resource_data)


@router.get(
    "/qrcode/{data}.jpg",
    summary="Генерация данных в QR код",
    description="Генерация и получения qr кода, изображение qr кода по данным, url магазина, сервиса",
)
async def generate_qrcode(
    data: str,
    file_service: FileService = Depends(create_file_service),
):
    return await file_service.generate_qrcode(data)
