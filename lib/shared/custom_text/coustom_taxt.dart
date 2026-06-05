import 'package:flutter/material.dart';

Widget CustomText({
  required String text,
   Color ?color,
   FontWeight? font,
   double? size,
})=> Text(
  text,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  textScaler: TextScaler.linear(1.0),
  style: TextStyle(
    fontWeight: font,
    fontSize: size,
    color: color,
  ),
);