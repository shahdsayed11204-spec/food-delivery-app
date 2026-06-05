import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    this.onMins,
    this.onPlus,
    this.onRemove,
    required this.number
  });

  final String image,text,desc;
  final Function()? onMins;
  final Function()? onPlus;
  final Function()? onRemove;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(image,width:100,),
                CustomText(text: text,font: FontWeight.bold),
                CustomText(text: desc),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: FloatingActionButton(
                        heroTag: null,
                        mini: true,
                        onPressed: onMins,
                        child: Icon(CupertinoIcons.minus ,
                          color: Colors.white,
                        ),
                        backgroundColor: AppColors.primaryColor,
                        elevation: 5,
                      ),
                    ),
                    Gap(20),
                    CustomText(text: number.toString(),font: FontWeight.bold,size: 20),
                    Gap(20),
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: FloatingActionButton(
                        heroTag: null,
                        mini: true,
                        onPressed: onPlus,
                        child: Icon(CupertinoIcons.plus,
                          color: Colors.white,
                        ),
                        elevation: 5,
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),

                  ],
                ),
                Gap(30),

                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 35.0,vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadiusGeometry.circular(30),
                      ),
                      child: CustomText(text: 'Remove',size: 18,font: FontWeight.bold,color: Colors.white)
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


