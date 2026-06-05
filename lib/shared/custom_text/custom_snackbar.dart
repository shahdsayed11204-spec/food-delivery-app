import 'package:Hungry_App/shared/custom_text/coustom_taxt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

SnackBar customSnack({required String errorMsg,Color? color}){
return SnackBar(
  padding: EdgeInsets.all(10),
  margin: EdgeInsets.only(bottom: 40,left: 20,right: 20),
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(5)
  ),
  behavior: SnackBarBehavior.floating,
  clipBehavior: Clip.none,
  elevation: 5.0,
  backgroundColor: color ?? Colors.red.shade900,
  content: Row(
    children: [
      Icon(CupertinoIcons.info_circle,color: Colors.white,size: 12,),
      Gap(20),
      CustomText(text: errorMsg,size: 11,font: FontWeight.bold,color: Colors.white,),
    ],
  ),
);
}