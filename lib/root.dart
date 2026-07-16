import 'package:Hungry_App/shared/custom_text/coustom_taxt.dart';
import 'package:Hungry_App/shared/custom_text/custom_glassbottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/view/profile_view.dart';
import 'features/cart/views/cart_view.dart';
import 'features/home/views/home_view.dart';
import 'features/order/views/order_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  late List<Widget> screens;
  int currentScreen = 0;
  late List<AnimationController> iconControllers;

  @override
  void initState() {
    super.initState();
    screens = [
       HomeView(),
      const CartView(),
      const OrderView(),
       ProfileView(),
    ];

    iconControllers = List.generate(
      4,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    iconControllers[currentScreen].forward();
  }

  @override
  void dispose() {
    for (var c in iconControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == currentScreen) return;

    setState(() => currentScreen = index);

    iconControllers[index].forward();
    for (var i = 0; i < iconControllers.length; i++) {
      if (i != index) iconControllers[i].reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: currentScreen, children: screens),
        bottomNavigationBar: GlassBottomNavBar(
          currentIndex: currentScreen,
          onTap: _onTabTapped,
          items: [
            BottomNavItemData(
              label: 'Home',
              icon: const Icon(CupertinoIcons.home),
              filledIcon: const Icon(CupertinoIcons.house_fill),
            ),
            BottomNavItemData(
              label: 'Cart',
              icon: const Icon(CupertinoIcons.cart),
              filledIcon: Badge(
                label:  CustomText(text: '1', size: 10),
                child: const Icon(CupertinoIcons.cart_fill_badge_plus),
              ),
            ),
            BottomNavItemData(
              label: 'History',
              icon: const Icon(Icons.table_bar_outlined),
              filledIcon: const Icon(Icons.table_bar_rounded),
            ),
            BottomNavItemData(
              label: 'Profile',
              icon: const Icon(CupertinoIcons.person_alt_circle),
              filledIcon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}