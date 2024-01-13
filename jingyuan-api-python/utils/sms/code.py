#!/usr/bin/python
# -*- coding: utf-8 -*-
# @version        : 1.0
# @Create Time    : 2023/6/14 15:55 
# @File           : code.py
# @IDE            : PyCharm
# @desc           : 发送验证码短信

import datetime
import warnings
from redis.asyncio import Redis
from .tencent import TecentSMS
from core.logger import logger
from core.exception import CustomException


class CodeSMS(TecentSMS):

    def __init__(self, telephone: str, rd: Redis):
        super().__init__([telephone])
        self.rd = rd
        self.telephone = telephone

    async def send_msg(self, code: str = None) -> bool:
        """
        主程序入口，异步方式

        redis 对象必填
        """

        send_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        if await self.rd.get(self.telephone + "_flag_"):
            logger.error(f'{send_time} {self.telephone} 短信发送失败，短信发送过于频繁')
            raise CustomException(msg="短信发送频繁", code=400)
        result = self._send(self.telephone, code=code)
        # result=True
        if result:
            await self.rd.set(self.telephone, code, 120)
            await self.rd.set(self.telephone + "_flag_", code, 60)
        return result

    async def check_sms_code(self, code: str) -> bool:
        """
        检查短信验证码是否正确
        """
        if code and code == await self.rd.get(self.telephone):
            await self.rd.delete(self.telephone)
            await self.rd.delete(self.telephone + "_flag_")
            return True
        return False
