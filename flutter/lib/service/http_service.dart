import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template/confi.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;

import '../repository/token_storage.dart';
import '../utils/platform.dart';
import '../utils/show_toast.dart';
import 'package:http_parser/http_parser.dart';

class _ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map<String, dynamic>? res = response.data;
    //aaa?? "ccc"表示如果aaa为null则返回ccc,aaa不为null则返回aaa的值
    int code = res?['code'] ?? -1;
    if (code == 401) {
      showToastForAllPlatform(Get.context!, "请登录", duration: 1);
      Get.toNamed("/login");
    } else if (code != 200) {
      showToastForAllPlatform(
          Get.context!, "${res?['message'] ?? '服务繁忙，请稍后再试'}");
      //showToastForMobile("${res?['msg'] ?? '服务繁忙，请稍后再试'}");
    } else {
      //?标识如果res为null则表达式结果是null
      if(res?['has_next']==null) {
        response.data = res?['data'];
      }
      //response.data = res?['data'];
      super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    EasyLoading.dismiss();
    print("dio http on error:$err");
    if (err.response?.statusCode == 401) {
      showToastForAllPlatform(Get.context!, "请登录", duration: 1);
      Get.toNamed("/login");
    } else if (err.response?.statusCode == 403) {
      showToastForAllPlatform(Get.context!, "您无此访问权限", duration: 1);
    } else {
      showToastForAllPlatform(Get.context!, "网络异常，请稍后再试");
    }
  }
}

class HttpService extends GetxService {
  late Dio _dio;

  Future<HttpService> init({
    required String baseUrl,
  }) async {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = {'Accept': 'application/json', 'Platform':getRunInPlatName()};
    _dio.options.connectTimeout = const Duration(milliseconds: 2000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 10000);
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors.add(_ResponseInterceptor());
    return this;
  }

  Map<String,dynamic> createHeader(String?token){
   
    var map= {'Authorization':'Bearer ${token??''}'};
    return map;
  }

  Future get(String path,
      {Map<String, dynamic>? queryParameters,
        Object? data,
        ProgressCallback? onReceiveProgress}) async {
    var token = getToken();
    final response = await _dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: createHeader(token)),
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }

  Future post(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,String? contentType}) async {
    var token = getToken();
    var headers= {
      'Authorization': 'Bearer ${token}',
    };
    if(contentType==null){
      headers['content-type']='application/json';
    }else{
      headers['content-type']=contentType;
    }

    final response = await _dio.post(
      path,
      data: data ?? {},
      queryParameters: queryParameters,
      options: Options(headers:headers),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }

  Future<Map<String, dynamic>?> uploadFile(String path, Uint8List bytes,
      {Map<String, dynamic>? queryParameters,
        String paramsName = "file",
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress}) async {
    var token = getToken();

    //后台的参数明对应的是filename
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(bytes,
          filename: paramsName, contentType: MediaType.parse("image/png"))
    });

    final response = await _dio.post<Map<String, dynamic>?>(
      path,
      data: formData,
      queryParameters: queryParameters,
      options: Options(headers:createHeader(token)),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }

  static HttpService getHttp() {
    return Get.find<HttpService>();
  }

}




