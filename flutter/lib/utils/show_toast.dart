import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToastForAllPlatform(BuildContext context, String msg, {int duration = 2}) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.white38,
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.info, size: 20, color: Theme.of(context).primaryColor),
        Text(msg,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.bold),)
      ]));

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: duration),
  );
}

showToastForMobile(String msg,
    {int duration = 3, ToastGravity gravity = ToastGravity.CENTER}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity,
    timeInSecForIosWeb: duration,
  );
}
