import 'package:flutter/material.dart';
import 'package:flutter_template/components/markdown.dart';
import 'package:flutter_template/pages/html_content_page.dart';
import 'package:get/get.dart';

class MessageTips extends StatelessWidget {
  MessageTips({super.key, required this.title, this.content, this.icon});

  String title;
  String? content;
  IconData? icon = Icons.tips_and_updates;

  @override
  Widget build(BuildContext context) {
    return title.isEmpty
        ? const SizedBox.shrink()
        : ListTile(
            horizontalTitleGap: 1,
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            leading: Icon(
              icon ?? Icons.tips_and_updates,
              size: 15,
              color: Colors.orange,
            ),
            title: Text(
              title,
              style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.visible,
            ),
            onTap: () => {
              if (content != null && content!.isNotEmpty)
                {
                  Get.to(
                      () => ShowHtmlContent(title: '系统公告', html: content ?? '',markdown: true,))

                }
            },
          );
  }
}
