import 'package:Hungry_App/core/network/api_error.dart';
import 'package:Hungry_App/features/auth/presentation/view/signin_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/api_colors.dart';
import '../../../../core/utils/pref_helper.dart';
import '../../../../root.dart';
import '../../../../shared/custom_text/coustom_taxt.dart';
import '../../../../shared/custom_text/custom_bottom.dart';
import '../../../../shared/custom_text/custom_snackbar.dart';
import '../../../../shared/custom_text/custom_textformfiled.dart';
import '../../../../shared/custom_text/glass_container.dart';
import '../../../../shared/navigator/navigator_replace.dart';
import '../../data/repository/auth_reposi.dart';
import '../widgets/Custom_auth_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final email = TextEditingController(text: "ahd@gmail.com");
  final password = TextEditingController(text: '123456789');
  final formkey = GlobalKey<FormState>();

  bool isLoading = false;
  final AuthRepo authRepost = AuthRepo();

  Future<void> loginUser() async {
    if (!formkey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final user = await authRepost.login(email.text.trim(), password.text.trim());

      if (user != null) {
        print(await PrefHelper.getToken());
        print('LOGIN TOKEN = ${user.token}');
        await PrefHelper.saveToken(user.token!);
        print('SAVED TOKEN = ${await PrefHelper.getToken()}');
        if (!mounted) return;
        navigatorReplace(context, Root());
      }

    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'حدث خطأ أثناء تسجيل الدخول';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg: errorMsg));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: glassContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formkey,
            child: Column(
              children: [
                const Gap(140),
                Banner(
                  color: Colors.green.shade700,
                  message: 'Shahd Sayed',
                  location: BannerLocation.topStart,
                  child: SvgPicture.asset(
                    'assets/logo/logo.svg',
                    color: Colors.white70,
                  ),
                ),
                const Gap(10),
                 CustomText(
                  text: 'Welcome Back, Discover The Fast Food',
                  color: Colors.white70,
                  size: 13,
                  font: FontWeight.w500,
                ),
                const Gap(50),
                Column(
                  children: [
                    CustomTextformfiled(
                      controller: email,
                      hint: 'Email Address',
                      isPassword: false,
                    ),
                    const Gap(10),
                    CustomTextformfiled(
                      controller: password,
                      hint: 'Password',
                      isPassword: true,
                    ),
                    const Gap(20),
                    CustomButton(
                      height: 45,
                      gap: 10,
                      text: 'Login',
                      color: Colors.white.withOpacity(0.9),
                      textColor: AppColors.primaryColor,
                      widget:
                      isLoading
                          ? CupertinoActivityIndicator(
                        color: AppColors.primaryColor,
                      )
                          : null,
                      onTap: loginUser,
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomAuthBtn(
                            text: 'Signup',
                            textColor: Colors.white,
                            onTap:
                                () => navigatorReplace(context, SignUpView())
                          ),
                        ),
                        const Gap(15),
                        Expanded(
                          child: CustomAuthBtn(
                            text: 'Guest',
                            isIcon: true,
                            textColor: Colors.white,
                            onTap:
                                () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Root()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}