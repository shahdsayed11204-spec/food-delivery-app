import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';

class UesrHeader extends StatelessWidget {
  const UesrHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/logo/logo.svg',
              color: AppColors.primaryColor,
              height: 35,
            ),
            const Gap(10),
            CustomText(
              text: 'Hello, Shahdoda',
              color: Colors.grey.shade500,
              font: FontWeight.w700,
              size: 15,
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
          child: Icon(
            CupertinoIcons.person,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
