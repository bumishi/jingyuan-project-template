#!/usr/bin/python
# -*- coding: utf-8 -*-
# @version        : 1.0

"""
Python SDK 官方文档：https://help.aliyun.com/document_detail/215764.html?spm=a2c4g.11186623.0.0.6a0c4198XsBJNW

环境要求
Python 3
安装 SDK 核心库 OpenAPI ，使用pip安装包依赖:
pip install alibabacloud_tea_openapi
pip install alibabacloud_dysmsapi20170525
"""
import random
import re
from typing import List

from pydantic import BaseModel
from tencentcloud.common import credential
# 导入对应产品模块的client models。
from tencentcloud.sms.v20210111 import sms_client, models

from application.settings import TENCENT_SMS
from core.exception import CustomException


# 导入可选配置类


class SmsConf(BaseModel):
    secretId: str
    secretKey: str
    region: str
    SmsSdkAppId: str
    SignName: str
    TemplateId: str


class TecentSMS():
    def __init__(self, telephones: List[str]):
        self.check_telephones_format(telephones)
        self.telephones = telephones
        self.conf = SmsConf(**TENCENT_SMS)

    def main(self, **kwargs) -> List[bool]:
        """
        主程序入口，异步方式

        redis 对象必填
        """
        result = []
        for telephone in self.telephones:
            result.append(self._send(telephone, **kwargs))
        return result

    def _send(self, telephone: str, **kwargs) -> bool:
        """
        发送短信
        """

        cred = credential.Credential(self.conf.secretId, self.conf.secretKey)
        # 实例化要请求产品(以sms为例)的client对象
        # 第二个参数是地域信息，可以直接填写字符串ap-guangzhou，支持的地域列表参考 https://cloud.tencent.com/document/api/382/52071#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8
        client = sms_client.SmsClient(cred, self.conf.region)

        # 实例化一个请求对象，根据调用的接口和实际情况，可以进一步设置请求参数
        # 您可以直接查询SDK源码确定SendSmsRequest有哪些属性可以设置
        # 属性可能是基本类型，也可能引用了另一个数据结构
        # 推荐使用IDE进行开发，可以方便的跳转查阅各个接口和数据结构的文档说明
        req = models.SendSmsRequest()

        # 基本类型的设置:
        # SDK采用的是指针风格指定参数，即使对于基本类型您也需要用指针来对参数赋值。
        # SDK提供对基本类型的指针引用封装函数
        # 帮助链接：
        # 短信控制台: https://console.cloud.tencent.com/smsv2
        # 腾讯云短信小助手: https://cloud.tencent.com/document/product/382/3773#.E6.8A.80.E6.9C.AF.E4.BA.A4.E6.B5.81

        # 短信应用ID: 短信SdkAppId在 [短信控制台] 添加应用后生成的实际SdkAppId，示例如1400006666
        # 应用 ID 可前往 [短信控制台](https://console.cloud.tencent.com/smsv2/app-manage) 查看
        req.SmsSdkAppId = self.conf.SmsSdkAppId
        # 短信签名内容: 使用 UTF-8 编码，必须填写已审核通过的签名
        # 签名信息可前往 [国内短信](https://console.cloud.tencent.com/smsv2/csms-sign) 或 [国际/港澳台短信](https://console.cloud.tencent.com/smsv2/isms-sign) 的签名管理查看
        req.SignName = self.conf.SignName
        # 模板 ID: 必须填写已审核通过的模板 ID
        # 模板 ID 可前往 [国内短信](https://console.cloud.tencent.com/smsv2/csms-template) 或 [国际/港澳台短信](https://console.cloud.tencent.com/smsv2/isms-template) 的正文模板管理查看
        req.TemplateId = self.conf.TemplateId
        # 模板参数: 模板参数的个数需要与 TemplateId 对应模板的变量个数保持一致，，若无模板参数，则设置为空
        req.TemplateParamSet = [kwargs['code']]
        # 下发手机号码，采用 E.164 标准，+[国家或地区码][手机号]
        # 示例如：+8613711112222， 其中前面有一个+号 ，86为国家码，13711112222为手机号，最多不要超过200个手机号
        req.PhoneNumberSet = ["+86" + telephone]

        resp = client.SendSms(req)

        # 输出json格式的字符串回包
        #print(resp.to_json_string(indent=2))
        if len(resp.SendStatusSet) > 0 and resp.SendStatusSet[0].Code == 'Ok':
            return True
        return False

    @staticmethod
    def get_code(length: int = 6, blend: bool = False) -> str:
        """
        随机获取短信验证码
        短信验证码只支持数字，不支持字母及其他符号

        :param length: 验证码长度
        :param blend: 是否 字母+数字 混合
        """
        code = ""  # 创建字符串变量,存储生成的验证码
        for i in range(length):  # 通过for循环控制验证码位数
            num = random.randint(0, 9)  # 生成随机数字0-9
            if blend:  # 需要字母验证码,不用传参,如果不需要字母的,关键字alpha=False
                upper_alpha = chr(random.randint(65, 90))
                lower_alpha = chr(random.randint(97, 122))
                # 随机选择其中一位
                num = random.choice([num, upper_alpha, lower_alpha])
            code = code + str(num)
        return code

    @classmethod
    def check_telephones_format(cls, telephones: List[str]) -> bool:
        """
        同时检查多个手机号格式是否合法

        不合法就会抛出异常
        """
        for telephone in telephones:
            cls.check_telephone_format(telephone)
        return True

    @staticmethod
    def check_telephone_format(telephone: str) -> bool:
        """
        检查手机号格式是否合法

        不合法就会抛出异常
        """
        REGEX_TELEPHONE = r'^1(3\d|4[4-9]|5[0-35-9]|6[67]|7[013-8]|8[0-9]|9[0-9])\d{8}$'

        if not telephone:
            raise CustomException(msg=f"手机号码（{telephone}）不能为空", code=400)
        elif not re.match(REGEX_TELEPHONE, telephone):
            raise CustomException(msg=f"手机号码（{telephone}）格式不正确", code=400)
        return True
