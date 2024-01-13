from sqlalchemy import func, delete, update, BinaryExpression, ScalarResult, select, insert
from .models import *;
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Any

class NoticeService:

    def __init__(self, db: AsyncSession):
        self.db = db

    async def create_data(
            self,
            dto: NoticeSaveDTO
    ) -> int:
        entity = Notice(**dto.model_dump())
        entity.create_time=datetime.now()
        self.db.add(entity)
        await self.db.flush()
        return entity.id

    async def put_data(
            self,
            id: int,
            dto: NoticeSaveDTO
    ):
        entity = await self.db.get(Notice, id)
        if entity != None:
            dto_dict = dto.model_dump()
            for k in dto_dict.keys():
                v = dto_dict.get(k)
                if v != None:
                    setattr(entity, k, v)
            entity.update_time=datetime.now()
            await self.db.flush()

    async def delete_datas(self, ids: list[int]) -> None:
        await self.db.execute(delete(Notice).where(Notice.id.in_(ids)))
        await self.db.flush()

  
    async def get_for_api(
                self,
                id: int):
        entity = await self.db.get(Notice, id)
        if entity == None:
            return None
        return NoticeApiVO.model_validate(entity)

    async def query_for_api(self) -> list[NoticeApiVO]:
        sql = select(Notice);
        conditions = []
        conditions.append(Notice.begin_time<=datetime.now())
        conditions.append(Notice.end_time>=datetime.now())
        sql = sql.where(*conditions)
        sql = sql.limit(10)
        rs = await self.db.scalars(sql)
        if rs == None:
            return (None, False)
        result_list = [NoticeApiVO.model_validate(entity) for entity in rs.all()]
        return result_list

    async def get_for_admin(
                self,
                id: int):
        entity = await self.db.get(Notice, id)
        if entity == None:
            return None
        return NoticeAdminVO.model_validate(entity)

    async def query_for_admin(self, query_params: NoticeAdminQueryDTO, need_count: bool = True) -> (int, list[NoticeAdminVO]):
        sql = select(Notice);
        params_dict = query_params.model_dump(exclude=['limit', 'page'])
        conditions = []
        for key in params_dict.keys():
            ##sql=sql.where()使用方式
            ##where()参数就是模型类.field==value的表达式
            if params_dict[key]:
                #这里通过getattr传入模型类(不是实例)和字段名可以获取对应的字段的模型类.字段形式
                conditions.append(getattr(Notice, key) == params_dict[key])
        if conditions:
            #sql对象是不可变的，各种方法返回新实例
            #*将列表展开传入，**是将字典展开
            sql=sql.where(*conditions)

        if query_params.limit and query_params.limit <= 0:
            query_params.limit = 10
            if not query_params.page:
                query_params.page = 1
            sql = sql.offset((query_params.page - 1) * query_params.limit).limit(query_params.limit)
        sql = sql.order_by(Notice.create_time.desc())
        rs = await self.db.scalars(sql)
        if rs == None:
            return (None,0)
        count = 0
        if need_count:
            count_sql = select(func.count()).select_from(Notice)
            count_queryset = await self.db.execute(count_sql)
            count = count_queryset.one()[0]
        return ([NoticeAdminVO.model_validate(entity) for entity in rs.all()], count)
