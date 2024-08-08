
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowUtil {
  static  init({required double width, required double height,required double minWidth,required double minHeight}) async {
    // 必须加上这一行。
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: Size(width, height),
      minimumSize: Size(minWidth, minHeight),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: '静远理财'
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
