import 'package:flutter/cupertino.dart';
import 'package:flutter_template/pages/detail.dart';

import 'package:flutter_template/pages/home.dart';

import 'package:flutter_template/pages/login/login.dart';
import 'package:flutter_template/pages/usercenter/about_us.dart';
import 'package:flutter_template/pages/usercenter/private_policy.dart';
import 'package:flutter_template/pages/usercenter/user_agreement.dart';
import 'package:flutter_template/pages/usercenter/info.dart';
import 'package:flutter_template/pages/usercenter/usercenter.dart';

import 'package:flutter_template/repository/userinfo_storage.dart';
import 'package:get/get.dart';

//路由中间件:要求登录才能进入
class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // print('route:$route');
    bool hasLogin = isLogin();
    return hasLogin ? null : const RouteSettings(name: '/login');
  }
}

var middlewares = [AuthMiddleWare()];

final routes = [
  GetPage(name: '/', page: () => const HomePage()),
  GetPage(name: '/login', page: () => const PhoneLogin()),
  GetPage(name: '/user_agreement', page: () => const UserAgreement()),
  GetPage(name: '/user_policy', page: () => const PrivatePolicy()),
  GetPage(name: '/about_us', page: () => const AboutUs()),
  // GetPage(name: '/setting', page: () => SettingPage()),
  GetPage(name: '/uc', page: () => UserCenterPage(), middlewares: middlewares),
  GetPage(
      name: '/uc/info', page: () => UserInfoPage(), middlewares: middlewares),

  GetPage(
      name: '/detail', page: () => DetailPage()),
 ];
