import 'package:Hungry_App/core/constants/api_colors.dart';
import 'package:Hungry_App/core/utils/pref_helper.dart';
import 'package:Hungry_App/root.dart';
import 'package:Hungry_App/shared/navigator/navigatorTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'features/auth/presentation/view/login_view.dart';

class Splachview extends StatefulWidget {
  const Splachview({super.key});

  @override
  State<Splachview> createState() => _SplachviewState();
}

class _SplachviewState extends State<Splachview> {
  bool animate = false;

  checkLogin() async {
    Future.delayed(
      const Duration(seconds: 8),
          () async {
        final token = await PrefHelper.getToken();

        if (token != null && token.isNotEmpty) {
          navigatorTo(context, Root());
        } else {
          navigatorTo(context, LoginView());
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => animate = true);
    });


    checkLogin();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const Gap(258),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: animate ? 1 : 0,
            child: SvgPicture.asset('assets/logo/logo.svg'),
          ),

          const Spacer(),
          AnimatedSlide(
            duration: const Duration(milliseconds: 800),
            offset: animate ? Offset.zero : const Offset(0, .3),
            child: Image.asset('assets/splach/splach.png'),
          ),
        ],
      ),
    );
  }
}
