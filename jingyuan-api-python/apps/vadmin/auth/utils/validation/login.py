#!/usr/bin/python
# -*- coding: utf-8 -*-
# @version        : 1.0
# @Create Time    : 2022/11/9 10:15 
# @File           : login.py
# @IDE            : PyCharm
# @desc           : 登录验证装饰器

from fastapi import Request
from pydantic import BaseModel, field_validator
from sqlalchemy.ext.asyncio import AsyncSession
from application.settings import DEFAULT_AUTH_ERROR_MAX_NUMBER, REDIS_DB_ENABLE
from apps.vadmin.auth import crud, schemas
from core.database import redis_getter
from core.validator import vali_telephone
from utils.count import Count

class RegisterForm(BaseModel):
    mobile: str
    code: str
    platform: str = '0'  # 登录平台，0：PC端管理系统，1：移动端


class LoginForm(BaseModel):
    mobile: str
    password: str
    method: str = '0'  # 认证方式，0：密码登录，1：短信登录，2：微信一键登录
    platform: str = '0'  # 登录平台，0：PC端管理系统，1：移动端

    # 重用验证器：https://docs.pydantic.dev/dev-v2/usage/validators/#reuse-validators
    normalize_telephone = field_validator('mobile')(vali_telephone)


class WXLoginForm(BaseModel):
    mobile: str | None = None
    code: str
    method: str = '2'  # 认证方式，0：密码登录，1：短信登录，2：微信一键登录
    platform: str = '1'  # 登录平台，0：PC端管理系统，1：移动端管理系统


class LoginResult(BaseModel):
    status: bool | None = False
    user: schemas.UserOut | None = None
    msg: str | None = None

    class Config:
        arbitrary_types_allowed = True


class LoginValidation:
    """
    验证用户登录时提交的数据是否有效
    """

    def __init__(self, func):
        self.func = func

    async def __call__(self, data: LoginForm, db: AsyncSession, request: Request) -> LoginResult:
        self.result = LoginResult()
        user = await crud.UserDal(db).get_data(telephone=data.mobile, v_return_none=True)
        if not user:
            self.result.msg = "该手机号不存在！"
            return self.result

        result = await self.func(self, data=data, user=user, request=request)
        count = None
        # if REDIS_DB_ENABLE:
        #     count_key = f"{data.mobile}_password_auth" if data.method == '0' else f"{data.mobile}_sms_auth"
        #    count = Count(redis_getter(request), count_key)

        if not result.status:
            self.result.msg = result.msg
            # if count:
            #     number = await count.add(ex=86400)
            #     if number >= DEFAULT_AUTH_ERROR_MAX_NUMBER:
            #         await count.reset()
            #         # 如果等于最大次数，那么就将用户 is_active=False
            #         user.is_active = False
            #         await db.flush()
        elif not user.is_active:
            self.result.msg = "此手机号已被冻结！"
        elif data.platform in ["0"] and not user.is_staff:
            self.result.msg = "此手机号无权限！"
        else:
            if count:
                await count.delete()
            self.result.msg = "OK"
            self.result.status = True
            self.result.user = schemas.UserSimpleOut.model_validate(user)
            await crud.UserDal(db).update_login_info(user, request.client.host)
        return self.result
