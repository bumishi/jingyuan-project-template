#!/usr/bin/python
# -*- coding: utf-8 -*-
# @version        : 1.0
# @Create Time    : 2022/2/24 17:02
# @File           : views.py
# @IDE            : PyCharm
# @desc           : 简要说明

from fastapi import APIRouter, Depends, UploadFile
from redis.asyncio import Redis
from sqlalchemy.ext.asyncio import AsyncSession

from apps.vadmin.auth.utils.current import AllUserAuth, FullAdminAuth
from apps.vadmin.auth.utils.validation import WXLoginForm
from apps.vadmin.auth.utils.validation.auth import Auth
from core.database import db_getter, redis_getter
from core.exception import CustomException
from utils.response import SuccessResponse
from utils.wx.oauth import WXOAuth
from . import schemas, crud
from .crud import MenuDal
from .third.service import UserThirdBindService

app = APIRouter()


@app.post("/reset/password", summary="重置当前用户密码")
async def user_current_reset_password(data: schemas.ResetPwd, auth: Auth = Depends(AllUserAuth())):
    return SuccessResponse(await crud.UserDal(auth.db).reset_current_password(auth.user, data))


@app.post("/update/info", summary="更新当前用户基本信息")
async def post_user_current_update_info(data: schemas.UserUpdateBaseInfo, auth: Auth = Depends(AllUserAuth())):
    return SuccessResponse(await crud.UserDal(auth.db).update_current_info(auth.user, data))


@app.post("/update/avatar", summary="更新当前用户头像")
async def post_user_current_update_avatar(file: UploadFile, auth: Auth = Depends(AllUserAuth())):
    return SuccessResponse(await crud.UserDal(auth.db).update_current_avatar(auth.user, file))


@app.post("/update/mobile", summary="更新当前用户手机")
async def post_user_current_update_mobile(data: schemas.ResetMobile, auth: Auth = Depends(AllUserAuth()),
                                          rd: Redis = Depends(redis_getter)):
    return SuccessResponse(await crud.UserDal(auth.db).reset_current_mobile(auth.user, data, rd))


@app.get("/info", summary="获取当前后台管理用户信息")
async def get_user_admin_current_info(auth: Auth = Depends(FullAdminAuth())):
    result = schemas.UserOut.model_validate(auth.user).model_dump()
    result["permissions"] = list(FullAdminAuth.get_user_permissions(auth.user))
    return SuccessResponse(result)


@app.get("/profile", summary="获取app当前用户信息")
async def get_user_info(auth: Auth = Depends(AllUserAuth())):
    result = schemas.AppUserInfo.model_validate(auth.user).model_dump()
    return SuccessResponse(result)


@app.get("/getMenuList", summary="获取当前用户菜单树")
async def get_menu_list(auth: Auth = Depends(FullAdminAuth())):
    return SuccessResponse(await MenuDal(auth.db).get_routers(auth.user))


@app.post("/wechat/bind", summary="微信一键登录，若不存在绑定自动创建新账号")
async def bind_wechat(
        data: WXLoginForm,
        auth: Auth = Depends(AllUserAuth()),
        db: AsyncSession = Depends(db_getter),
        rd: Redis = Depends(redis_getter)
):
    wx = WXOAuth(rd)
    rs = await wx.parsing(data.code)
    if not rs.open_id:
        raise CustomException("微信错误")
    await UserThirdBindService(db).add_bind(rs, auth.user)
    return SuccessResponse()


@app.post("/wechat/unbind", summary="微信解绑")
async def bind_wechat(
        auth: Auth = Depends(AllUserAuth()),
        db: AsyncSession = Depends(db_getter)):
    await UserThirdBindService(db).unbind('wechat', auth.user)
    return SuccessResponse()
