import 'package:flutter/material.dart';
import 'package:flutter_template/pages/form.dart';
import 'package:flutter_template/pages/listview.dart';
import 'package:flutter_template/pages/table.dart';
import 'package:flutter_template/pages/usercenter/usercenter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../components/layout/app_bar.dart';
import '../confi.dart';
import '../controller/userinfo_ctl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  // 当前子项索引
  int currentIndex = 0;
  String barTitle = '表格示例';

  Widget body = TableDemoPage();

  late UserInfoController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    var leading = Builder(builder: (BuildContext context) {
      return IconButton(
        icon: Icon(
          Icons.person,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    });
    //Scaffold是一个内置布局组件
    return Scaffold(
        //顶部bar
        appBar: createAppbar(barTitle, leading: leading),
        //左边抽屉
        drawer: createDrawer(),
        //页面主体
        body: body,
        //底部导航条
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          // 当前页面索引，与items一一对应
          currentIndex: currentIndex,
          // 导航子项集
          items: const [
            // 导航子项
            BottomNavigationBarItem(
              // 图标
              icon: Icon(Icons.show_chart),
              // 文字内容
              label: '表格示例',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dataset_rounded),
              label: 'ListView示例',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_mode_rounded),
              label: '表单示例',
            )
          ],
          //底部导航条切换变更事件
          onTap: onTabChanged,
        ));
  }

  /// Tab 改变，根据索引变换body
  void onTabChanged(int value) {
    currentIndex = value;
    if (currentIndex == 0) {
      body = TableDemoPage();
      barTitle = '表格示例';
    } else if (currentIndex == 1) {
      barTitle = 'ListView示例';
      body = ListViewDemo();
    } else if (currentIndex == 2) {
      barTitle = '表单示例';
      body = FormDemo();
    }
    //调用setState()重新渲染界面
    setState(() {});
  }

  String getPageTitle(int currentIndex) {
    if (currentIndex == 0) {
      return '表格示例';
    } else if (currentIndex == 1) {
      return 'ListView示例';
    } else if (currentIndex == 2) {
      return '表单示例';
    }
    return currentIndex.toString();
  }

  Drawer createDrawer() {
    return Drawer(
      width: 300,
      child: SafeArea(
        child: Container(color: cardColor, child: UserCenterPage()),
      ),
    );
  }
}
