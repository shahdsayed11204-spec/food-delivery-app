import 'package:Hungry_App/features/home/data/repi/product_repi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constants/api_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_text/custom_snackbar.dart';
import '../../auth/data/auth_model/user_model.dart';
import '../../auth/data/repository/auth_reposi.dart';
import '../../products/view/products_details.dart';
import '../data/models/product_model.dart';
import '../widgets/PinnedHeaderDelegate.dart';
import '../widgets/cart.dart';
import '../widgets/categoris.dart';
import '../widgets/search_home.dart';
import '../widgets/uesr_header.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> categories = ['All', 'Sliders', 'Combos', 'Classic'];
  int selectedIndex = 0;

  List<ProductModel>? products;
  final ProductRepo productRepo = ProductRepo();

  Future<void> getProducts() async {
    final response = await productRepo.getProducts();
    setState(() {
      products = response;
    });
  }

  UserModel? _userModel;
  bool isGuest = false;
  AuthRepo authRepost = AuthRepo();

  Future<void> getProfileData() async {
    try {
      final user = await authRepost.getProfileData();
      if (!mounted) return;
      setState(() {
        _userModel = user;
      });
    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg: errorMsg));
    }
  }

  @override
  void initState() {
    getProducts();
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products == null,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          body: RefreshIndicator(
            color: AppColors.primaryColor,
            backgroundColor: Colors.white,
            onRefresh: () async {
              setState(() {
                products = null;
              });
              await getProducts();
            },
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: PinnedHeaderDelegate(
                    height: 215,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(60),
                          UserHeader(
                            userName: _userModel?.name ?? 'Doodah',
                            userImage: _userModel?.image ?? '',
                          ),
                          const Gap(20),
                          SearchHome(),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        HomeCategoris(
                          selectedIndex: selectedIndex,
                          categories: categories,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 7, right: 7, bottom: 100, top: 15),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: products?.length,
                          (context, index) {
                        if (products == null) {
                          return const CupertinoActivityIndicator();
                        }
                        final product = products![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsDetails(
                                  imagePath: product.image,
                                  productId: product.id,
                                ),
                              ),
                            );
                          },
                          child: CardItem(
                            image: product.image,
                            text: product.name,
                            desc: '${product.price} EGP',
                            rate: product.rate.toString(),
                          ),
                        );
                      },
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


