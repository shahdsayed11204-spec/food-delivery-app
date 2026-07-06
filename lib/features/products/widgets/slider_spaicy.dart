import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';


class SliderSpicy extends StatefulWidget {
  const SliderSpicy({super.key, required this.value, required this.onChanged, required this.imagePath});

  final double value;
  final ValueChanged<double>onChanged;
  final String imagePath;

  @override
  State<SliderSpicy> createState() => _SliderSpicyState();
}

class _SliderSpicyState extends State<SliderSpicy> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        CachedNetworkImage(
          imageUrl: widget.imagePath,
          fit: BoxFit.contain,
          width: 130.0,
          progressIndicatorBuilder:
              (context, url, progress) =>
          const Center(
            child: CupertinoActivityIndicator(),
          ),
          errorWidget: (context, url, error) =>
          const Center(
            child: Icon(Icons.error),
          ),
        ),
        Spacer(),
        Column(
          children: [
            CustomText(text: 'Customize Your Burger \n to Your. Ultimate\n Experience'),
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
