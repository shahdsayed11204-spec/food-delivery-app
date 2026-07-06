import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_text/coustom_taxt.dart';

class ToppingCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onAdd;
  final Color color;

  const ToppingCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onAdd,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            imagePath.isNotEmpty && imagePath.startsWith('http')
                ? CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.contain,
              height: 55,
              progressIndicatorBuilder: (context, url, progress) =>
              const Center(
                child: CupertinoActivityIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.fastfood, color: Colors.grey, size: 30),
              ),
            )
                : const SizedBox(
              height: 55,
              child: Center(
                child: Icon(Icons.fastfood, color: Colors.grey, size: 30),
              ),
            ),
            const Gap(10),
            CustomText(
              text: title,
              color: Colors.black87,
              size: 13,
              font: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}