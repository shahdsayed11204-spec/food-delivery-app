import 'package:Hungry_App/shared/custom_text/coustom_taxt.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/custom_bottom_cart.dart';
import '../../../shared/navigator/navigatorTo.dart';
import '../../cart/views/cart_view.dart';
import '../../home/data/models/toppings_model.dart';
import '../../home/data/repi/product_repi.dart';
import '../widgets/slider_spaicy.dart';
import '../widgets/toppings_card.dart';

class ProductsDetails extends StatefulWidget {
  const ProductsDetails({super.key, required this.imagePath});
  final String imagePath;
  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  late double value = 0.5;

  int? selectedToppingIndex;
  int? selectedOptionIndex;

  ProductRepo productRepo = ProductRepo();
  List<ToppingsModel>? toppings;
  List<ToppingsModel>? options;

  Future<void> getToppings() async {
    final response = await productRepo.getToppings();
    setState(() {
      toppings = response;
    });
  }

  Future<void> getOptions() async {
    final response = await productRepo.getOptions();
    setState(() {
      options = response;
    });
  }

  @override
  void initState() {
    getToppings();
    getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                imagePath: widget.imagePath,
              ),
              const Gap(30),
              CustomText(text: 'Toppings', size: 20, font: FontWeight.bold),
              const Gap(16),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(toppings?.length ?? 5, (index) {
                    final isSelected = selectedToppingIndex == index;
                    final topping = toppings?[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ToppingCard(
                        color: isSelected
                            ? AppColors.primaryColor.withOpacity(0.5)
                            : AppColors.primaryColor.withOpacity(0.05),
                        title: topping?.name ?? 'Tomato',
                        imagePath: topping?.image ?? '',
                        onAdd: () {
                          setState(() {
                            selectedToppingIndex = index;
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
              const Gap(30),
              CustomText(text: 'Side options', size: 20, font: FontWeight.bold),
              const Gap(16),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(options?.length ?? 5, (index) {
                    final isSelected = selectedOptionIndex == index;
                    final option = options?[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ToppingCard(
                        color: isSelected
                            ? AppColors.primaryColor.withOpacity(0.5)
                            : AppColors.primaryColor.withOpacity(0.05),
                        title: option?.name ?? 'Option',
                        imagePath: option?.image ?? '',
                        onAdd: () {
                          setState(() {
                            selectedOptionIndex = index;
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
              const Gap(80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Total', size: 14, color: Colors.grey),
                      const Gap(4),
                      CustomText(
                        text: '\$18.19',
                        size: 26,
                        font: FontWeight.bold,
                      ),
                    ],
                  ),
                  CustomBottomCart(
                    text: 'Add To Cart',
                    onTap: () {
                      navigatorTo(context, const CartView());
                    },
                  ),
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}