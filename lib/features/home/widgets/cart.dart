import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.rate,
  });

  final String image, text, desc, rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: Center(
                child: Image.network(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Gap( 8),

            Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            Gap( 4),

            Text(
              desc,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 22,
                ),
                Gap( 4),
                Text(rate),

                const Spacer(),

                Icon(
                  CupertinoIcons.heart,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

