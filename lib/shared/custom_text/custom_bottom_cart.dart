import 'package:Hungry_App/core/constants/api_colors.dart';
import 'package:Hungry_App/shared/custom_text/coustom_taxt.dart';
import 'package:flutter/material.dart';


class CustomBottomCart extends StatelessWidget {
  const CustomBottomCart({super.key, required this.text, this.onTap, this.width, this.height, this.redius,});

  final String text;
  final Function()? onTap;
  final double ? width;
  final double ? height;
  final double ? redius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
          height: height,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 30.0,vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadiusGeometry.circular(redius ?? 15),
          ),
          child: Center(child: CustomText(text: text,size: 14,font: FontWeight.bold,color: Colors.white))
      ),
    );
  }
}
