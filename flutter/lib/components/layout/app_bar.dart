import 'package:flutter/material.dart';

import '../../confi.dart';

AppBar createAppbar(String title,{List<Widget>? actions,Widget? leading}) {
  return AppBar(
    toolbarHeight: toolbarHeight,
    title: Text(title),
    centerTitle: true,
    actions:actions,
    leading: leading,
  );
}
