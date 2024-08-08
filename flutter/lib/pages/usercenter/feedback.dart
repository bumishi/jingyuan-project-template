import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/components/layout/app_bar.dart';
import 'package:flutter_template/utils/save_image.dart';

class FeedBackPage extends StatelessWidget {
  const FeedBackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppbar('交流与反馈'),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
              child: ListView(children: [
            Column(children: [
              const Text(
                '欢迎加入交流群',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '与一群志同道合的人一起',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '一个人或许走的快，一群人才能走的远',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '欢迎您的意见与建议',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  child: Image.asset('assets/images/feedback.png'),
                  onLongPress: () async {
                    ByteData bytes =
                        await rootBundle.load('assets/images/feedback.png');
                    var imageBytes = bytes.buffer.asUint8List();
                    SaveToAlbumUtil.saveLocalImage(imageBytes);
                  })
            ])
          ]))),
    );
  }
}
