import 'package:flutter_template/repository/token_storage.dart';
import 'package:get_storage/get_storage.dart';

class UserInfo {
  int id = 0;
  String telephone = '';
  String? nickname = '';
  String? avatar = '';
  bool? isActive = true;

  bool? isStaff=false;

  UserInfo.empty() {
    UserInfo(0, '');
  }

  UserInfo(this.id, this.telephone,
      {this.nickname, this.avatar, this.isActive,this.isStaff});
}

GetStorage box = GetStorage();

UserInfo getUserInfo() {

  Map<String, dynamic>? data = box.read('user_info');
  if (data == null) {
    return UserInfo.empty();
  }
  return UserInfo(data['id'], data['telephone'],
      nickname: data['nickname'] ?? data['telephone'],
      avatar: data['avatar']??'',
      isActive: data['is_active'],isStaff: data['is_staff']);
}

void setUserInfo(Map<String, dynamic>? userInfo) {
  if (userInfo != null) {
    box.write("user_info", userInfo);
  }
}

void clean(){
  box.remove('user_info');
  cleanToken();

}

bool isLogin() {
  return getUserInfo().id >0;
}
