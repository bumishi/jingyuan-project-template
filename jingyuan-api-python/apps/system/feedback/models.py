from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy.orm import relationship, Mapped, mapped_column
from core.database import Base
from core.data_types import DatetimeStr,DateStr
from sqlalchemy import String, Boolean, Integer,DateTime,Text,BigInteger,Numeric,func,Date
from datetime import datetime,date
from decimal import Decimal
from typing import Optional,List

class UserFeedback(Base):
    __tablename__ = "user_feedback"
    __table_args__ = ({'comment': '用户反馈'})
    
    id: Mapped[int] = mapped_column(Integer, primary_key=True,comment='id')
    catalog: Mapped[str] = mapped_column(String,comment='分类')
    mark: Mapped[str] = mapped_column(String,comment='描述',nullable=True)
    attachs: Mapped[str] = mapped_column(String,comment='附件图片地址',nullable=True)
    user_id: Mapped[int] = mapped_column(Integer,comment='用户',nullable=True)
    concat: Mapped[str] = mapped_column(Integer,comment='联系方式',nullable=True)
    create_time: Mapped[datetime] = mapped_column(DateTime,comment='创建时间',server_default=func.now(),nullable=True)

class UserFeedbackSaveDTO(BaseModel):
 
    #分类
    catalog: str
    #描述
    mark: Optional[str]=None
    urls:list[str]=[]
    #附件图片地址
    attachs: str=None
    #用户
    user_id: Optional[int]=None
    #联系方式
    concat: Optional[int]=None

class UserFeedbackApiQueryDTO(BaseModel):
    page:int|None=1
    limit:int|None=10
    last_id:Optional[int|None]=0
    user_id:Optional[int|None]=0

class UserFeedbackApiVO(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    #id
    id: Optional[int] = None
    #分类
    catalog: Optional[str] = None
    #描述
    mark: Optional[str] = None
    #附件图片地址
    attachs: Optional[str] = None
    #用户
    user_id: Optional[int] = None
    #联系方式
    concat: Optional[int] = None
    #用户
    create_time: Optional[DatetimeStr ] = None

class UserFeedbackAdminQueryDTO(BaseModel):
    page:int|None=1
    limit:int|None=10

    #分类
    catalog: Optional[str] = None

class UserFeedbackAdminVO(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    #id
    id: Optional[int] = None
    #分类
    catalog: Optional[str] = None
    #描述
    mark: Optional[str] = None
    #附件图片地址
    attachs: Optional[str] = None
    #用户
    user_id: Optional[int] = None
    #联系方式
    concat: Optional[int] = None
    #用户
    create_time: Optional[DatetimeStr ] = None

