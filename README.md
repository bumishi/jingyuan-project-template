
## [关于]

<div align="center">
<img src="https://cos.bumishi.cn/APP-Startter-logo.png"
</div>

<div align="center"><h3 align="center"> 这是一个适用于任何类型项目的开发模板，可基于此项目快速开发业务可以作为新项目的启动模版！
</h3></div>

<div align="center"><h3 align="center">前后端分离架构，开箱即用，紧随前沿技术！</h3></div>

<div align="center"><h3 align="center">高性能，高效率，高颜值，易扩展</h3></div>


## 介绍
本项目包含且只包含最基本的登录、注册、腾讯短信验证码、微信登录、用户中心、系统公告、系统配置、用户反馈、字典维护、后台权限管理相关的菜单、角色、用户、七牛云存储文件上传，这是任何项目都基本需要的基础功能。
包含了后端api、VUE3管理后台前端、产品端uniapp(小程序+ios+android)、定时任务、代码生成器五个模块。

- 后端语言为Python3,基于高性能异步IO协程,PC管理后台及后端项目基于[kinit](https://gitee.com/ktianc/kinit/tree/master)整合；
- PC端采用 [vue-element-plus-admin 2.2.0](https://gitee.com/kailong110120130/vue-element-plus-admin) 、[Vue3](https://cn.vuejs.org/guide/introduction.html)、[Element Plus](https://element-plus.gitee.io/zh-CN/guide/design.html)、[TypeScript](https://www.tslang.cn/)等主流技术开发；
- 移动端采用 [uni-app](https://uniapp.dcloud.net.cn/component/)，[Vue3](https://v3.cn.vuejs.org)，为主要技术开发,项目基于[shopro-uniapp](https://gitee.com/sheepjs/shopro-uniapp)整合；
- 已加入定时任务功能，采用 [APScheduler](https://github.com/agronholm/apscheduler) 定时任务框架 + [Redis](https://redis.io/)  消息队列 + [MongoDB](https://www.mongodb.com/) 持久存储；
- 权限认证使用[（哈希）密码和 JWT Bearer 令牌的 OAuth2](https://fastapi.tiangolo.com/zh/tutorial/security/oauth2-jwt/)，支持多终端认证系统。
- 支持加载动态权限菜单，多方式轻松权限控制，按钮级别权限控制。
- 已加入常见的 [MySQL](https://www.mysql.com/) + [MongoDB](https://www.mongodb.com/) + [Redis](https://redis.io/)  数据库异步操作。
- 永久免费开源

## 源码地址

gitee地址：https://gitee.com/xieqiangcode/jingyuan-project-template

github地址：https://github.com/bumishi/jingyuan-project-template

## PC端内置功能

- [x] 菜单管理：配置系统菜单，操作权限，按钮权限标识、后端接口权限等。

- [x] 角色管理：角色菜单权限分配。

- [x] 用户管理：后台管理的用户与app的用户集成在一张表，通过is_staff标识，该功能主要完成系统用户配置。

- [x] 字典管理：对系统中经常使用的一些较为固定的数据进行维护。

- [x] 文件上传：对接七牛云与本地存储。

- [x] 登录认证：目前支持用户使用手机号+密码登录方式，手机验证码登录方式。

  说明：新建用户密码默认为手机号后六位；

  说明：用户在第一次登录时，必须修改当前用户密码。

- [x] 系统配置：对本系统环境信息进行动态配置

  网站标题，LOGO，描述，ICO，备案号，底部内容，微信小程序信息，等等

- [x] 系统公告：管理系统公告。

- [x] 用户反馈查询：APP支持提交反馈，后台管理支持查询。

- [x] 登录日志：用户登录日志记录和查询。

- [x] 接口文档：提供自动生成的交互式 API 文档，与 ReDoc 文档

- [x] 导入导出：灵活支持数据导入导出功能

- [x] 已加入常见的`Redis`、`MySQL`、`MongoDB`数据库异步操作。

- [x] 定时任务：在线操作（添加、修改、删除)任务调度包含查看任务执行结果日志。

## 移动端产品内置功能

- [x] 登录认证：支持用户使用手机号+验证码注册、手机号+密码登录、手机号+验证码登录、微信一键登录方式。

 - [x] 用户中心：编辑资料、头像修改、密码修改、手机号绑定、退出等
 
 - [x] 系统基础功能：动态展示系统公告、用户协议、关于、常见问题、意见反馈

##  前序准备

### 后端技术

- [Python3](https://www.python.org/downloads/windows/)：熟悉 python3 基础语法
- [FastAPI](https://fastapi.tiangolo.com/zh/) - 熟悉后台接口 Web 框架
- [SQLAlchemy 2.0](https://docs.sqlalchemy.org/en/20/index.html) - 数据数据库操作
- [MySQL](https://www.mysql.com/)


### PC端

- [node](https://gitee.com/link?target=http%3A%2F%2Fnodejs.org%2F) 和 [git](https://gitee.com/link?target=https%3A%2F%2Fgit-scm.com%2F) - 项目开发环境
- [Vite](https://gitee.com/link?target=https%3A%2F%2Fvitejs.dev%2F) - 熟悉 vite 特性
- [Vue3](https://gitee.com/link?target=https%3A%2F%2Fv3.vuejs.org%2F) - 熟悉 Vue 基础语法
- [TypeScript](https://gitee.com/link?target=https%3A%2F%2Fwww.typescriptlang.org%2F) - 熟悉 `TypeScript` 基本语法
- [Es6+](https://gitee.com/link?target=http%3A%2F%2Fes6.ruanyifeng.com%2F) - 熟悉 es6 基本语法
- [Vue-Router-Next](https://gitee.com/link?target=https%3A%2F%2Fnext.router.vuejs.org%2F) - 熟悉 vue-router 基本使用
- [Element-Plus](https://gitee.com/link?target=https%3A%2F%2Felement-plus.org%2F) - element-plus 基本使用
- [vue3-json-viewer](https://gitee.com/isfive/vue3-json-viewer)：简单易用的json内容展示组件,适配vue3和vite。
- [高德地图API (amap.com)](https://lbs.amap.com/api/jsapi-v2/guide/webcli/map-vue1)：地图 JSAPI 2.0 是高德开放平台免费提供的第四代 Web 地图渲染引擎。

### 移动端

- [uni-app](https://uniapp.dcloud.net.cn/component/) - 熟悉 uni-app 基本语法
- [Vue3](https://cn.vuejs.org) - 熟悉 Vue3 基础语法


### 定时任务

- [Python3](https://www.python.org/downloads/windows/) -熟悉 python3 基础语法
- [APScheduler](https://github.com/agronholm/apscheduler) - 熟悉定时任务框架
- [MongoDB](https://www.mongodb.com/) 和 [Redis](https://redis.io/)  - 熟悉数据存储数据库

## 安装和使用

### 准备工作

```
Python == 3.10 (其他版本均未测试)
nodejs >= 14.0 (推荐使用最新稳定版)
Mysql >= 8.0
Redis (推荐使用最新稳定版)
```

获取代码

```
git clone https://gitee.com/xieqiangcode/jingyuan-project-template
```

### 后端

1. 安装依赖

   ```
   cd jingyuan-api-python
   
   pip3 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/
   ```

2. 修改项目环境配置

   修改 `application/settings.py` 文件

   ```python
   # 安全警告: 不要在生产中打开调试运行!
   DEBUG = True # 如果当前为开发环境则改为 True，如果为生产环境则改为 False

3. 修改项目数据库配置信息

   在 `application/config` 目录中

   - development.py：开发环境

   - production.py：生产环境

   ```python
   # Mysql 数据库配置项
   # 连接引擎官方文档：https://www.osgeo.cn/sqlalchemy/core/engines.html
   # 数据库链接配置说明：mysql+asyncmy://数据库用户名:数据库密码@数据库地址:数据库端口/数据库名称
   
   SQLALCHEMY_DATABASE_URL = "mysql+asyncmy://数据库用户名:数据库密码@数据库地址:数据库端口/数据库名称"
   SQLALCHEMY_DATABASE_TYPE = "mysql"
   
   
   # Redis 数据库配置
   REDIS_DB_ENABLE = True
   REDIS_DB_URL = "redis://:密码@地址:端口/数据库"
   
   
   # 七牛云对象存储OSS配置
   QINIU_OSS = {
       "accessKeyId": "accessKeyId",
       "accessKeySecret": "accessKeySecret",
        "bucket": "bucket",
       "domain": "访问域名"
   }
   
4. 创建数据库

   ```
   mysql> create database `jingyuan-starter`;             # 创建数据库
   mysql> use `jingyuan-starter`;                         # 使用已创建的数据库 
   mysql> set names utf8;                    # 设置编码
   ```

5. 初始化数据库
    在数据库中执行jingyuan-api-python/database.sql

6. 启动

   ```
   # 进入项目根目录下执行
   python3 main.py run
   ```

7. 调试方式启动
    pycharm 直接以调式方式运行main.py
    
### PC端

1. 安装依赖

```
cd jingyuan-admin

pnpm install
```

2. 运行

```
pnpm run dev
```
然后浏览器打开http://localhost:5000

3. 打包

```
pnpm run build
```
###uniapp端

1. 安装依赖

```
cd jingyuan-product-uniapp

pnpm install
```
在HbuildX中运行


### 定时任务

1. 安装依赖

   ```
   # 安装依赖库
   pip3 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/
   
   # 第三方源：
   1. 阿里源： https://mirrors.aliyun.com/pypi/simple/
   ```

2. 修改项目数据库配置信息

   在 `application/config` 目录中

   - development.py：开发环境

   - production.py：生产环境

   ```python
   # MongoDB 数据库配置
   # 与接口是同一个数据库
   MONGO_DB_NAME = "数据库名称"
   MONGO_DB_URL = f"mongodb://用户名:密码@地址:端口/?authSource={MONGO_DB_NAME}"
   
   
   # Redis 数据库配置
   # 与接口是同一个数据库
   REDIS_DB_URL = "redis://:密码@地址:端口/数据库名称"
   ```
   
3. 启动

   ```
   python3 main.py
   ```


### 访问项目

- 访问地址：http://localhost:5000 (默认为此地址，如有修改请按照配置文件)
- 账号：`18975828726` 密码：`jingyuan2024`
- 接口地址：http://localhost:9000/docs (默认为此地址，如有修改请按照配置文件)

## 如何贡献

你可以提交一个 Pull Request。

**Pull Request:**

1. Fork 代码
2. 创建自己的分支: `git checkout -b feat/xxxx`
3. 提交你的修改: `git commit -am 'feat(function): add xxxxx'`
4. 推送您的分支: `git push origin feat/xxxx`
5. 提交 `pull request`

## 浏览器支持

本地开发推荐使用 `Chrome 80+` 浏览器

支持现代浏览器, 不支持 IE

| IE          | Edge            | Firefox         | Chrome          | Safari          |
| ----------- | --------------- | --------------- | --------------- | --------------- |
| not support | last 2 versions | last 2 versions | last 2 versions | last 2 versions |

## 许可证

[MIT](https://gitee.com/kailong110120130/vue-element-plus-admin/blob/master/LICENSE)

## PC管理后台端演示图

![](https://cos.bumishi.cn/17051365200654.jpg)

![](https://cos.bumishi.cn/17051365949794.jpg)

![](https://cos.bumishi.cn/17051366533475.jpg)

![](https://cos.bumishi.cn/17051367214696.jpg)

![](https://cos.bumishi.cn/17051367386253.jpg)

![](https://cos.bumishi.cn/17051367527258.jpg)

![](https://cos.bumishi.cn/17051367689076.jpg)

![](https://cos.bumishi.cn/17051367837614.jpg)

![](https://cos.bumishi.cn/17051368146324.jpg)


## 产品端H5,微信小程序端演示图
![](https://cos.bumishi.cn/17051371676051.jpg)

![](https://cos.bumishi.cn/17051371904383.jpg)

![](https://cos.bumishi.cn/17051453206611.jpg)

![](https://cos.bumishi.cn/17051453556613.jpg)

![](https://cos.bumishi.cn/17051453784760.jpg)

![](https://cos.bumishi.cn/17051454054850.jpg)

![](https://cos.bumishi.cn/17051455678997.jpg)

![](https://cos.bumishi.cn/17051458803050.jpg)

![](https://cos.bumishi.cn/17051458947347.jpg)



## 关于我们

微信公众号:全栈编程实战

qq交流群:
![](https://cos.bumishi.cn/17051525339946.jpg)

