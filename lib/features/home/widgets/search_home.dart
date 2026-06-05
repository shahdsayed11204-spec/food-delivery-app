import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/api_colors.dart';
class SearchHome extends StatelessWidget {
  const SearchHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: TextFormField(
        style: TextStyle(color: AppColors.primaryColor),
        cursorColor:AppColors.primaryColor,
        cursorHeight: 20.0,
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.search),
          hintText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
