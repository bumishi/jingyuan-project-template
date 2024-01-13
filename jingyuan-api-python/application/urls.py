# -*- coding: utf-8 -*-
# @version        : 1.0
# @Create Time    : 2021/10/19 15:47
# @File           : urls.py
# @IDE            : PyCharm
# @desc           : 路由文件

from apps.vadmin.auth.login import app as auth_app
from apps.vadmin.auth.usercenter import app as usercenter_app
from apps.vadmin.auth.views import app as vadmin_auth_app
from apps.vadmin.system.views import app as vadmin_system_app
from apps.vadmin.record.views import app as vadmin_record_app
from apps.vadmin.workplace.views import app as vadmin_workplace_app
from apps.vadmin.help.views import app as vadmin_help_app
from apps.vadmin.resource.views import app as vadmin_resource_app
from  apps.system.notice.views_admin import app as vadmin_notice_app
from  apps.system.notice.views_api import app as api_notice_app
from  apps.system.feedback.views_api import app as api_feedback_app
from  apps.system.feedback.views_admin import app as vadmin_feedback_app
from apps.system.common_api import app as common_app
# 引入应用中的路由
urlpatterns = [
    {"ApiRouter": common_app, "prefix": "/system", "tags": ["系统基础接口"]},
    {"ApiRouter": api_notice_app, "prefix": "/system", "tags": ["系统公告"]},
    {"ApiRouter": api_feedback_app, "prefix": "/system", "tags": ["用户反馈"]},

    {"ApiRouter": auth_app, "prefix": "/auth", "tags": ["系统认证"]},
    {"ApiRouter": usercenter_app, "prefix": "/usercenter", "tags": ["用户中心"]},
    {"ApiRouter": vadmin_auth_app, "prefix": "/vadmin/auth", "tags": ["权限管理"]},
    {"ApiRouter": vadmin_record_app, "prefix": "/vadmin/record", "tags": ["记录管理"]},

    {"ApiRouter": vadmin_system_app, "prefix": "/vadmin/system", "tags": ["系统设置管理"]},
    {"ApiRouter": vadmin_notice_app, "prefix": "/vadmin/system", "tags": ["系统公告管理"]},
    {"ApiRouter": vadmin_feedback_app, "prefix": "/vadmin/system", "tags": ["用户反馈"]},
    {"ApiRouter": vadmin_help_app, "prefix": "/vadmin/help", "tags": ["帮助中心管理"]},
    {"ApiRouter": vadmin_resource_app, "prefix": "/vadmin/resource", "tags": ["资源管理"]},

    {"ApiRouter": vadmin_workplace_app, "prefix": "/vadmin/workplace", "tags": ["工作区管理"]},



]
