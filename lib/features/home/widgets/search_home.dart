import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/api_colors.dart';
class SearchHome extends StatelessWidget {
   SearchHome({super.key, this.onChanged, required this.searchController});
   TextEditingController searchController = TextEditingController();
  final Function (String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return  Material(

      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: TextFormField(
        onChanged: onChanged,
        controller: searchController,
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
