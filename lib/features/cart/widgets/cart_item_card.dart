import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoIcons, CupertinoActivityIndicator, CupertinoButton;
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
    required this.number,
    required this.isLoading,
  });

  final String image, text, desc;
  final Function()? onMins;
  final Function()? onPlus;
  final Function()? onRemove;
  final int number;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1.5,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias, // لضمان قطع الصورة كدائرة
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover, // لتعبئة الدائرة
                    progressIndicatorBuilder: (context, url, progress) =>
                    const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error, color: Colors.grey, size: 20)),
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: text,
                        font: FontWeight.bold,
                        size: 16,

                      ),
                      const Gap(4),
                      CustomText(
                        text: desc,
                        color: Colors.grey,
                        size: 13,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.grey[200]!,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          disabledColor: Colors.white.withOpacity(0.5),
                          onPressed: isLoading ? null : onMins,
                          child: Icon(
                            CupertinoIcons.minus,
                            color: isLoading ? Colors.grey[400] : Colors.black87,
                            size: 16,
                          ),
                        ),
                      ),
                      const Gap(12),

                      CustomText(
                        text: number.toString(),
                        font: FontWeight.bold,
                        size: 18,
                        color: Colors.black87,
                      ),
                      const Gap(12),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          disabledColor: Colors.white.withOpacity(0.5),
                          onPressed: isLoading ? null : onPlus,
                          child: Icon(
                            CupertinoIcons.plus,
                            color: isLoading ? Colors.grey[400] : Colors.black87,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: GestureDetector(
                    onTap: isLoading ? null : onRemove,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: isLoading
                            ? AppColors.primaryColor.withOpacity(0.4)
                            : (onRemove == null ? Colors.grey[300] : Colors.grey[100]),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.grey[200]!,
                        ),
                      ),
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.black87,
                          ),
                        )
                            : CustomText(
                          text: 'REMOVE',
                          size: 14,
                          font: FontWeight.bold,
                          color: onRemove == null ? Colors.grey[500] : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}