import 'package:flutter/material.dart';
import 'package:flutter_template/components/layout/app_bar.dart';
import 'package:flutter_template/pages/usercenter/edit/edit_mobile.dart';
import 'package:flutter_template/pages/usercenter/edit/edit_pwd.dart';
import 'package:get/get.dart';

import '../../components/show_avatar.dart';
import '../../confi.dart';
import '../../controller/userinfo_ctl.dart';
import 'edit/edit_nickname.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({super.key});

  final UserInfoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppbar("个人资料"),
      body: Obx(() => Column(children: [
            const SizedBox(height: 15),
            Avatar(
              controller.userInfo.value.avatar ?? '',
              width: 100,
              height: 100,
            ),
            Expanded(
                child: ListView(
                    children: ListTile.divideTiles(tiles: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 20, right: 10),
                dense: true,
                leading: const Text('昵称', style: TextStyle(fontSize: 16)),
                title: Text(controller.userInfo.value.nickname ?? '',
                    style: const TextStyle(fontSize: 16)),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => Get.to(() => EditNickNamePage()),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 20, right: 10),
                dense: true,
                leading: const Text('修改密码', style: TextStyle(fontSize: 16)),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => Get.to(() => EditPwdPage()),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 20, right: 10),
                dense: true,
                leading: const Text('手机号码', style: TextStyle(fontSize: 16)),
                title: Text(controller.userInfo.value.telephone ?? '',
                    style: const TextStyle(fontSize: 16)),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => Get.to(() => EditMobilePage()),
              ),
            ], context: context)
                        .toList()))
          ])),
    );
  }
}
