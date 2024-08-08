import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../confi.dart';
import '../../../controller/userinfo_ctl.dart';
import '../../../service/http_service.dart';

class EditNickNamePage extends StatelessWidget {
  final UserInfoController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  EditNickNamePage() {
    String textStr = controller.userInfo.value.nickname ?? '';
    _textController.value = TextEditingValue(
        text: textStr,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: textStr.length)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: toolbarHeight,
          title: const Text('修改昵称'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  doSave();
                },
                child: const Text('保存'))
          ],
        ),
        body: Container(
          color: cardColor,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: 60,
              child: TextFormField(
                controller: _textController,
                maxLength: 20,
                decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.person,color: Theme.of(context).primaryColor,),
                    border: const UnderlineInputBorder(),
                    hintText: '请输入昵称',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                    )),
                validator: (value) {
                  if (value == null || value.trim() == '') {
                    return '请输入昵称';
                  }
                  if (value.length > 20) {
                    return '昵称长度不能超过20';
                  }
                },
              ),
            ),
          ),
        ));
  }

  void doSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Map<String, dynamic>? rs = await Get.find<HttpService>().post(
        '/usercenter/update/info',
        data: {'nickname': _textController.text});
    //print(rs);
    controller.refreshUserInfo();
    Get.back();
  }
}
