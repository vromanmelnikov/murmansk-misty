from datetime import datetime
from dateutil.relativedelta import relativedelta
from src.task.consts import UNITS

from src.task.schemas import *
from src.authorization.schemas import SubjectData
from src.database.exceptions import *
from src.database.models import Task
from src.exceptions import ServiceException
from src.services.unit_of_work import IUnitOfWork


class TaskService:
    def __init__(self, uow: IUnitOfWork):
        self.__uow = uow

    async def get_unit(self):
        async with self.__uow:
            units = await self.__uow.unit_intervals.get_all()
            return [UnitIntervalDBSchema.from_orm(unit) for unit in units]

    def __proccess_response_task(self, task: Task):
        res = TaskDBSchema.from_orm(task)
        res.duration = str(res.duration)
        return res

    async def put_tasks(self, task: TaskUpdateSchema, subject_data: SubjectData):
        async with self.__uow:
            t_db = await self.__uow.tasks.get_by_id(task.id)
            if t_db is None:
                raise ServiceException("Такой задачи нет")
            t_db.path = task.path
            t_db.is_active = task.is_active
            t_db.details = task.details
            t_db.name = task.name
            if task.date_execute:
                date_execute, data = self.__proccess_date(task)
                t_db.date_execute = date_execute
            elif task.period:
                duration, data = self.__calculate_interval(task)
                t_db.duration = duration
            task.details.update(data)
            t_db.details = task.details
            try:
                t = await self.__uow.tasks.update(t_db)
                await self.__uow.commit()
                return t
            except (ForeignKeyViolationException, UniqueViolationException) as e:
                raise ServiceException(e.message, 400)
            except AddItemException as e:
                raise ServiceException(e.message, 500)

    async def add_tasks(self, task: TaskCreateSchema, subject_data: SubjectData):
        async with self.__uow:
            t_db = Task(
                path=task.path,
                is_active=task.is_active,
                details=task.details,
                user_id=subject_data.id,
                name=task.name,
            )
            if task.date_execute:
                date_execute, data = self.__proccess_date(task)
                t_db.date_execute = date_execute
            elif task.period:
                duration, data = self.__calculate_interval(task)
                t_db.duration = duration
            task.details.update(data)
            t_db.details = task.details
            try:
                t = await self.__uow.tasks.add(t_db)
                await self.__uow.commit()
                return t
            except (ForeignKeyViolationException, UniqueViolationException) as e:
                raise ServiceException(e.message, 400)
            except AddItemException as e:
                raise ServiceException(e.message, 500)

    async def get_tasks(self, subject: SubjectData):
        async with self.__uow:
            tasks = await self.__uow.tasks.get_all(user_id=subject.id)
            return [self.__proccess_response_task(task) for task in tasks]

    async def get_tasks_template(self):
        buy_forever = {
            "path": "/stores/products/items/buy",
            "name": "Купить сейчас 2 шоколадки",
            "is_active": True,
            "date_execute": datetime.utcnow(),
            "details": {
                "product_item_id": 93,
                "product_name": "Шоколад Alpen Gold с фундуком",
                "product_count": 2,
                "price": 90,
            },
        }
        buy_from_basket = {
            "path": "/stores/products/items/buy_from_basket",
            "name": "Купить завтра тур из корзины",
            "date_execute": datetime.utcnow() + timedelta(days=1),
            "is_active": True,
            "details": {
                "basket_id": 1,
                "product_name": "Тур 'Париж и его красоты'",
            },
        }
        booking_docktor = {
            "path": "/booking",
            "name": "Записаться к врачу на прием",
            "period": {"unit": "months", "value": 1},
            "is_active": True,
            "details": {
                "product_item_id": 52,
                "product_name": "Приём у терапевта",
            },
        }
        return [buy_forever, buy_from_basket, booking_docktor]

    def __proccess_date(self, task: TaskCreateSchema):
        return task.date_execute, {
            "count": 1,
            "current_count": 0,
        }

    def __calculate_interval(self, task: TaskCreateSchema):
        if task.period.unit not in UNITS:
            raise ServiceException("Неверные единицы измерения", 400)
        interval = {task.period.unit: task.period.value}
        rd = relativedelta(**interval)
        utcnow = datetime.utcnow()
        time_delta = utcnow + rd - utcnow
        return (
            time_delta,
            {"count": task.period.count, "current_count": 0}
            if task.period.count
            else {},
        )
