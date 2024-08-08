import 'package:get/get.dart';

extension StringUtils on String {
  bool get isChinaPhoneNumber {
    if (length != 11) return false;
    return hasMatch(this,
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
  }

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }


}
