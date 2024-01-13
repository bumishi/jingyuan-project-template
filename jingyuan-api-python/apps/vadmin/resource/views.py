#!/usr/bin/python
# -*- coding: utf-8 -*-
# @version        : 1.0
# @Create Time    : 2023/8/25 9:29
# @File           : views.py
# @IDE            : PyCharm
# @desc           : 简要说明

from fastapi import APIRouter, Depends, UploadFile
from sqlalchemy.orm import joinedload

from apps.vadmin.auth.utils.current import FullAdminAuth
from apps.vadmin.auth.utils.validation.auth import Auth
from core.dependencies import IdList
from utils.response import SuccessResponse
from . import schemas, crud, params, models

app = APIRouter()


###########################################################
#    图片资源管理
###########################################################
@app.get("/images", summary="获取图片列表")
async def get_images_list(p: params.ImagesParams = Depends(), auth: Auth = Depends(FullAdminAuth())):
    model = models.VadminImages
    v_options = [joinedload(model.create_user)]
    v_schema = schemas.ImagesOut
    datas, count = await crud.ImagesDal(auth.db).get_datas(
        **p.dict(),
        v_options=v_options,
        v_schema=v_schema,
        v_return_count=True
    )
    return SuccessResponse(datas, count=count)



@app.delete("/images", summary="删除图片", description="硬删除")
async def delete_images(ids: IdList = Depends(), auth: Auth = Depends(FullAdminAuth())):
    await crud.ImagesDal(auth.db).delete_datas(ids.ids, v_soft=False)
    return SuccessResponse("删除成功")


@app.get("/images/{data_id}", summary="获取图片信息")
async def get_images(data_id: int, auth: Auth = Depends(FullAdminAuth())):
    return SuccessResponse(await crud.ImagesDal(auth.db).get_data(data_id, v_schema=schemas.ImagesSimpleOut))
