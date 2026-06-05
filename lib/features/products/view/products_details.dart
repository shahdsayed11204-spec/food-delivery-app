import 'package:Hungry_App/shared/custom_text/coustom_taxt.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_text/custom_bottom_cart.dart';
import '../../../shared/navigator/navigatorTo.dart';
import '../../cart/views/cart_view.dart';
import '../widgets/slider_spaicy.dart';
import '../widgets/toppings_card.dart';


class ProductsDetails extends StatefulWidget {
  const ProductsDetails({super.key});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  late double value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderSpicy(
                value: value,
                onChanged: (sliderValue) {
                  setState(() {
                    value = sliderValue;
                  });
                },
              ),
              Gap(25),
              CustomText(text: 'Toppings', size: 18, font: FontWeight.bold),
              Gap(25),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Toppingcard(
                        title: 'Tomato',
                        imagePath: 'assets/test/tomato.png',
                        onAdd: () {},
                      ),
                    );
                  }),
                ),
              ),
              Gap(25),
              CustomText(text: 'Side options', size: 18, font: FontWeight.bold),
              Gap(25),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Toppingcard(
                        title: 'Tomato',
                        imagePath: 'assets/test/tomato.png',
                        onAdd: () {},
                      ),
                    );
                  }),
                ),
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Total', size: 16),
                      CustomText(
                        text: '\$18.19',
                        size: 25,
                        font: FontWeight.bold,
                      ),
                    ],
                  ),
                  CustomBottomCart(text: 'Add To Cart', onTap: () {
                    navigatorTo(context, CartView());
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
