# -*- coding: utf-8 -*-
# @version        : 1.0
# @Create Time    : 2021/10/24 16:44
# @File           : views.py
# @IDE            : PyCharm
# @desc           : 安全认证视图

"""
JWT 表示 「JSON Web Tokens」。https://jwt.io/

它是一个将 JSON 对象编码为密集且没有空格的长字符串的标准。

通过这种方式，你可以创建一个有效期为 1 周的令牌。然后当用户第二天使用令牌重新访问时，你知道该用户仍然处于登入状态。
一周后令牌将会过期，用户将不会通过认证，必须再次登录才能获得一个新令牌。

我们需要安装 python-jose 以在 Python 中生成和校验 JWT 令牌：pip install python-jose[cryptography]

PassLib 是一个用于处理哈希密码的很棒的 Python 包。它支持许多安全哈希算法以及配合算法使用的实用程序。
推荐的算法是 「Bcrypt」：pip install passlib[bcrypt]
"""

from datetime import timedelta, datetime

import jwt
from fastapi import APIRouter, Depends, Request, Body
from fastapi.security import OAuth2PasswordRequestForm
from redis.asyncio import Redis
from sqlalchemy.ext.asyncio import AsyncSession

from application import settings
from apps.vadmin.auth.crud import UserDal
from apps.vadmin.auth.models import VadminUser
from apps.vadmin.auth.utils.login_manage import LoginManage
from apps.vadmin.auth.utils.validation import LoginForm, WXLoginForm, RegisterForm
from apps.vadmin.record.models import VadminLoginRecord
from core.database import db_getter, redis_getter
from core.exception import CustomException
from utils import status
from utils.response import SuccessResponse, ErrorResponse
from utils.sms.code import CodeSMS
from utils.wx.oauth import WXOAuth
from apps.vadmin.auth import crud as vadmin_auth_crud
from apps.vadmin.auth.third.service import UserThirdBindService

app = APIRouter()


@app.post("/register", summary="手机号注册")
async def sms_register(
        request: Request,
        data: RegisterForm,
        rd: Redis = Depends(redis_getter),
        db: AsyncSession = Depends(db_getter)):
    login_response = await do_register(data, db, rd)
    return SuccessResponse(login_response)


async def do_register(data: RegisterForm, db: AsyncSession, rd: Redis):
    """
    验证用户短信验证码
    """
    sms = CodeSMS(data.mobile, rd)
    result = await sms.check_sms_code(data.code)
    if not result:
        raise ValueError("手机验证码错误")
    unique = await vadmin_auth_crud.UserDal(db).get_data(telephone=data.mobile, v_return_none=True)
    if unique:
        raise CustomException("该手机号已存在！", code=status.HTTP_ERROR)
    user = VadminUser(telephone=data.mobile, nickname=data.mobile, is_active=True, is_staff=False,
                      create_datetime=datetime.now())
    db.add(user)
    await db.flush()
    # 注册成功后直接返回登录token
    return create_login_response(user)


@app.post("/api/login", summary="API 手机号密码登录", description="Swagger API 文档登录认证")
async def api_login_for_access_token(
        request: Request,
        data: OAuth2PasswordRequestForm = Depends(),
        db: AsyncSession = Depends(db_getter)
):
    user = await UserDal(db).get_data(telephone=data.username, v_return_none=True)
    if not user:
        raise CustomException(status_code=401, code=401, msg="该手机号不存在")
    result = VadminUser.verify_password(data.password, user.password)
    if not result:
        raise CustomException(status_code=401, code=401, msg="手机号或密码错误")
    if not user.is_active:
        raise CustomException(status_code=401, code=401, msg="此手机号已被冻结")
    elif not user.is_staff:
        raise CustomException(status_code=401, code=401, msg="此手机号无权限")
    access_token = LoginManage.create_token({"sub": user.id})
    record = LoginForm(platform='2', method='0', telephone=data.username, password=data.password)
    resp = {"access_token": access_token, "token_type": "bearer"}
    await VadminLoginRecord.create_login_record(db, record, True, request, resp)
    return resp


