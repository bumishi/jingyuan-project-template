import 'package:flutter_template/utils/show_toast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

double getDoubleFrom(e) {
  e ??= 0;
  if (e is double) {
    return e;
  }
  return double.parse(e.toString());
}


Future openUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    showToastForAllPlatform(Get.context!, '不支持打开此链接');
  }
}

inTradeTime() {
  var now = DateTime.now();
  return now.day != 0 &&
      now.day != 6 &&
      ((now.hour >= 9 && now.hour < 16) || now.hour >= 21 || now.hour < 6);
}