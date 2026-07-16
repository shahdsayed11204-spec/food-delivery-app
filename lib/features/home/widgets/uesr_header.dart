import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';
class UserHeader extends StatelessWidget {
  const UserHeader({
    super.key,
    required this.userName,
    required this.userImage,
  });
  final String userName, userImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: 'Hello, ',
                  size: 30,
                  font: FontWeight.w300,
                  color: Colors.grey.shade600,
                ),
                CustomText(
                  text: userName,
                  size: 30,
                  font: FontWeight.w200,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            CustomText(
              text: 'HUNGRY RIGHT NOW 🙄?',
              size: 14,
              font: FontWeight.w500,
              color: Colors.grey.shade400,
            ),
          ],
        ),
        Spacer(),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl:userImage,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) =>
            const Center(
              child: CupertinoActivityIndicator(),
            ),
            errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error, color: Colors.grey, size: 20)),
          ),
        ),
      ],
    );
  }
}