@app.post("/login", summary="手机号登录")
async def login_for_access_token(
        request: Request,
        data: LoginForm,
        manage: LoginManage = Depends(),
        db: AsyncSession = Depends(db_getter)
):
    try:
        if data.method == "0":
            result = await manage.password_login(data, db, request)
        elif data.method == "1":
            result = await manage.sms_login(data, db, request)
        else:
            raise ValueError("无效参数")

        if not result.status:
            raise ValueError(result.msg)

        resp = create_login_response(result.user)
        await VadminLoginRecord.create_login_record(db, data, True, request, resp)
        return SuccessResponse(resp)
    except ValueError as e:
        await VadminLoginRecord.create_login_record(db, data, False, request, {"message": str(e)})
        return ErrorResponse(msg=str(e))


def create_login_response(user: VadminUser):
    access_token = LoginManage.create_token({"sub": user.id, "is_refresh": False})
    expires = timedelta(minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES)
    refresh_token = LoginManage.create_token({"sub": user.id, "is_refresh": True}, expires=expires)
    resp = {
        "access_token": access_token,
        "refresh_token": refresh_token,
        "token_type": "bearer",
        "is_reset_password": user.is_reset_password
    }
    return resp


@app.post("/wx/login", summary="微信一键登录，若不存在绑定自动创建新账号")
async def wx_login_auto(
        request: Request,
        data: WXLoginForm,
        db: AsyncSession = Depends(db_getter),
        rd: Redis = Depends(redis_getter)
):
    wx = WXOAuth(rd)
    rs = await wx.parsing(data.code)
    if not rs.open_id:
        raise CustomException("微信登录错误")
    user = await UserThirdBindService(db,rd).auto_login(rs)
    # 登录成功创建 token
    resp = create_login_response(user)
    return SuccessResponse(resp)


@app.post("/wx/login_by_mobile", summary="基于微信API获取手机号查找用户登录")
async def wx_login_for_access_token(
        request: Request,
        data: WXLoginForm,
        db: AsyncSession = Depends(db_getter),
        rd: Redis = Depends(redis_getter)
):
    try:
        if data.platform != "1" or data.method != "2":
            raise ValueError("无效参数")
        wx = WXOAuth(rd, 0)
        telephone = await wx.parsing_phone_number(data.code)
        if not telephone:
            raise ValueError("无效Code")
        data.telephone = telephone
        user = await UserDal(db).get_data(telephone=telephone, v_return_none=True)
        if not user:
            raise ValueError("手机号不存在")
        elif not user.is_active:
            raise ValueError("手机号已被冻结")
    except ValueError as e:
        await VadminLoginRecord.create_login_record(db, data, False, request, {"message": str(e)})
        return ErrorResponse(msg=str(e))

    # 更新登录时间
    await UserDal(db).update_login_info(user, request.client.host)

    # 登录成功创建 token

    resp = create_login_response(user)
    await VadminLoginRecord.create_login_record(db, data, True, request, resp)
    return SuccessResponse(resp)


@app.post("/token/refresh", summary="刷新Token")
async def token_refresh(refresh: str = Body(..., title="刷新Token")):
    error_code = status.HTTP_401_UNAUTHORIZED
    try:
        payload = jwt.decode(refresh, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        id: str = payload.get("sub")
        is_refresh: bool = payload.get("is_refresh")
        if id is None or not is_refresh:
            return ErrorResponse("未认证，请您重新登录", code=error_code, status=error_code)
    except jwt.exceptions.InvalidSignatureError:
        return ErrorResponse("无效认证，请您重新登录", code=error_code, status=error_code)
    except jwt.exceptions.ExpiredSignatureError:
        return ErrorResponse("登录已超时，请您重新登录", code=error_code, status=error_code)

    access_token = LoginManage.create_token({"sub": id, "is_refresh": False})
    expires = timedelta(minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES)
    refresh_token = LoginManage.create_token({"sub": id, "is_refresh": True}, expires=expires)
    resp = {
        "access_token": access_token,
        "refresh_token": refresh_token,
        "token_type": "bearer"
    }
    return SuccessResponse(resp)
