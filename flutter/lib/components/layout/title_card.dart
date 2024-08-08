import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/confi.dart';

class TitleCard extends StatelessWidget {
  String? title;
  Widget child;
  Widget? titleWidget;

  TitleCard(this.child, {super.key,this.titleWidget,this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:cardColor,
      surfaceTintColor:cardColor,
      margin: const EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(leading:Icon(Icons.label_important_outline_sharp,size: 15,color:Theme.of(context).primaryColor,),title:titleWidget ?? Text(title??'',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),contentPadding: EdgeInsets.zero,dense: true,minVerticalPadding: 0,),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xffededed),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
        ],
      ),
    );
  }
}
