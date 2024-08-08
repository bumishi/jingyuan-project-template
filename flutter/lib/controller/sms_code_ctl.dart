import 'package:get/get.dart';

class SmsCodeController extends GetxController {
  var mobile = ''.obs;
  var code=''.obs;
  var validate=false.obs;

  void updateMobile(String newMobile){
    mobile.value=newMobile;
  }

  void updateCode(String newCode){
    code.value=newCode;
  }
}
