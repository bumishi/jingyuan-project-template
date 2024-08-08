import 'package:flutter/material.dart';
import 'package:flutter_template/pages/usercenter/feedback.dart';
import 'package:flutter_template/utils/platform.dart';
import 'package:get/get.dart';

import '../../components/show_avatar.dart';
import '../../confi.dart';
import '../../controller/userinfo_ctl.dart';
import '../../utils/utils.dart';


class UserCenterPage extends StatelessWidget {
  UserCenterPage({super.key});

  final UserInfoController controller = Get.find();

  void logout() {
    Get.defaultDialog(
        onConfirm: () => controller.logout(),
        title: "提示",
        middleText: '是否确认退出?',
        textConfirm: "确定",
        textCancel: "取消");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<ListTile> lists = [
        ListTile(
            enableFeedback: true,
            contentPadding:
                const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
            dense: true,
            leading: const Icon(Icons.contact_page),
            title: const Text('用户协议', style: TextStyle(fontSize: 14)),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, '/user_agreement')),
        ListTile(
            enableFeedback: true,
            contentPadding:
                const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
            dense: true,
            leading: const Icon(Icons.policy),
            title: const Text('隐私政策', style: TextStyle(fontSize: 14)),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, '/user_policy')),
        ListTile(
            enableFeedback: true,
            contentPadding:
                const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
            dense: true,
            leading: const Icon(Icons.contact_page),
            title: const Text('关于', style: TextStyle(fontSize: 14)),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, '/about_us')),
        ListTile(
            enableFeedback: true,
            contentPadding:
                const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
            dense: true,
            leading: const Icon(Icons.group),
            title: const Text('交流反馈', style: TextStyle(fontSize: 14)),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => Get.to(() => const FeedBackPage())),
      ];

      lists.insert(
          0,
          ListTile(
              enableFeedback: true,
              contentPadding:
                  const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
              dense: true,
              leading: const Icon(Icons.book),
              title: const Text('投资知识', style: TextStyle(fontSize: 14)),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                  openUrl(
                      'http://bumishi.cn/touzitixi/01%E6%8A%95%E8%B5%84%E7%9A%84%E5%BF%85%E8%A6%81.html');
              }));
      lists.add(ListTile(
          enableFeedback: true,
          contentPadding:
              const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
          dense: true,
          leading: const Icon(Icons.featured_play_list),
          title: const Text('功能介绍', style: TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {

              openUrl("http://bumishi.cn/zcpzzs.html");

          }));

      if (controller.isLogin()) {
        if (controller.userInfo.value.isStaff == true &&
            controller.userInfo.value.id == 1) {
          lists.add(ListTile(
              enableFeedback: true,
              contentPadding:
                  const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
              dense: true,
              leading: const Icon(Icons.dashboard, color: Colors.green),
              title: const Text('管理面板',
                  style: TextStyle(fontSize: 14, color: Colors.red)),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => Get.toNamed('/uc/manage_console')));
        }
        lists.add(ListTile(
            enableFeedback: true,
            contentPadding:
                const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
            dense: true,
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('退出登录',
                style: TextStyle(fontSize: 14, color: Colors.red)),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => logout()));
      }
      return Column(children: [
        controller.isLogin()
            ? topInfo(context)
            : Container(
                color: cardColor,
                child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        left: 15, right: 10, top: 5, bottom: 5),
                    dense: true,
                    leading: const Icon(Icons.login),
                    title: const Text('去登录', style: TextStyle(fontSize: 14)),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () => Get.toNamed("/login"))),
        const SizedBox(
          height: 5,
        ),
        Expanded(
            child: ListView(
                children: ListTile.divideTiles(context: context, tiles: lists)
                    .toList()))
      ]);
    });
  }

  /*顶部信息：头像+昵称+编辑资料*/
  GestureDetector topInfo(BuildContext context) {
    return GestureDetector(
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Avatar(controller.userInfo.value.avatar ?? ''),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 10, 0),
                          child: SizedBox(
                              width: 150,
                              child: Text(
                                  controller.userInfo.value.nickname ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))))
                    ]),
                    const Icon(Icons.chevron_right)
                  ],
                ))),
        onTap: () => Get.toNamed("/uc/info"));
  }
}
