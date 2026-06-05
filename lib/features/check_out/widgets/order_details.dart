import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_text/coustom_taxt.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order, required this.taxes, required this.fees, required this.total});
  final String order,taxes ,fees,total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        checkOutText( 'Order', order, true, true),
        Gap(10),
        checkOutText( 'Taxes',  taxes, true, true),
        Gap(10),
        checkOutText( 'Delivery fees', fees,true, true),
        Divider(),
        Gap(10),
        checkOutText( 'Total:',  total, false, true),
        Gap(10),
        checkOutText('Estimated delivery time:', '15 - 30 mins ', false, false),
      ],
    );
  }
}
Widget checkOutText(title,price,isBold,isSmall) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    CustomText(
      text: title,
      size: isSmall ? 16 : 13,
      font:isBold ?FontWeight.w400: FontWeight.bold,
      color: isBold ? Colors.grey.shade600:Colors.black,
    ),
    CustomText(
      text: '$price \$ ',
      size: isSmall ? 16 : 13,
      font:isBold ?FontWeight.w400: FontWeight.bold,
      color: isBold ?  Colors.grey.shade600:Colors.black,

    ),
  ],
);