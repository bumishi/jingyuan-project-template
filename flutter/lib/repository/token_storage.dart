import 'package:flutter_template/confi.dart';
import 'package:get_storage/get_storage.dart';

GetStorage box = GetStorage();

String getToken() {
  Map<String, dynamic>? data = box.read('login');
  if (data == null) {
    return "";
  }
  return data['access_token']??'';
}

String getRefreshToken() {
  Map<String, dynamic>? data = box.read('login');
  if (data == null) {
    return "";
  }
  return data['refresh_token']??'';
}

void setTokenInfo(Map<String, dynamic>? loginData) {
  if (loginData != null) {
    box.write("login", loginData);
  }
}

void setLastRefreshTokenTime(String time) {
  if (time != null) {
    box.write("last_refresh_token_time", time);
  }
}

DateTime? getLastRefreshTokenTime(){
  String? time= box.read('last_refresh_token_time');
  if(time==null){
    return null;
  }
  return inputFormat.parse(time);
}

void cleanToken(){
  box.remove('login');
  box.remove('last_refresh_token_time');
}


