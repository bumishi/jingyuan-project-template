from fastapi import APIRouter, Depends

from apps.vadmin.auth.utils.current import FullAdminAuth
from apps.vadmin.auth.utils.validation.auth import Auth
from utils.response import RestResponse
from . import service
from .models import *

app = APIRouter()


@app.post("/feedback/query", summary="列表查询")
async def query_list(
        params: UserFeedbackAdminQueryDTO,
        auth: Auth = Depends(FullAdminAuth(permissions=["system.feedback.list"]))):
    datas, count = await service.UserFeedbackService(auth.db).query_for_admin(params, need_count=True)
    return RestResponse.success(data=datas, count=count)
