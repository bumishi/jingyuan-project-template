import 'package:flutter/cupertino.dart';
import 'package:flutter_template/components/upload_img.dart';

class Avatar extends StatelessWidget {
  final String uploadApi = '/usercenter/update/avatar';
  String? path;
  double? width=60;
  double? height=60;

  Avatar(this.path,{this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return (path ?? '') == ''
        ? UploadImgWidget(
            Image.asset('assets/images/uc/default_avatar.png',
                width: width??60, height: height??60, fit: BoxFit.cover),
            uploadApi)
        : UploadImgWidget(
            Image.network('http://cos.bumishi.cn/${path}',
                width: width??60, height: height??60, fit: BoxFit.cover),
            uploadApi);
  }
}
