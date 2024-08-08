import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../confi.dart';
import '../../../controller/userinfo_ctl.dart';
import '../../../service/http_service.dart';

class EditPwdPage extends StatelessWidget {
  final UserInfoController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  final TextEditingController _text2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: toolbarHeight,
          title: const Text('修改密码'),
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

          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  color: cardColor,
                  height: 60,
                  child: TextFormField(
                    controller: _textController,

                    maxLength: 30,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: UnderlineInputBorder(),
                        hintText: '输入密码',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        )),
                    validator: (value) {
                      if (value == null || value.trim() == '') {
                        return '请输入密码';
                      }
                      if (value.length > 30) {
                        return '密码长度不能超过30';
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: cardColor,
                  height: 60,
                  child: TextFormField(
                    controller: _text2Controller,

                    maxLength: 30,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: UnderlineInputBorder(),
                        hintText: '确认密码',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        )),
                    validator: (value) {
                      if (value == null || value.trim() == '') {
                        return '请输入确认密码';
                      }
                      if (value != _textController.text) {
                        return '两次密码不一致';
                      }
                      if (value.length > 30) {
                        return '确认密码长度不能超过30';
                      }
                    },
                  ),
                ),
              ])),
        ));
  }

  void doSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Map<String, dynamic>? rs = await Get.find<HttpService>()
        .post('/usercenter/reset/password', data: {
      'password': _textController.text,
      'password_two': _text2Controller.text
    });
    //print(rs);
    Get.back();
  }
}
