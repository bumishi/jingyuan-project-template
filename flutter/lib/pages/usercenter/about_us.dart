import 'package:flutter/material.dart';
import 'package:flutter_template/components/show_setting_html.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingValueHtml(settingName: 'about', title: '关于');
  }
}
