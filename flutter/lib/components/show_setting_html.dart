import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_template/service/http_service.dart';
import 'package:get/get.dart';

class SettingValueHtml extends StatelessWidget {
   SettingValueHtml({super.key, required this.settingName,required this.title});
  String settingName;
  String title;

  Future<String> getData() async {
    var res = await Get.find<HttpService>().get("/system/settings/$settingName");
    // print("getdata..");
    // print(res);
    String data = res ?? '';

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:  Text(title)),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 200,child:
            TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text("确认"))),
          ],
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: Get.width,
            child: FutureBuilder<String>(
                future: getData(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // 当Future还未完成时，显示加载中的UI
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // 当Future发生错误时，显示错误提示的UI
                    return const Text('发生错误，请稍后重试');
                  } else {
                    // 当Future成功完成时，显示数据
                    return Html(
                      data: snapshot.data,
                      style: {'p': Style(wordSpacing: 10)},
                    );
                  }
                }),
          ),
        )));
  }
}
