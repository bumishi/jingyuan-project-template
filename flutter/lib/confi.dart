import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const config={
  'api_base_url':'http://localhost:9000'
};

double toolbarHeight=40;
double tableRowHeight=40;
double tableHeaderHeight=65;
double formItemHeight = 60;
const Color cardColor = Colors.white;

const TextStyle emptyTextStyle=TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.orange);

const List<Color> colors = [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.green,
  Colors.orange,
  Colors.teal,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.amber,
  Colors.cyanAccent,
  Colors.indigoAccent,
  Colors.deepPurple,
  Colors.tealAccent
];

final DateFormat inputFormat = DateFormat("yyyy-MM-dd");

final DateFormat intInputFormat = DateFormat("yyyyMMdd");