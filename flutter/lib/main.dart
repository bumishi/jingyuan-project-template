import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/confi.dart';
import 'package:flutter_template/controller/sms_code_ctl.dart';
import 'package:flutter_template/controller/userinfo_ctl.dart';

import 'package:flutter_template/routes.dart';
import 'package:flutter_template/service/http_service.dart';
import 'package:flutter_template/utils/platform.dart';
import 'package:flutter_template/utils/show_toast.dart';
import 'package:flutter_template/utils/windows.dart'
    if (dart.library.html) 'package:flutter_template/utils/web.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



void main() async {
  if (!kDebugMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  } else {
    // debugPaintSizeEnabled=true;
  }

  //flutter框架的错误转发到dart层面的zone
  if (!kDebugMode) {
    FlutterError.onError = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(
          details.exception, details.stack ?? StackTrace.empty);
    };
  }
  //dart层面的zone统一处理所有错误
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    //设置桌面版窗口的最小宽高
    if (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      await WindowUtil.init(
          width: 800, height: 800, minWidth: 400, minHeight: 400);
    }
    await GetStorage.init();
    await initServices();
    initControllers();
    runApp(const MyApp());
  }, (error, stack) {
    if (kDebugMode) {
      print("catch error$error");
      print(stack);
    }
    showToastForAllPlatform(Get.context!, "发生不明错误:${error.toString()}");
  });
}

initServices() async {
  await Get.putAsync<HttpService>(
      () async => await HttpService().init(baseUrl: config['api_base_url']!));
}

initControllers() {
  Get.put(UserInfoController());
  Get.put(SmsCodeController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print('build app');
    return GetMaterialApp(
      title: '静远理财',
      initialRoute: '/',
      getPages: routes,
      theme: FlexThemeData.light(
        scheme: FlexScheme.amber,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          appBarBackgroundSchemeColor: SchemeColor.surface,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        //textTheme: TextTheme(labelSmall: TextStyle(fontSize: 12),labelMedium: TextStyle(fontSize: 12),labelLarge: TextStyle(fontSize: 14))
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.amber,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      themeMode: ThemeMode.light,
      locale: const Locale('zh'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh')],
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    );
  }
}
