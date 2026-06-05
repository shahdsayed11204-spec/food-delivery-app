
import 'package:flutter/material.dart';

void navigatorendfini( context,  widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic>route)=>false,
);