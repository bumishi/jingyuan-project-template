# Flutter Template

Flutter Template 是一个`高质量`、易于使用的 `Flutter 项目模板`，包含完整的用户中心功能，配合此项目的后端API，实现了诸如登录、注册、修改用户信息等基本用户中心功能，旨在帮助开发者`快速构建`出色的跨平台应用程序。该模板采用了 `Get 框架`、`优秀的设计模式`和`合理的文件结构`。

## 特点

- 使用 [Get](https://pub.dev/packages/get) 框架进行状态管理、依赖注入和路由管理，简化了应用程序的开发和维护。
- 采用模块化的设计模式，使代码结构清晰、组织良好，便于扩展和维护。
- `dio` 网络请求框架，轻松处理网络请求，支持拦截器，支持便捷的错误处理，请求重试，请求缓存等功能。
- 轻松替换 app 的 icon。
- 包含一些预构建的组件和页面，以帮助开发者快速开始构建应用程序。
- 开箱即用，开发者只需要关注业务即可。


## 项目结构

应用程序的结构如下所示：


- `components\` 放置了一些预构建的组件，以帮助开发者快速开始构建应用程序。
- `service\` 放置应用程序的服务，如网络请求服务等等。
- `controller\` 放置了一些控制器，可以参考 [Get](https://pub.dev/packages/get)。 如何写 controller，来实现全局数据管理
- `repository\` 放置了一些数据仓库，如数据storage操作，主要是处理数据的逻辑。
- `pages\` 放置了一些页面，如首页等，其他页面放置在此。
- `routes.dart` 定义了应用程序的路由。
- `main.dart` 是应用程序的入口文件，包括主题配置，基本不需要修改这里。

## 快速开始

要开始使用 Flutter Template，请按照以下步骤操作：

1. 克隆此仓库：


2. 进入项目目录：

```

cd flutter

```

3. 获取依赖项：

```

flutter pub get

```

4. 运行项目：

```

flutter run

```

现在，你已经成功运行了 Flutter Template，并可以开始构建你的应用程序。


## 许可证

本项目采用 [MIT 许可证](https://github.com/bravekingzhang/flutter_template/blob/main/LICENSE)。

```

```
