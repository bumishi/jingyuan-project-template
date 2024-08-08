import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template/components/layout/app_bar.dart';
import 'package:flutter_template/components/layout/title_card.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../confi.dart';
import '../../service/http_service.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key});

  @override
  State createState() {
    return CeNueDetailState();
  }
}

class CeNueDetailState extends State<DetailPage> {
  static final DateFormat inputFormat = DateFormat("yyyy-MM-dd");


  Map detail = {
    'info': {},
    'exchange_info': {'target': [], 'change_sign': []}
  };

  List get holds => detail['exchange_info']['target'];

  List get changeSigns => detail['exchange_info']['change_sign'];

 String id='';

  @override
  void initState() {
    super.initState();
    //获取路由参数
    id = Get.arguments['id'].toString();
    _loadData();
  }

  _loadData() async {
    EasyLoading.show(status: '数据加载中...');
    var api = "/xxx/get/${id}";
   // var res = await Get.find<HttpService>().get(api);
    var res= {
        "info": {
          "id": 1,
          "name": "二八轮动增强",
          "mark": "本策略是二八轮动策略的优化版。二八轮动，指的是市值最大的前 20% 数量的大盘股和剩下数目占 80% 的中小盘股之间的轮动。经典二八轮动策略的主要驱动逻辑是动量。二八轮动假设了市场资金的流动是有惯性的：当近期大盘股涨得多的时候，后续大概率资金还会持续地向大盘股流入；直到这个趋势难以持续下去的时候，资金又会向小盘股流动，而且这个趋势一旦开始，资金就又会一直往小盘股流入。",
          "auth": null,
          "subcrib_users": null
        },

        "exchange_info": {
          "target": [
            {
              "bdname": "沪深300",
              "weight": 0,
              "bdinfo": {
                "id": 2,
                "name": "沪深300",
                "code": "000300"
              }
            },
            {
              "bdname": "创业板指",
              "weight": 0,
              "bdinfo": {
                "id": 18,
                "name": "创业板指",
                "code": "399006"
              }
            }
          ],
          "change_sign": [
            {
              "bdname": "创业板指",
              "weight": -100,
              "bdinfo": {
                "id": 18,
                "name": "创业板指",
                "code": "399006"
              }
            }
          ],
          "day": "2024-08-05"
        }
      };
    detail = res ?? {'info': {}};
    EasyLoading.dismiss();
    // print("getdata..");
    // print(res);
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppbar('策略详细'),
        body: ListView(children: [
          TitleCard(
            Wrap(
              children: [
                Text(
                  detail['info']['mark'] ?? '',
                  softWrap: true,
                ),
              ],
            ),
            title: detail['info']['name'] ?? '',
          ),

          TitleCard(
            SizedBox(
                height: (tableRowHeight * (holds.isEmpty ? 1 : holds.length) +
                    tableHeaderHeight),
                child: createHoldTable()),
            title: "策略持仓",
          ),
          TitleCard(
            SizedBox(
                height: (tableRowHeight *
                        (changeSigns.isEmpty ? 1 : changeSigns.length) +
                    tableHeaderHeight),
                child: createChangeSignTable()),
            title:
                "最新调仓${changeSigns.isEmpty ? '' : '【${detail['exchange_info']['day'] ?? '--'}】'}",
          ),
          const SizedBox(
            height: 100,
          )
        ]));
  }

  double getFrom(e) {
    e ??= 0;
    if (e is double) {
      return e;
    }
    return double.parse(e.toString());
  }

  DataTable2 createHoldTable() {
    return DataTable2(
        dataRowHeight: tableRowHeight,
        empty: const Text('当前空仓'),
        columnSpacing: 5,
        horizontalMargin: 5,
        columns: const [
          DataColumn2(
            label: Text('名称'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('代码'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('仓位(%)'),
            size: ColumnSize.S,
          ),
        ],
        rows: holds
            .map((item) => DataRow(cells: [
                  DataCell(Text(item['bdinfo']['name'])),
                  DataCell(Text(item['bdinfo']['code'])),
                  DataCell(Text((item['weight'] ?? 0).toString())),
                ]))
            .toList());
  }

  DataTable2 createChangeSignTable() {
    return DataTable2(
        dataRowHeight: tableRowHeight,
        empty: const Text('暂无调仓'),
        columnSpacing: 5,
        horizontalMargin: 5,
        columns: const [
          DataColumn2(
            label: Text('名称'),
          ),
          DataColumn2(
            label: Text('代码'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('操作'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('仓位(%)'),
            size: ColumnSize.S,
          ),
        ],
        rows: changeSigns
            .map((item) => DataRow(cells: [
                  DataCell(Text(item['bdinfo']['name'])),
                  DataCell(Text(item['bdinfo']['code'])),
                  DataCell(Text(item['weight'] > 0 ? '买入' : '卖出')),
                  DataCell(Text((item['weight'] ?? 0).toString())),
                ]))
            .toList());
  }
}
