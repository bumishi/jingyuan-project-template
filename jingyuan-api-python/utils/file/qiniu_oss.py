#!/usr/bin/python
# -*- coding: utf-8 -*-

import os.path

from fastapi import UploadFile
from pydantic import BaseModel
from qiniu import Auth, put_data

from core.exception import CustomException
from core.logger import logger
from utils import status
from utils.file.compress.cpressJPG import compress_jpg_png
from utils.file.file_base import FileBase
from utils.file.file_manage import FileManage


class BucketConf(BaseModel):
    accessKeyId: str
    accessKeySecret: str
    bucket: str
    domain: str


class QiniuOSS(FileBase):
    def __init__(self, bucket: BucketConf):
        self.auth = Auth(bucket.accessKeyId, bucket.accessKeySecret)
        self.bucket = bucket.bucket
        self.domain = bucket.domain

    async def upload_image(self, path: str, file: UploadFile, compress: bool = False, max_size: int = 5) :
        """
        上传图片

        :param path: path由包含文件后缀，不包含Bucket名称组成的Object完整路径，例如abc/efg/123.jpg。
        :param file: 文件对象
        :param compress: 是否压缩该文件
        :param max_size: 图片文件最大值，单位 MB，默认 10MB
        :return: 上传后的文件oss链接
        """
        # 验证图片类型
        await self.validate_file(file, max_size, self.IMAGE_ACCEPT)
        # 生成文件路径
        path = self.generate_static_file_path(path, file.filename)
        if compress:
            # 压缩图片
            file_path = await FileManage.async_save_temp_file(file)
            new_file = compress_jpg_png(file_path, originpath=os.path.abspath(file_path))
            with open(new_file, "rb") as f:
                file_data = f.read()
        else:
            file_data = await file.read()
        return await self.__upload_file_to_oss(path, file_data)

    async def upload_video(self, path: str, file: UploadFile, max_size: int = 100) :
        """
        上传视频

        :param path: path由包含文件后缀，不包含Bucket名称组成的Object完整路径，例如abc/efg/123.jpg。
        :param file: 文件对象
        :param max_size: 视频文件最大值，单位 MB，默认 100MB
        :return: 上传后的文件oss链接
        """
        # 验证图片类型
        await self.validate_file(file, max_size, self.VIDEO_ACCEPT)
        # 生成文件路径
        path = self.generate_static_file_path(path, file.filename)
        file_data = await file.read()
        return await self.__upload_file_to_oss(path, file_data)

    async def upload_file(self, path: str, file: UploadFile) -> str:
        """
        上传文件

        :param path: path由包含文件后缀，不包含Bucket名称组成的Object完整路径，例如abc/efg/123.jpg。
        :param file: 文件对象
        :return: 上传后的文件oss链接
        """
        path = self.generate_static_file_path(path, file.filename)
        file_data = await file.read()
        return await self.__upload_file_to_oss(path, file_data)

    async def __upload_file_to_oss(self, path: str, file_data: bytes):
        """
        上传文件到OSS

        :param path: path由包含文件后缀，不包含Bucket名称组成的Object完整路径，例如abc/efg/123.jpg。
        :param file_data: 文件数据
        :return: 上传后的文件oss链接
        """
        # 上传文件到存储后， 存储服务将文件名和文件大小回调给业务服务器。
        # policy = {
        #     'callbackUrl': 'http://your.domain.com/callback.php',
        #     'callbackBody': 'filename=$(fname)&filesize=$(fsize)'
        # }
        token = self.auth.upload_token(self.bucket, path, 30)
        ret, info = put_data(token, path, file_data)
        if not ret['key']:
            logger.error(f"文件上传到OSS失败：{ret}")
            raise CustomException("上传文件失败", code=status.HTTP_ERROR)
        return {'path': path, 'url': self.domain + '/' + path}
