import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_text/coustom_taxt.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 10, scrolledUnderElevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Gap(20),
              Column(
                children: List.generate(4, (index) {
                  return Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/test/test.png', width: 100),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Hamburger Hamburger',
                                    font: FontWeight.bold,
                                  ),
                                  CustomText(text: 'Qty:X3'),
                                  CustomText(text: 'Price:203'),
                                ],
                              ),
                            ],
                          ),
                          Gap(15),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 80.0,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadiusGeometry.circular(30),
                              ),
                              child: CustomText(
                                text: 'Order Again ',
                                size: 16,
                                font: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
