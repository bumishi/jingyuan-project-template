import 'package:flutter/foundation.dart';

String getTargetPlatTalkingDataChannelStr(){
  if(kIsWeb){
    return "web";
  }
  if(defaultTargetPlatform==TargetPlatform.iOS){
    return "App Store";
  }
  return defaultTargetPlatform.name;
}

String getRunInPlatName(){
  if(kIsWeb){
    return "web";
  }
  return defaultTargetPlatform.name;
}

bool isMobile(){
  return defaultTargetPlatform==TargetPlatform.iOS||defaultTargetPlatform==TargetPlatform.android;
}
