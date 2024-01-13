from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy.orm import relationship, Mapped, mapped_column
from core.database import Base
from core.data_types import DatetimeStr,DateStr
from sqlalchemy import String, Boolean, Integer,DateTime,Text,BigInteger,Numeric,func,Date
from datetime import datetime,date
from decimal import Decimal
from typing import Optional

class Notice(Base):
    __tablename__ = "vadmin_notice"
    __table_args__ = ({'comment': '系统运营公告'})
    
    id: Mapped[int] = mapped_column(Integer, primary_key=True,comment='ID')
    title: Mapped[str] = mapped_column(String,comment='标题')
    detail: Mapped[str] = mapped_column(String,comment='内容')
    begin_time: Mapped[datetime] = mapped_column(DateTime,comment='开始时间')
    end_time: Mapped[datetime] = mapped_column(DateTime,comment='结束时间')
    create_time: Mapped[datetime] = mapped_column(DateTime,comment='创建时间',server_default=func.now(),nullable=True)
    update_time: Mapped[datetime] = mapped_column(DateTime,comment='修改时间',server_default=func.now(),onupdate=func.now(),nullable=True)

class NoticeSaveDTO(BaseModel):
 
    #标题
    title: str
    #内容
    detail: str
    #开始时间
    begin_time: datetime
    #结束时间
    end_time: datetime

class NoticeApiVO(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    #ID
    id: Optional[int] = None
    #标题
    title: Optional[str] = None
    #内容
    detail: Optional[str] = None


class NoticeAdminQueryDTO(BaseModel):
    page:int|None=1
    limit:int|None=10

    #标题
    title: Optional[str] = None

class NoticeAdminVO(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    #ID
    id: Optional[int] = None
    #标题
    title: Optional[str] = None
    #内容
    detail: Optional[str] = None
    #开始时间
    begin_time: Optional[DatetimeStr ] = None
    #结束时间
    end_time: Optional[DatetimeStr ] = None
    #创建时间
    create_time: Optional[DatetimeStr ] = None

