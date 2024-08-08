import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_template/components/markdown.dart';
import 'package:flutter_template/service/http_service.dart';
import 'package:get/get.dart';

import '../../confi.dart';

class ShowHtmlContent extends StatelessWidget {
  ShowHtmlContent({super.key, required this.title, required this.html,this.markdown});

  String title;
  String html;
  bool? markdown=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () => Get.back(), child: const Text("返回"))
          ],
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(20),
              width: Get.width,
              child: (markdown??false)?Markdown(text: html):Html(
                data: html,
                style: {'p': Style(wordSpacing: 10)},
              )),
        )));
  }
}
