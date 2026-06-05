import 'package:flutter/material.dart';
import '../../../../core/constants/api_colors.dart';


class CustomUserTxtfield extends StatelessWidget {
  const CustomUserTxtfield({
    super.key,
    required this.controller,
    required this.label,
    this.textInputType,
  });
  final TextEditingController controller;
  final String label;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      controller: controller,
      keyboardType: textInputType,
      cursorColor:  AppColors.primaryColor,
      style: TextStyle(color: AppColors.primaryColor, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        labelText: label,
        labelStyle: TextStyle(color: AppColors.primaryColor,),
        hintStyle: TextStyle(color: AppColors.primaryColor,),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor,),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor,),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}