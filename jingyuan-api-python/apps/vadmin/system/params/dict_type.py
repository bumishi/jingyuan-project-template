#!/usr/bin/python
# -*- coding: utf-8 -*-
# @version        : 1.0
# @Create Time    : 2021/10/18 22:19
# @File           : dict_type.py
# @IDE            : PyCharm
# @desc           : 查询参数-类依赖项

"""
类依赖项-官方文档：https://fastapi.tiangolo.com/zh/tutorial/dependencies/classes-as-dependencies/
"""
from fastapi import Depends
from core.dependencies import Paging, QueryParams


class DictTypeParams(QueryParams):
    """
    列表分页
    """
    def __init__(self, dict_name: str = None, dict_type: str = None, params: Paging = Depends()):
        super().__init__(params)
        self.dict_name = ("like", dict_name)
        self.dict_type = ("like", dict_type)
