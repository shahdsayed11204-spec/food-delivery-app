import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';


class SliderSpicy extends StatefulWidget {
  const SliderSpicy({super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double>onChanged;

  @override
  State<SliderSpicy> createState() => _SliderSpicyState();
}

class _SliderSpicyState extends State<SliderSpicy> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Image.asset('assets/test/test2.png',width: 140.0,),
        Spacer(),
        Column(
          children: [
            CustomText(text: 'Customize Your Burger \n to Your Tastes. Ultimate\n Experience'),
            Gap(5),
            Slider(
              min: 0.0,
              max: 1.0,
              value:widget.value,
              activeColor: AppColors.primaryColor,
              onChanged: widget.onChanged,
            ),
          ],
        ),
      ],
    );
  }
}
