import 'package:flutter/material.dart';
import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';

class HomeCategoris extends StatefulWidget {
  const HomeCategoris({
    super.key,
    required this.selectedIndex,
    required this.categories,
  });

  final int selectedIndex;
  final List categories;

  @override
  State<HomeCategoris> createState() => _HomeCategorisState();
}

class _HomeCategorisState extends State<HomeCategoris> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(widget.categories.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration:  Duration(milliseconds: 300),
              margin:  EdgeInsets.only(right: 8),
              padding: EdgeInsets.symmetric(horizontal: 27, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedIndex == index
                    ? AppColors.primaryColor
                    : const Color(0xffF3F4F6),
              ),
              child: CustomText(
                text: widget.categories[index],
                font: FontWeight.w600,
                color: selectedIndex == index
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          );
        }),
      ),
    );
  }
}
