import 'package:flutter/material.dart';

import 'package:flutter_template/utils/string_extensions.dart';
import 'package:get/get.dart';
import '../../confi.dart';

import '../../utils/show_toast.dart';

class FormDemo extends StatefulWidget {
  FormDemo({super.key, this.addCallback});

  Function? addCallback;

  @override
  State<FormDemo> createState() => _FormDemoState();

  static String? validateNum(String? value) {
    if (value == null || value.trim() == '') {
      return '请输入持仓数量';
    }

    double v = double.parse(value);
    if (v < 1) {
      return '持仓数量必须大于0';
    }

    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.trim() == '') {
      return '请输入资产价格';
    }
    if (!value.isNum) {
      return '价格只能是数字';
    }

    return null;
  }
}

class _FormDemoState extends State<FormDemo> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameCtl = TextEditingController();
  TextEditingController numCtl = TextEditingController(text: '1');
  TextEditingController priceCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var listView = ListView(padding: const EdgeInsets.all(20), children: [
      const Center(
          child: Text(
        "账户资产管理",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.blueAccent),
      )),
      const SizedBox(
        height: 20,
      ),
      Form(
          key: _formKey,
          child: Column(
              children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                contentPadding: const EdgeInsets.all(0),
                leading: const Text('资产名称'),
                title: SizedBox(
                    height: 50,
                    child: TextFormField(
                      maxLength: 10,
                      controller: nameCtl,
                      decoration: const InputDecoration(
                        hintText: '资产名称',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.trim() == '') {
                          return '请输入资产名称';
                        }
                      },
                    ))),
            ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              dense: false,
              contentPadding: const EdgeInsets.all(0),
              leading: const Text('资产价格'),
              title: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: priceCtl,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: '负数表示负债资产',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                    validator: (value) {
                      return FormDemo.validatePrice(value);
                    },
                  )),
            ),
            ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                contentPadding: const EdgeInsets.all(0),
                leading: const Text('持有数量'),
                title: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: numCtl,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: InputBorder.none,
                      ),
                      validator: FormDemo.validateNum,
                    ))),
            const SizedBox(
              height: 10,
            ),
          ]).toList())),
    ]);

    return SafeArea(
      child: Container(
          color: cardColor,
          child: Stack(children: [
            listView,
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(builder: (BuildContext bc) {
                        return ElevatedButton(
                            onPressed: () {
                              add();
                            },
                            child: const Text("添加"));
                      }),
                      Builder(builder: (BuildContext bc) {
                        return TextButton(
                            onPressed: () {
                              Scaffold.of(bc).closeEndDrawer();
                            },
                            child: const Text("取消"));
                      })
                    ],
                  )),
            )
          ])),
    );
  }

  void add() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (nameCtl.text.isEmpty) {
      showToastForAllPlatform(context, '资产名称不能为空');
      return;
    }

    var params = {
      'name': nameCtl.text,
      'num': numCtl.text,
      'price': priceCtl.text,
    };
    String url = '/assets/add';
    //await Get.find<HttpService>().post(url, data: params);
    resetForm();
    showToastForAllPlatform(context, '添加成功!', duration: 1);
    if (widget.addCallback != null) {
      widget.addCallback!();
    }
  }

  void resetForm() {
    nameCtl.value = const TextEditingValue(text: '');
    priceCtl.value = const TextEditingValue(text: '');
    numCtl.value = const TextEditingValue(text: '1');
    setState(() {});
  }
}
