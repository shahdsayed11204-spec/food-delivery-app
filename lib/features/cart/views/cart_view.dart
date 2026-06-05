import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_text/coustom_taxt.dart';
import '../../../shared/custom_text/custom_bottom_cart.dart';
import '../../../shared/navigator/navigatorTo.dart';
import '../../check_out/views/check_out_view.dart';
import '../widgets/cart_item_card.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> quantity = [];
  int counter = 10;

  @override
  void initState() {
    quantity = List.generate(counter, (value) {return 1;});
    super.initState();
  }

  void onAdd(int index) {
    setState(() {
      quantity[index]++;
    });
  }

  void onMinus(int index) {
    setState(() {
      if (quantity[index] > 1) quantity[index]--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              physics:  BouncingScrollPhysics(),
              child: Column(
                children: [
                   Gap(20),
                  Column(
                    children: List.generate(counter, (index) {
                      return CartItemCard(
                        image: 'assets/test/test.png',
                        text: 'Hamburger',
                        desc: 'Veggie Burger',
                        number: quantity[index],
                        onPlus: () => onAdd(index),
                        onMins: () => onMinus(index),
                      );
                    }),
                  ),
                   Gap(10),
                ],
              ),
            ),
          ),
        ),

        /// Bottom bar (بديل bottomNavigationBar)
        Container(
          margin: EdgeInsets.only(bottom: 60.0),
          padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:  BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset:  Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  CustomText(text: 'Total', size: 16),
                  CustomText(
                    text: '\$90.19',
                    size: 25,
                    font: FontWeight.bold,
                  ),
                ],
              ),
              CustomBottomCart(
                text: 'Checkout',
                onTap: ()
                {
                  navigatorTo(context, CheckOutView());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
