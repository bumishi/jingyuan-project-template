from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy.orm import relationship, Mapped, mapped_column
from core.database import Base
from core.data_types import DatetimeStr,DateStr
from sqlalchemy import String, Boolean, Integer,DateTime,Text,BigInteger,Numeric,func,Date
from datetime import datetime,date
from decimal import Decimal
from typing import Optional

class UserThirdBind(Base):
    __tablename__ = "user_third_bind"
    __table_args__ = ({'comment': '用户绑定的第三方登录账号'})
    
    user_id: Mapped[int] = mapped_column(Integer,comment='')
    open_id: Mapped[str] = mapped_column(String, primary_key=True,comment='第三方用户id')
    third_type: Mapped[str] = mapped_column(String, primary_key=True,comment='第三方应用类型(weixin,douying)')
    union_id: Mapped[str] = mapped_column(String,comment='微信跨应用的唯一id',nullable=True)
    bind_time: Mapped[datetime] = mapped_column(DateTime,comment='绑定时间',nullable=True)

class ThirdLoginVO(BaseModel):

    #第三方用户id
    open_id: str
    #第三方应用类型(weixin,douying)
    third_type: str
    #微信跨应用的唯一id
    union_id: Optional[str]=None

class UserThirdBindSaveDTO(BaseModel):

    #第三方用户id
    open_id: str
    #第三方应用类型(weixin,douying)
    third_type: str
    #微信跨应用的唯一id
    union_id: Optional[str]=None
    mobile: Optional[str] = None


class WechatBindParams(BaseModel):
    mobile: str | None = None
    code: str
    method: str = '2'  # 认证方式，0：密码登录，1：短信登录，2：微信一键登录
    platform: str = '1'  # 登录平台，0：PC端管理系统，1：移动端管理系统
