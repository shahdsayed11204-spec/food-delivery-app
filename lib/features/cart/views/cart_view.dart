import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text/coustom_taxt.dart';
import '../../../shared/custom_text/custom_bottom.dart';
import '../../auth/data/auth_model/user_model.dart';
import '../../auth/data/repository/auth_reposi.dart';
import '../../check_out/views/check_out_view.dart';
import '../data/models/cart_models.dart';
import '../data/repi/cart_repi.dart';
import '../widgets/cart_item_card.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<int> quantity = [];
  bool isLoading = false;
  int? deletingItemId;

  /// AutoLogin
  UserModel? _userModel;
  bool isGuest =false;
  AuthRepo authRepost = AuthRepo();

  Future<void>autoLogin()async{
    final user = await authRepost.autoLogin();
    setState(() {
      isGuest= authRepost.isGuest;
    });
    if(user !=null){
      setState(() {
        _userModel=user;
      });
    }
  }
  /// get cart
  final CartRepo cartRepo = CartRepo();
  GetCartResponse? cart;

  Future<void> getCartData() async {
    try {
      if (!mounted) return;
      setState(() => isLoading = true);

      final res = await cartRepo.getCartData();
      if (!mounted) return;

      final itemCount = res?.cartData.items.length ?? 0;
      setState(() {
        cart = res;
        quantity = List.generate(itemCount, (_) => 1);
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      debugPrint(e.toString());
    }
  }

  Future<void> removeCartItem(int id) async {
    try {
      if (!mounted) return;
      setState(() {
        deletingItemId = id;
      });
      await cartRepo.removeCartItem(id);
      if (!mounted) return;
      await getCartData();
      if (!mounted) return;
      setState(() {
        deletingItemId = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        deletingItemId = null;
      });
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getCartData();
    autoLogin();
  }

  void onAdd(int index) {
    if (index < quantity.length) {
      setState(() {
        quantity[index]++;
      });
    }
  }

  void onMinus(int index) {
    if (index < quantity.length && quantity[index] > 1) {
      setState(() {
        quantity[index]--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!isGuest)
      return Scaffold(

      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        toolbarHeight: 50,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title: CustomText(
          text: 'My Cart',
          color: Colors.black87,
          font: FontWeight.w600,
          size: 20,
        ),
      ),
      body: isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : cart == null || cart!.cartData.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: getCartData,
              color: AppColors.primaryColor,
              backgroundColor: Colors.white,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: cart!.cartData.items.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = cart!.cartData.items[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: CartItemCard(
                        isLoading: deletingItemId == item.itemId,
                        text: item.name,
                        image: item.image,
                        desc: 'Spicy ${item.spicy}',
                        number: index < quantity.length
                            ? quantity[index]
                            : item.quantity,
                        onRemove: () => removeCartItem(item.itemId),
                        onPlus: () => onAdd(index),
                        onMins: () => onMinus(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),


          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.8),
                  AppColors.primaryColor.withOpacity(0.8),
                  AppColors.primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Column(
              children: [
                const Gap(8),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckOutView(
                        totalPrice: cart?.cartData.totalPrice ?? "0.0",
                      ),
                    ),
                  ),
                  child: CustomButton(
                    gap: 80,
                    height: 45,
                    text: 'Checkout',
                    widget: CustomText(
                      text: '${cart?.cartData.totalPrice ?? "0.0"}\$',
                      size: 14,
                    ),
                    color: Colors.white,
                    width: double.infinity,
                    textColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    else{
    return Center(
      child: CustomText(text: 'Please Create An Account'),
    );
    }

  }
}