import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Toppingcard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onAdd;

  const Toppingcard({
    super.key,
    required this.title,
    required this.imagePath,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 100,
            width: 110,
            color: const Color(0xff3C2F2F),
            child: Column(
              children:  [
              ],
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: -5,
          right: -5,
          bottom: 30,
          child: SizedBox(
            width: 80,
            height: 70,
            child: Card(
              child: Image.asset(
                imagePath,
                height: 60,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: -30,
          right: 8,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: GestureDetector(
            onTap: onAdd,
            child: const CircleAvatar(
              radius: 11,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.add,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
