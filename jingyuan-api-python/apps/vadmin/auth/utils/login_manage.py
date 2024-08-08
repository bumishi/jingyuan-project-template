#!/usr/bin/python
# -*- coding: utf-8 -*-
# @version        : 1.0
# @Create Time    : 2022/8/8 11:02
# @File           : auth_util.py
# @IDE            : PyCharm
# @desc           : 简要说明

from datetime import datetime, timedelta
from fastapi import Request
from redis.asyncio.client import Redis
from sqlalchemy.ext.asyncio import AsyncSession

from application import settings
import jwt

from application.settings import DEBUG
from apps.vadmin.auth import models
from core.database import redis_getter
from utils.sms.code import CodeSMS
from .validation import LoginValidation, LoginForm, LoginResult, RegisterForm
from apps.vadmin.auth import crud as vadmin_auth_crud
from ..models import VadminUser

class LoginManage:

    """
    登录认证工具
    """

    @LoginValidation
    async def password_login(self, data: LoginForm, user: models.VadminUser, **kwargs) -> LoginResult:
        """
        验证用户密码
        """
        result = models.VadminUser.verify_password(data.password, user.password)
        if result:
            return LoginResult(status=True, msg="验证成功")
        return LoginResult(status=False, msg="手机号或密码错误")

    @LoginValidation
    async def sms_login(self, data: LoginForm, request: Request, **kwargs) -> LoginResult:
        """
        验证用户短信验证码
        """
        rd = redis_getter(request)
        sms = CodeSMS(data.mobile, rd)
        result = await sms.check_sms_code(data.password)
        if result:
            return LoginResult(status=True, msg="验证成功")
        return LoginResult(status=False, msg="验证码错误")

    @staticmethod
    def create_token(payload: dict, expires: timedelta = None):
        """
        创建一个生成新的访问令牌的工具函数。

        pyjwt：https://github.com/jpadilla/pyjwt/blob/master/docs/usage.rst
        jwt 博客：https://geek-docs.com/python/python-tutorial/j_python-jwt.html

        #TODO 传入的时间为UTC时间datetime.datetime类型，但是在解码时获取到的是本机时间的时间戳
        """
        if expires:
            expire = datetime.utcnow() + expires
        else:
            expire = datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
        payload.update({"exp": expire})
        encoded_jwt = jwt.encode(payload, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
        return encoded_jwt


    @staticmethod
    async def login_by_mobile_if_none_register(data: RegisterForm, db: AsyncSession, rd: Redis):
        """
        验证用户短信验证码
        """
        if not DEBUG:
            sms = CodeSMS(data.mobile, rd)
            result = await sms.check_sms_code(data.code)
            if not result:
                raise ValueError("手机验证码错误")
        user = await vadmin_auth_crud.UserDal(db).get_data(telephone=data.mobile, v_return_none=True)
        if user:
            return user
        user = VadminUser(telephone=data.mobile, nickname=data.mobile, is_active=True, is_staff=False,
                          create_datetime=datetime.now(),platform=data.platform)
        db.add(user)
        await db.flush()
        return user
