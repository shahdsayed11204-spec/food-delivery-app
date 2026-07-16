import 'package:Hungry_App/features/order/data/order_model.dart';
import 'package:Hungry_App/shared/custom_text/custom_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_text/coustom_taxt.dart';
import '../data/repoi.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}
class _OrderViewState extends State<OrderView> {
  bool isLoading= false;
  GetOrderModel ? orderData;
  OrderRepo orderRepo=OrderRepo();
  Future<void>getOrder()async{
    try{
      final response=await orderRepo.getOrder();
      setState(() {
        orderData=response;
      });
    }catch(e){
      if(e is ApiError)
        {
          ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg: e.message));
        }
    }
  }
  @override
  void initState() {
   getOrder();
    super.initState();
  }
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
                children: List.generate(
                  orderData?.data?.length?? 5
                , (index) {
                final order=orderData?.data?[index];
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
                                  imageUrl: order?.productImage ??'' ,
                                  fit: BoxFit.cover, // لتعبئة الدائرة
                                  progressIndicatorBuilder: (context, url, progress) =>
                                  const Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error, color: Colors.grey, size: 20)),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Hamburger Hamburger',
                                    font: FontWeight.bold,
                                  ),
                                  CustomText(text: 'Qty:X3'),
                                  CustomText(text: 'Price : ${order?.totalPrice}'??'203'),
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
