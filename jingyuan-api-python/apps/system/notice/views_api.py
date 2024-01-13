from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from core.database import db_getter
from utils.response import RestResponse
from . import service

app = APIRouter()


@app.get("/notice/query", summary="列表查询")
async def query_list(
        db: AsyncSession = Depends(db_getter)
):
    datas= await service.NoticeService(db).query_for_api()
    return RestResponse.success(data=datas)

@app.get("/notice/get/{data_id}", summary="获取信息")
async def get(
        data_id: int,
        db: AsyncSession = Depends(db_getter)):
    data=await service.NoticeService(db).get_for_api(data_id)
    return RestResponse.success(data=data)

