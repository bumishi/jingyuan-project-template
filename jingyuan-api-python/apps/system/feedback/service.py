from sqlalchemy import func, delete, update, BinaryExpression, ScalarResult, select, insert
from .models import *
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Any

class UserFeedbackService:

    def __init__(self, db: AsyncSession):
        self.db = db

    async def create_data(
            self,
            dto: UserFeedbackSaveDTO
    ) -> int:
        entity = UserFeedback(**dto.model_dump(exclude=['urls']))
        entity.create_time=datetime.now()
        self.db.add(entity)
        await self.db.flush()
        return entity.id

    async def put_data(
            self,
            id: int,
            dto: UserFeedbackSaveDTO
    ):
        entity = await self.db.get(UserFeedback, id)
        if entity != None:
            dto_dict = dto.model_dump()
            for k in dto_dict.keys():
                v = dto_dict.get(k)
                if v != None:
                    setattr(entity, k, v)
            entity.update_time=datetime.now()
            await self.db.flush()

    async def delete_datas(self, ids: list[int]) -> None:
        await self.db.execute(delete(UserFeedback).where(UserFeedback.id.in_(ids)))
        await self.db.flush()

  
    async def get_for_api(
                self,
                id: int):
        entity = await self.db.get(UserFeedback, id)
        if entity == None:
            return None
        return UserFeedbackApiVO.model_validate(entity)

    async def query_for_api(self, query_params: UserFeedbackApiQueryDTO) -> (bool, list[UserFeedbackApiVO]):
        sql = select(UserFeedback);
        params_dict = query_params.model_dump(exclude=['limit', 'page', 'last_id', 'user_id'])
        conditions = []
        if query_params.last_id and query_params.last_id > 0:
            conditions.append(UserFeedback.id > query_params.last_id)
        if query_params.user_id and query_params.user_id > 0:
            conditions.append(UserFeedback.user_id == query_params.user_id)
        for key in params_dict.keys():
            if params_dict[key]:
                conditions.append(getattr(UserFeedback, key) == params_dict[key])
        if conditions:
            # sql对象是不可变的，各种方法返回新实例
            # *将列表展开传入，**是将字典展开
            sql = sql.where(*conditions)

        if query_params.limit and query_params.limit <= 0:
            query_params.limit = 10
            if not query_params.last_id:
                if not query_params.page:
                    query_params.page = 1
                    sql = sql.offset((query_params.page - 1) * query_params.limit)
            # 多取一条用于判断是否有下一页
            sql = sql.limit(query_params.limit + 1)

        rs = await self.db.scalars(sql)
        if rs == None:
            return (None, False)
        result_list = [UserFeedbackApiVO.model_validate(entity) for entity in rs.all()]
        has_next = len(result_list) > query_params.limit
        if has_next:
            return (result_list[0:-1], True)
        return (result_list, False)


    async def get_for_admin(
                self,
                id: int):
        entity = await self.db.get(UserFeedback, id)
        if entity == None:
            return None
        return UserFeedbackAdminVO.model_validate(entity)

    async def query_for_admin(self, query_params: UserFeedbackAdminQueryDTO, need_count: bool = True) -> (int, list[UserFeedbackAdminVO]):
        sql = select(UserFeedback)
        params_dict = query_params.model_dump(exclude=['limit', 'page'])
        conditions = []
        for key in params_dict.keys():
            ##sql=sql.where()使用方式
            ##where()参数就是模型类.field==value的表达式
            if params_dict[key]:
                #这里通过getattr传入模型类(不是实例)和字段名可以获取对应的字段的模型类.字段形式
                conditions.append(getattr(UserFeedback, key) == params_dict[key])
        if conditions:
            #sql对象是不可变的，各种方法返回新实例
            #*将列表展开传入，**是将字典展开
            sql=sql.where(*conditions)

        if query_params.limit and query_params.limit <= 0:
            query_params.limit = 10
            if not query_params.page:
                query_params.page = 1
            sql = sql.offset((query_params.page - 1) * query_params.limit).limit(query_params.limit)
        sql=sql.order_by(UserFeedback.create_time.desc())
        rs = await self.db.scalars(sql)
        if rs == None:
            return (None,0)
        count = 0
        if need_count:
            count_sql = select(func.count()).select_from(UserFeedback)
            count_queryset = await self.db.execute(count_sql)
            count = count_queryset.one()[0]
        return ([UserFeedbackAdminVO.model_validate(entity) for entity in rs.all()], count)
