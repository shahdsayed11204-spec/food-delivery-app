import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.image, required this.text, required this.desc, required this.rate});

  final String image,text,desc,rate;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(image,width: 125,)),
            Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:text,font: FontWeight.bold),
                CustomText(text: desc),

              ],
            ),
            Row(
              children: [
                CustomText(text: rate),
                Spacer(),
                Icon(CupertinoIcons.suit_heart,color: AppColors.primaryColor),
              ],
            ),




          ],
        ),
      ),

    );
  }
}

