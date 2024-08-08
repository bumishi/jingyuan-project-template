// 保存到相册的UTil
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_template/utils/platform.dart';
import 'package:flutter_template/utils/show_toast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveToAlbumUtil {
  static Future<dynamic> saveLocalImage(Uint8List imageBytes) async {
    if (isMobile()) {
      /// 权限检测
      PermissionStatus storageStatus = await Permission.storage.status;
      if (storageStatus != PermissionStatus.granted) {
        storageStatus = await Permission.storage.request();
        if (storageStatus != PermissionStatus.granted) {
          showToastForAllPlatform(Get.context!, '无法存储图片，请先授权！');
          return;
        }
      }
      final result = await ImageGallerySaver.saveImage(imageBytes);
      //print("SaveToAlbumUtil result:${result}");
      showToastForAllPlatform(Get.context!, '图片已保存到相册');
      return result;
    } else {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      File('${appDocumentsDir.path}/${DateTime.now().microsecondsSinceEpoch}.jpeg')
          .writeAsBytesSync(imageBytes);
      showToastForAllPlatform(Get.context!, '图片已保存到文档');
    }
  }

  static void saveNetworkImage(String imageUrl) async {
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: DateTime.now().microsecondsSinceEpoch.toString());
  }
}
