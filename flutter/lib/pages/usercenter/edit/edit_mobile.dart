import 'package:flutter/material.dart';
import 'package:flutter_template/components/sms_code.dart';
import 'package:flutter_template/controller/sms_code_ctl.dart';
import 'package:flutter_template/utils/show_toast.dart';
import 'package:flutter_template/utils/string_extensions.dart';
import 'package:get/get.dart';

import '../../../confi.dart';
import '../../../controller/userinfo_ctl.dart';
import '../../../service/http_service.dart';

class EditMobilePage extends StatelessWidget {
  SmsCodeController controller = Get.find();

  EditMobilePage() {
    controller
        .updateMobile(Get.find<UserInfoController>().userInfo.value.telephone);
    controller.validate.value = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('修改手机号'),
          centerTitle: true,
          toolbarHeight: toolbarHeight,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Obx(() => enableClick()
                    ? TextButton(
                        onPressed: () {
                          doSave();
                        },
                        child: const Text('保存'))
                    : const Text(
                        '保存',
                        style: TextStyle(color: Colors.grey),
                      )))
          ],
        ),
        body: Container(
            color: cardColor,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: SmsCode('changeMobile')));
  }

  void doSave() async {
    if (!controller.validate.value) {
      showToastForAllPlatform(Get.context!, '请先获取验证码');
      return;
    }
    if (controller.code.value == '') {
      showToastForAllPlatform(Get.context!, '请输入验证码');
      return;
    }
    Map<String, dynamic>? rs = await Get.find<HttpService>()
        .post('/usercenter/update/mobile', data: {
      'mobile': controller.mobile.value,
      'code': controller.code.value
    });
    //print(rs);
    Get.find<UserInfoController>().refreshUserInfo();
    Get.back();
  }

  bool enableClick() {
    return controller.validate.value && controller.code.value != '';
  }
}
