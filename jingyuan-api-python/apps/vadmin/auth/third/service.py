from sqlalchemy import delete, select
from sqlalchemy.ext.asyncio import AsyncSession

import core.database
from apps.vadmin.auth.third.models import *
from apps.vadmin.auth.models import VadminUser
from utils.wx.oauth import WXOAuth
from redis.asyncio import Redis
from sqlalchemy.ext.asyncio import AsyncSession


class UserThirdBindService:

    def __init__(self, db: AsyncSession, rd: Redis):
        self.db = db
        self.redis = rd

    async def auto_login(
            self, loginvo: ThirdLoginVO

    ) -> VadminUser:

        dto = UserThirdBindSaveDTO(open_id=loginvo.open_id, union_id=loginvo.union_id,
                                   third_type=loginvo.third_type)
        sql = select(UserThirdBind)
        wheres = []
        if dto.union_id:
            wheres.append(UserThirdBind.union_id == dto.union_id)
        if dto.open_id:
            wheres.append(UserThirdBind.open_id == dto.open_id)
        wheres.append(UserThirdBind.third_type == dto.third_type)
        sql = sql.where(*wheres)
        rs = await self.db.scalars(sql)
        bind = rs.one_or_none()
        if bind:
            user = await self.db.get(VadminUser, bind.user_id)
            return user
        else:
            # 没有绑定过，创建一个账号
            user = VadminUser(nickname=dto.third_type + "用户", is_active=True, is_staff=False,
                              create_datetime=datetime.now(), telephone=dto.mobile)
            self.db.add(user)
            await self.db.flush()
            entity = UserThirdBind(user_id=user.id, open_id=dto.open_id, union_id=dto.union_id,
                                   third_type=dto.third_type, bind_time=datetime.now())
            self.db.add(entity)
            await self.db.flush()
            return user

    async def add_bind(
            self, loginvo: ThirdLoginVO, user: VadminUser

    ):
        entity = UserThirdBind(user_id=user.id, open_id=loginvo.open_id, union_id=loginvo.union_id,
                               third_type=loginvo.third_type, bind_time=datetime.now())
        self.db.add(entity)
        await self.db.flush()


    async def unbind(self, third_type: str, user: VadminUser):
        await self.db.execute(
            delete(UserThirdBind).where(UserThirdBind.user_id == user.id).where(UserThirdBind.third_type == third_type))
        await self.db.flush()
