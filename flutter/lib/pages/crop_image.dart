import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

import '../components/layout/app_bar.dart';

class CropImage extends StatefulWidget {
  Uint8List imageByte;
  void Function(Uint8List cropImage) callback;

  CropImage(this.imageByte, this.callback);

  @override
  State<StatefulWidget> createState() {
    return CropImageState();
  }
}

class CropImageState extends State<CropImage> {
  final _controller = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppbar('图片裁剪'),
        body: Column(children: [
          Expanded(
              //Crop是裁剪控件
              child: Crop(

            image: widget.imageByte,
            controller: _controller,
            onCropped: (image) {
              //裁剪完成的回调
              widget.callback(image);
            },
            initialArea: const Rect.fromLTWH(200, 200, 300, 300),
            //固定的裁剪矩形的长宽比
            //aspectRatio: 1,
            initialSize:1,
            fixCropRect: true,
            interactive: true,
            withCircleUi: true,
            baseColor: Colors.black,
            maskColor: Colors.black.withAlpha(150),
            cornerDotBuilder: (size, edgeAlignment) =>
                const DotControl(color: Colors.white54),
          )),
          Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextButton(
                  onPressed: () => _controller.crop(), child: const Text('确认')))
        ]));
  }
}
