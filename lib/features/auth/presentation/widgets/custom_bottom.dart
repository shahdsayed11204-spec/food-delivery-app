import 'package:flutter/material.dart';

import '../../../../core/constants/api_colors.dart';
import '../../../../shared/custom_text/coustom_taxt.dart';



Widget CustomBottom({
  required String text,
  void Function()? onTap,
   Color ? color,
   Color ? textcolor,
}) => GestureDetector(
  onTap: onTap,
  child: Container(
    width: double.infinity,
    height: 55.0,
    decoration: BoxDecoration(
      color:color??Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: Colors.white
      ),
    ),
    child: Center(
      child: CustomText(
        text: text,
        color: textcolor??AppColors.primaryColor,
        size: 16,
        font: FontWeight.bold,
      ),
    ),
  ),
);
