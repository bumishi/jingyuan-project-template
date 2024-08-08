# -*- coding: utf-8 -*-
# @version        : 1.0
# @Create Time    : 2021/10/24 16:44
# @File           : views.py
# @IDE            : PyCharm
# @desc           : 主要接口文件

from fastapi import APIRouter, Depends, UploadFile, Form
from redis.asyncio import Redis
from sqlalchemy.ext.asyncio import AsyncSession

from application.settings import QINIU_OSS, DEBUG
from apps.vadmin.auth import crud as vadmin_auth_crud
from apps.vadmin.auth.utils.current import OpenAuth, FullAdminAuth, AllUserAuth
from apps.vadmin.auth.utils.validation.auth import Auth
from apps.vadmin.system import crud
from core.database import db_getter, redis_getter
from core.exception import CustomException
from utils import status
from utils.file.qiniu_oss import QiniuOSS, BucketConf
from utils.file.file_manage import FileManage
from utils.response import SuccessResponse, ErrorResponse
from utils.sms.code import CodeSMS

app = APIRouter()


###########################################################
#    文件上传管理
###########################################################
@app.post("/upload/img", summary="用户图片到七牛OSS")
async def upload_image_to_oss(file: UploadFile, path: str = Form(...),auth: Auth = Depends(AllUserAuth())):
    result = await QiniuOSS(BucketConf(**QINIU_OSS)).upload_image(path, file)
    return SuccessResponse(result)


# @app.post("/upload/video/to/oss", summary="上传视频到七牛OSS")
# async def upload_video_to_oss(file: UploadFile, path: str = Form(...)):
#     result = await QiniuOSS(BucketConf(**QINIU_OSS)).upload_video(path, file)
#     return SuccessResponse(result)
#
#
# @app.post("/upload/file/to/oss", summary="上传文件到七牛OSS")
# async def upload_file_to_oss(file: UploadFile, path: str = Form(...)):
#     result = await QiniuOSS(BucketConf(**QINIU_OSS)).upload_file(path, file)
#     return SuccessResponse(result)


@app.post("/upload/image/to/local", summary="后台管理上传图片到本地")
async def upload_image_to_local(file: UploadFile, path: str = Form(...), auth: Auth = Depends(FullAdminAuth())):
    manage = FileManage(file, path)
    path = await manage.save_image_local()
    return SuccessResponse(path)


###########################################################
#    短信服务管理
###########################################################
@app.post("/sms/send", summary="发送短信验证码（腾讯服务）")
async def sms_send(telephone: str, event: str = 'login', rd: Redis = Depends(redis_getter),
                   auth: Auth = Depends(OpenAuth())):
    if event == 'login':
        user = await vadmin_auth_crud.UserDal(auth.db).get_data(telephone=telephone, v_return_none=True)
        if not user:
            return ErrorResponse("手机号不存在！")
    elif event == 'smsRegister':
        unique = await vadmin_auth_crud.UserDal(auth.db).get_data(telephone=telephone, v_return_none=True)
        if unique:
            raise CustomException("该手机号已存在！", code=status.HTTP_ERROR)
    sms = CodeSMS(telephone, rd)
    code = sms.get_code()
    print(code)
    if DEBUG:
        return SuccessResponse()
    return SuccessResponse(await sms.send_msg(code=code))


@app.get("/settings/base/config", summary="获取系统基础配置", description="每次进入系统中时使用")
async def get_setting_base_config(db: AsyncSession = Depends(db_getter)):
    return SuccessResponse(await crud.SettingsDal(db).get_base_config())


@app.get("/settings/about", summary="获取关于我们")
async def get_settings_about(db: AsyncSession = Depends(db_getter)):
    return SuccessResponse((await crud.SettingsDal(db).get_data(config_key="web_about")).config_value)


@app.get("/settings/privacy", summary="获取隐私协议")
async def get_settings_privacy(db: AsyncSession = Depends(db_getter)):
    return SuccessResponse((await crud.SettingsDal(db).get_data(config_key="web_privacy")).config_value)


@app.get("/settings/agreement", summary="获取用户协议")
async def get_settings_agreement(db: AsyncSession = Depends(db_getter)):
    return SuccessResponse((await crud.SettingsDal(db).get_data(config_key="web_agreement")).config_value)
