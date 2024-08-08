import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/repository/token_storage.dart';
import 'package:flutter_template/repository/userinfo_storage.dart';
import 'package:flutter_template/utils/string_extensions.dart';
import 'package:get/get.dart';

import '../../service/http_service.dart';
import '../../utils/show_toast.dart';
import '../confi.dart';
import '../controller/sms_code_ctl.dart';

class SmsCode extends StatefulWidget {
  String event;

  SmsCode(this.event);

  @override
  _SmsCodeState createState() => _SmsCodeState();
}

class _SmsCodeState extends State<SmsCode> {
  static const double height = 60;
  SmsCodeController controller = Get.find();

  /// 开始倒计时 时间
  Timer? _timer;

  /// 当前倒计时 时间
  int countDownTime = 0;

  /// 总倒计时时长
  final int speed = 90;

  @override
  void dispose() {
    ///取消计时器
    _timer?.cancel();
    super.dispose();
  }

  void processGetCode() async {
    String? error = validatePhone(controller.mobile.value);
    if (error != null) {
      showToastForAllPlatform(context, error);
      return;
    }
    controller.validate.value = true;
    var params = {'telephone': controller.mobile.value, 'event': widget.event};
    var data = await Get.find<HttpService>()
        .post("/system/sms/send", queryParameters: params);
    //拿到的data一定是成功状态的data,错误或者不是code=0的都在拦截器中处理了不会返回这里
    //print("sms_code data...${data}");
    if (countDownTime == 0) {
      setState(() {
        countDownTime = speed;
      });

      ///循环执行
      ///间隔1秒
      _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        setState(() {
          countDownTime--;
          if (countDownTime == 0) {
            _timer?.cancel();
          }
        });

        ///定时任务
      });
    }
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// 输入手机号
        Container(
          //color: cardColor,
          height: height,
          child: TextFormField(
            initialValue: controller.mobile.value,
            maxLength: 11,
            onChanged: (v) {
              controller.updateMobile(v);
            },
            keyboardType: TextInputType.phone,
            decoration:  InputDecoration(
                prefixIcon: Icon(Icons.phone_android_rounded,color: Theme.of(context).primaryColor,),
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
        const SizedBox(height: 20,),
        /// 验证码
        Container(
          //color: cardColor,
          height: height,
          child: buildRowByLoginType(),
        ),
      ],
    );
  }

  Widget buildRowByLoginType() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: TextFormField(
            enabled: controller.validate.value,
            onChanged: (v) {
              controller.updateCode(v);
            },
            maxLength: 6,
            keyboardType: TextInputType.number,
            decoration:  InputDecoration(
                prefixIcon: Icon(Icons.sms,color: Theme.of(context).primaryColor,),
                border: InputBorder.none,
                hintText: '请输入短信验证码',
                hintStyle: const TextStyle(
                  fontSize: 12,
                )),
            validator: (value) {
              if (value == null || value.trim() == '') {
                return '请输入短信验证码';
              }
              if (value.length != 6) {
                return '请输入6位长度的手机验证码';
              }
            },
          ),
        ),
        buildGetSmsCode()
      ],
    );
  }

  /// 获取验证码
  Widget buildGetSmsCode() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: 35,
      child: countDownTime == 0
          ? Obx(() => TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: controller.mobile.value != ""
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
              onPressed: () {
                processGetCode();
              },
              child:const Text(
                '获取验证码',
                style: TextStyle(
                    color:Colors.white,fontSize: 12
              ))))
          : Column(
              children: [
                Expanded(
                    child:

                        ///层叠布局将进度与文字叠在一起
                        Stack(
                  ///子Widget居中
                  alignment: Alignment.center,
                  children: [
                    ///圆形进度
                    CircularProgressIndicator(
                      ///当前指示的进度 0.0 -1.0
                      value: countDownTime / speed,
                    ),

                    ///显示的文本
                    Text("${countDownTime}"),
                  ],
                ))
              ],
            ),
    );
  }
}
