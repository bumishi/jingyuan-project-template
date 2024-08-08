import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_template/pages/crop_image.dart';
import 'package:flutter_template/utils/show_toast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/userinfo_ctl.dart';
import '../service/http_service.dart';

class UploadImgWidget extends StatefulWidget {
  Image image;
  String apiPath;

  UploadImgWidget(this.image, this.apiPath);

  @override
  State<UploadImgWidget> createState() => _UploadImgWidgetState();
}

class _UploadImgWidgetState extends State<UploadImgWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: ClipOval(child: widget.image),
        onTap: () async => await getLostData());
  }

  Future<void> getLostData() async {
    final ImagePicker picker = ImagePicker();

    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    CropImage cropImage = CropImage(await file.readAsBytes(), upload);
    Navigator.push(context, MaterialPageRoute(builder: (context) => cropImage));
  }

  void upload(Uint8List file) async {
    Map<String, dynamic>? rs =
        await Get.find<HttpService>().uploadFile(widget.apiPath, file);
    Get.find<UserInfoController>().refreshUserInfo();
    Get.back();
  }
}
