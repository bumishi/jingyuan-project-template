import 'package:flutter/material.dart';
import 'package:flutter_template/service/http_service.dart';
import 'package:get/get.dart';

import '../../components/show_setting_html.dart';

class UserAgreement extends StatelessWidget {
  const UserAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingValueHtml(settingName: 'agreement', title: '用户协议');
  }
}
