import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';
import '../../../shared/custom_text/custom_bottom_cart.dart';
import '../widgets/order_details.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  String selected = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Order summary',
                font: FontWeight.w600,
                size: 25,
              ),
              Gap(10),
              OrderDetails(
                order: '16.48',
                taxes: '0.3',
                fees: '1.5',
                total: '18.19',
              ),
              Gap(60),
              CustomText(
                text: 'Payment methods',
                size: 23,
                font: FontWeight.w600,
              ),
              Gap(10),
              ListTile(
                onTap: () => setState(() => selected = 'Cash'),
                tileColor: Color(0xff3C2F2F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                contentPadding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                leading: Image.asset('assets/test/cash.png', width: 50),
                title: CustomText(
                  text: 'Cash on Delivery',
                  size: 15,
                  color: Colors.white,
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Cash',
                  groupValue: selected,
                  onChanged: (value) {
                    setState(() => selected = value!);
                  },
                ),
              ),
              Gap(10),
              ListTile(
                onTap: () => setState(() => selected = 'Visa'),
                tileColor: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                contentPadding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16.0,
                  vertical: 2.0,
                ),
                leading: Image.asset('assets/test/Icons2.png', width: 50),
                title: CustomText(
                  text: 'Debit card',
                  size: 13,
                  color: Colors.white,
                ),
                subtitle: CustomText(
                  text: '3566 **** **** 0505',
                  size: 13,
                  color: Colors.white70,
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Visa',
                  groupValue: selected,
                  onChanged: (value) {
                    setState(() => selected = value!);
                  },
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: Color(0xffEF2A39),
                    value: true,
                    onChanged: (value) {},
                  ),
                  CustomText(
                    text: 'Save card details for future payments',
                    color: Color(0xff808080),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Total price',
                  color: Color(0xff808080),
                  size: 14,
                ),
                CustomText(text: '\$18.19', size: 25, font: FontWeight.bold),
              ],
            ),
            CustomBottomCart(
              text: 'Pay Now',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 170,
                        ),
                        child: Container(
                          width: 500,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, -4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundColor: AppColors.primaryColor,
                                child: Icon(
                                  CupertinoIcons.check_mark,
                                  size: 55,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(10),
                              CustomText(
                                text: 'Success !',
                                color: AppColors.primaryColor,
                                size: 25,
                                font: FontWeight.bold,
                              ),
                              CustomText(
                                text:
                                    'Your payment was successful.\n'
                                    'A receipt for this purchase has \n'
                                    ' been sent to your email',
                                color: Color(0xff808080),
                                size: 14,
                              ),
                              Gap(15),
                              CustomBottomCart(
                                width: 200,
                                height: 50,
                                text: 'Go Back',
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
