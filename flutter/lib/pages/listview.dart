import 'package:flutter/material.dart';
import '../utils/utils.dart';

class ListViewDemo extends StatelessWidget {
  const ListViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> lists = [
      ListTile(
          enableFeedback: true,
          contentPadding: const EdgeInsets.only(left: 15, right: 10),
          dense: true,
          leading: const Icon(Icons.book),
          title: const Text(
            '投资知识',
            style: TextStyle(fontSize: 16),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
              openUrl(
                  'http://bumishi.cn/touzitixi/01%E6%8A%95%E8%B5%84%E7%9A%84%E5%BF%85%E8%A6%81.html');
          }),
      ListTile(
          enableFeedback: true,
          contentPadding: const EdgeInsets.only(left: 15, right: 10),
          dense: true,
          leading: const Icon(Icons.article),
          title: const Text(
            '基金投资课',
            style: TextStyle(fontSize: 16),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
              openUrl(
                  'https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzA3MjI3MzU3Mg==&action=getalbum&album_id=2587655033635487744&scene=126#wechat_redirect');
          }),
      ListTile(
          enableFeedback: true,
          contentPadding: const EdgeInsets.only(left: 15, right: 10),
          dense: true,
          leading: const Icon(Icons.code),
          title: const Text(
            '开源项目模板',
            style: TextStyle(fontSize: 16),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
              openUrl(
                  'https://mp.weixin.qq.com/s/WbeKn7vPQzOrbHzaytFTJw?poc_token=HDwJcWajJ97LiWoWdycHKQpA7a9lv_6UuCQZMNzD');
          }),
    ];

    return ListView(
      children: ListTile.divideTiles(tiles: lists, context: context).toList(),
    );
  }
}
