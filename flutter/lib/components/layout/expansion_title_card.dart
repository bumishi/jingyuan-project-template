import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/confi.dart';

class ExpantionTitleCard extends StatelessWidget {
  String? title;
  List<Widget> child;
  bool? expand;

  ExpantionTitleCard(this.child, {super.key, this.title,this.expand});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: cardColor,
        surfaceTintColor: cardColor,
        margin: const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 10),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: expand??false,
                leading: Icon(
                  Icons.label_important_outline_sharp,
                  size: 15,
                  color: Theme.of(context).primaryColor,
                ),

                title: Text(title ?? '',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                dense: true,
                children: child,
              ),
            )));
  }
}
