from fastapi import APIRouter, Depends
from core.dependencies import IdList
from apps.vadmin.auth.utils.current import FullAdminAuth
from apps.vadmin.auth.utils.validation.auth import Auth
from .models import *
from utils.response import RestResponse
from . import service

app = APIRouter()

@app.post("/notice/add", summary="新增操作")
async def add_data(dto: NoticeSaveDTO, auth: Auth = Depends(FullAdminAuth(permissions=["system.notice.create"]))):
    return RestResponse.success(await service.NoticeService(auth.db).create_data(dto))


@app.post("/notice/del", summary="批量删除")
async def delete_datas(ids: IdList = Depends(), auth: Auth = Depends(FullAdminAuth(permissions=["system.notice.del"]))):
    await service.NoticeService(auth.db).delete_datas(ids.ids)
    return RestResponse.success()


@app.post("/notice/update/{data_id}", summary="更新信息")
async def update_data(
        data_id: int,
        dto: NoticeSaveDTO,
        auth: Auth = Depends(FullAdminAuth(permissions=["system.notice.update"]))):
    await service.NoticeService(auth.db).put_data(data_id, dto)
    return RestResponse.success()


@app.get("/notice/get/{data_id}", summary="获取信息")
async def get(
        data_id: int,
        auth: Auth = Depends(FullAdminAuth(permissions=["system.notice.list"]))):
    data=await service.NoticeService(auth.db).get_for_admin(data_id)
    return RestResponse.success(data=data)


@app.post("/notice/query", summary="列表查询")
async def query_list(
        params: NoticeAdminQueryDTO,
        auth: Auth = Depends(FullAdminAuth(permissions=["system.notice.list"]))):
    datas, count = await service.NoticeService(auth.db).query_for_admin(params, need_count=True)
    return RestResponse.success(data=datas, count=count)
