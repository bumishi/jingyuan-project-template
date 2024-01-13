from fastapi import APIRouter, Depends

from apps.vadmin.auth.utils.current import AllUserAuth
from apps.vadmin.auth.utils.validation.auth import Auth
from core.dependencies import IdList
from .models import *
from utils.response import SuccessResponse, RestResponse
from . import service

app = APIRouter()


@app.post("/feedback/add", summary="新增操作")
async def add_data(dto: UserFeedbackSaveDTO, auth: Auth = Depends(AllUserAuth())):
    dto.user_id=auth.user.id
    if dto.urls and len(dto.urls)>0:
         attach_str=''
         for img in dto.urls:
             attach_str=attach_str+img+","
         dto.attachs=attach_str[0:-1]
    id=await service.UserFeedbackService(auth.db).create_data(dto)
    return RestResponse.success(data=id)

