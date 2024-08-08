import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_template/components/show_setting_html.dart';
import 'package:flutter_template/service/http_service.dart';
import 'package:get/get.dart';

class PrivatePolicy extends StatelessWidget {
  const PrivatePolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingValueHtml(settingName: 'privacy', title: '隐私政策');
  }
}
