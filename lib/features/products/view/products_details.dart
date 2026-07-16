import 'package:Hungry_App/features/cart/data/models/cart_models.dart';
import 'package:Hungry_App/features/cart/data/repi/cart_repi.dart';
import 'package:Hungry_App/shared/custom_text/coustom_taxt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/api_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_text/custom_bottom.dart';
import '../../home/data/models/toppings_model.dart';
import '../../home/data/repi/product_repi.dart';
import '../widgets/slider_spaicy.dart';
import '../widgets/toppings_card.dart';

class ProductsDetails extends StatefulWidget {
  const ProductsDetails({super.key, required this.imagePath, required this.productId});
  final String imagePath;
  final int productId;
  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  late double value = 0.5;

 List<int> selectedOptionIndex=[];
  List<int> selectedToppingIndex=[];

/// Get Toppings
  ProductRepo productRepo = ProductRepo();

  List<ToppingsModel>? options;
  List<ToppingsModel>? toppings;

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
  /// Add To Cart
  CartRepo cartRepo=CartRepo();
   bool isLoading=false;
   bool isAddedToCart = false;


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
                    final topping = toppings?[index];
                    final id = topping?.id ?? 1;
                    if (topping ==null){
                      return CupertinoActivityIndicator();
                    }
                    final isSelected = selectedToppingIndex.contains(id);
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
                           if(isSelected){
                             selectedToppingIndex.remove(id);
                           }else{
                             selectedToppingIndex.add(id);
                           }
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

                    final option = options?[index];
                    final id = option?.id ?? 1;
                    if (option ==null){
                      return CupertinoActivityIndicator();
                    }
                    final isSelected = selectedOptionIndex.contains(id);
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
                          if(isSelected){
                            selectedOptionIndex.remove(id);
                          }else{
                            selectedOptionIndex.add(id);
                          }
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
                  CustomButton(
                    text: 'Add To Cart',
                   widget:isLoading
                       ? const CupertinoActivityIndicator(color: Colors.white,)
                       : const Icon(Icons.shopping_cart,color: Colors.white,size: 20,),
                    gap: 8,
                    onTap: ()async {
                      try {
                        if (!mounted) return;
                        setState(() => isLoading = true);
                        final cartItem = CartModel(
                          productId: widget.productId,
                          qty: 1,
                          spicy: value,
                          toppings: selectedToppingIndex,
                          options: selectedOptionIndex,
                        );
                        await cartRepo.addToCart(
                          CartRequestModel(items: [cartItem]),
                        );
                        if (!mounted) return;
                        setState(() {
                          isLoading = false;
                          isAddedToCart = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Added to cart successfully!',
                            ),
                          ),
                        );
                      } on ApiError catch (error) {
                        if (!mounted) return;
                        setState(() => isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        setState(() => isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Something went wrong. Please try again.',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
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