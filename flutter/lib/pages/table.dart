import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template/components/layout/app_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../service/http_service.dart';

class TableDemoPage extends StatefulWidget {
  const TableDemoPage({Key? key});

  @override
  State createState() {
    return ZhishuListState();
  }
}

class ZhishuListState extends State<TableDemoPage> {
  bool _sortAscending = false;
  int _sortColumnIndex = 3;
  List data = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _loadData(false);
  }

  _loadData(bool pullRefresh) async {
    if (!pullRefresh) {
      EasyLoading.show(status: '数据加载中...');
    }
    // var res =
    //     await Get.find<HttpService>().post("/xxx/query", data: {'limit':100});
    // print("getdata..");
    // print(res);
    if (!pullRefresh) {
      EasyLoading.dismiss();
    } else {
      _refreshController.refreshCompleted();
    }
    var res = {
      'data': [
        {
          'name': '沪深300',
          'code': 'hs300',
          'zxbgq': '2024-03-31',
          'roe': 40.5,
          'mlrl': 0.65
        },
        {
          'name': '创业板',
          'code': 'cyb',
          'zxbgq': '2024-03-31',
          'roe': 30.5,
          'mlrl': 0.75
        }
      ]
    };
    data = res['data'] ?? [];
    _sort(_sortColumnIndex, _sortAscending);
  }

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      if (_sortColumnIndex == 3) {
        var field = 'roe';
        sortField(field);
      } else if (_sortColumnIndex == 4) {
        var field = 'mlrl';
        sortField(field);
      }
    });
  }

  void sortField(String field) {
    if (_sortAscending) {
      data.sort((a, b) => a[field]?.compareTo(b[field]));
    } else {
      data.sort((a, b) {
        if (b[field] == null) {
          return -1;
        }
        if (a[field] == null) {
          return 1;
        }
        return b[field].compareTo(a[field]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SmartRefresher(
            header: WaterDropHeader(
                complete: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.done,
                  color: Colors.grey,
                ),
                Container(
                  width: 15.0,
                ),
                const Text(
                  '刷新完成',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )),
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: () => _loadData(true),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: DataTable2(
                    minWidth: 800,
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    fixedLeftColumns: 1,
                    columnSpacing: 8,
                    horizontalMargin: 10,
                    columns: [
                      const DataColumn2(label: Text('名称')),
                      const DataColumn2(label: Text('代码'), fixedWidth: 150),
                      const DataColumn2(label: Text('报告期'), fixedWidth: 150),
                      DataColumn2(
                        label: Text('ROE'),
                        numeric: true,
                        fixedWidth: 150,
                        onSort: (int columnIndex, bool ascending) {
                          _sort(columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text('毛利率'),
                        numeric: true,
                        fixedWidth: 150,
                        onSort: (int columnIndex, bool ascending) {
                          _sort(columnIndex, ascending);
                        },
                      ),
                    ],
                    rows: data
                        .map((item) => DataRow(cells: [
                              DataCell(
                                  Text(
                                    item['name'],
                                    style: const TextStyle(color: Colors.blue),
                                  ), onTap: () {
                                    //路由跳转并传参数
                                Get.toNamed('/detail',
                                    arguments: {'id': item['code']});
                              }),
                              DataCell(Text(item['code'])),
                              DataCell(Text(item['zxbgq'] ?? '')),
                              DataCell(Text((item['roe'] ?? 0).toString())),
                              DataCell(Text((item['mlrl'] ?? 0).toString())),
                            ]))
                        .toList()))));
  }
}
