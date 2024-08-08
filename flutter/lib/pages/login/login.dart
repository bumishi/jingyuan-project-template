import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/components/layout/app_bar.dart';
import 'package:flutter_template/components/sms_code.dart';
import 'package:flutter_template/repository/token_storage.dart';
import 'package:flutter_template/utils/platform.dart';
import 'package:flutter_template/utils/string_extensions.dart';
import 'package:get/get.dart';

import '../../confi.dart';
import '../../controller/sms_code_ctl.dart';
import '../../controller/userinfo_ctl.dart';
import '../../service/http_service.dart';
import '../../utils/show_toast.dart';

class PhoneLogin extends StatefulWidget {
   const PhoneLogin({super.key});

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  static const double height = 60;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();

  final SmsCodeController controller = Get.find();

  ///是否勾选同意用户协议
  bool checkedAgree = false;

  String loginType = "smsCode";

  bool hidePwd = true;

  @override
  void dispose() {
    _creditController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void doLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!checkedAgree) {
      showToastForAllPlatform(Get.context!, "请阅读并同意用户协议与隐私政策", duration: 1);
      return;
    }

    var params = loginType == 'password'
        ? {
            'mobile': _phoneController.text,
            'method': '0',
            'password': _creditController.text
          }
        : {
            'mobile': controller.mobile.value,
            'code': controller.code.value,
            'method': '1'
          };
    params['platform'] = getRunInPlatName();
    //验证码登录的话不存在账号则自动注册，密码登录的话必须账号存在
    var data = await Get.find<HttpService>().post(
        loginType == 'password' ? "/auth/login" : '/auth/login_by_mobile',
        data: params);
    // print('login data:${data}');
    setTokenInfo(data);
    Get.find<UserInfoController>().refreshUserInfo();
    if (loginType == 'password') {
      TextInput.finishAutofillContext();
    }
    Get.back();
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim() == '') {
      return '请输入手机号';
    }
    if (!value.isChinaPhoneNumber) {
      return '请输入正确的手机号码';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: createAppbar("登录"),
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: cardColor,
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 128,
                  child: Center(
                      child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  )),
                ),
                const SizedBox(
                  height: 50,
                ),

                ///输入信息
                buildRowByLoginType(),

                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 0.5,
                ),

                /// 协议
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                          width: 25,
                          child: Checkbox(
                            onChanged: (bool? value) {
                              setState(() {
                                checkedAgree = value ?? false;
                              });
                            },
                            value: checkedAgree,
                          )),
                      const Text('我已阅读并同意'),
                      const SizedBox(width: 5),
                      InkWell(
                        child: const Text(
                          '《用户协议》',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        onTap: () =>
                            Navigator.pushNamed(context, '/user_agreement')
                                .then((value) {
                          if (value != null) {
                            setState(() {
                              checkedAgree = true;
                            });
                          }
                        }),
                      ),
                      const Text('与'),
                      InkWell(
                        child: const Text(
                          '《隐私政策》',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        onTap: () =>
                            Navigator.pushNamed(context, '/user_policy')
                                .then((value) {
                          if (value != null) {
                            setState(() {
                              checkedAgree = true;
                            });
                          }
                        }),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                /// 确认
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('确定'),
                      onPressed: () {
                        doLogin();
                      },
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            loginType = (loginType == 'smsCode')
                                ? 'password'
                                : 'smsCode';
                          });
                        },
                        child: Text(
                            loginType == 'smsCode' ? '使用密码登录' : '使用手机验证码登录',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.lightBlue)))
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget buildRowByLoginType() {
    if (loginType == "smsCode") {
      return SmsCode('loginOrReg');
    }

    if (loginType == "password") {
      return AutofillGroup(
          child: Column(
        children: [
          SizedBox(
            // color: cardColor,
            height: height,
            child: TextFormField(

              autofillHints: [AutofillHints.username],
              maxLength: 11,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_android_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: '请输入手机号',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                  )),
              validator: (value) {
                return validatePhone(value);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          /// 凭证
          SizedBox(
            //color: cardColor,
            height: height,
            child: TextFormField(
              // onTap: () {
              //   TextInput.finishAutofillContext(shouldSave: false);
              // },
              autofillHints: [AutofillHints.password],
              obscureText: hidePwd,
              maxLength: 30,
              controller: _creditController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.password,
                    color: Theme.of(context).primaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: '请输入密码',
                  hintStyle: const TextStyle(
                    fontSize: 11,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.remove_red_eye, size: 15),
                    onPressed: () {
                      setState(() {
                        hidePwd = !hidePwd;
                      });
                    },
                  )),
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return '请输入账号密码';
                }
              },
            ),
          ),
        ],
      ));
    }
    return Text("不支持的登录方式");
  }
}
