# 依赖安装：pip install orjson
from fastapi.responses import ORJSONResponse as Response
from fastapi import status as http_status
from utils import status as http
from pydantic import BaseModel
from typing import Any,Optional

class RestResponse(BaseModel):
    code:int=200
    message:str=''
    count:Optional[int]=None
    has_next:bool|None=None
    data:Any=None

    def success(data=None,count=None,has_next=None):
        return RestResponse(data=data,count=count,has_next=has_next)

    def fail(code:int=-1,message:str=''):
        return RestResponse(code=code,message=message)

class SuccessResponse(Response):
    """
    成功响应
    """
    def __init__(self, data=None, msg="操作成功", code=http.HTTP_SUCCESS, status=http_status.HTTP_200_OK
                 , **kwargs):
        self.data = {
            "code": code,
            "message": msg,
            "data": data
        }
        self.data.update(kwargs)
        super().__init__(content=self.data, status_code=status)


class ErrorResponse(Response):
    """
    失败响应
    """
    def __init__(self, msg=None, code=http.HTTP_ERROR, status=http_status.HTTP_200_OK, **kwargs):
        self.data = {
            "code": code,
            "message": msg,
            "data": []
        }
        self.data.update(kwargs)
        super().__init__(content=self.data, status_code=status)
