import 'package:flutter/cupertino.dart';
import 'package:flutter_template/repository/token_storage.dart';
import 'package:flutter_template/repository/userinfo_storage.dart';
import 'package:get/get.dart';

import '../confi.dart';
import '../service/http_service.dart';

class UserInfoController extends GetxController {
  var userInfo = UserInfo.empty().obs;

  @override
  void onInit() {
    //print("usercontroller init");
    super.onInit();
    userInfo.value = getUserInfo();
    refreshToken();
  }

  void refreshUserInfo() async {
    var newUserInfo = await Get.find<HttpService>().get("/usercenter/profile");
    //storage更新
    setUserInfo(newUserInfo);
    userInfo.value = getUserInfo();
  }

  void logout() {
    clean();
    userInfo.value = UserInfo.empty();
    Navigator.of(Get.context!)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  bool isLogin() {
    return (userInfo.value).id > 0;
  }

  refreshToken() async {
    if (isLogin()) {
      DateTime? lastRefreshTime = getLastRefreshTokenTime();
      if (lastRefreshTime == null ||
          DateTime.now().difference(lastRefreshTime).inDays > 1) {
        String refreshToken = getRefreshToken();
        if (refreshToken != null && refreshToken.isNotEmpty) {
          var res = await Get.find<HttpService>().post("/auth/token/refresh",
              data: refreshToken, contentType: 'text/plain');
          setTokenInfo(res);
          setLastRefreshTokenTime(inputFormat.format(DateTime.now()));
        }
      }
    }
  }
}
