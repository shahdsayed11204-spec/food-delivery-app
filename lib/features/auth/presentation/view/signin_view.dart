import 'dart:math';

import 'package:Hungry_App/features/auth/data/repository/auth_reposi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/api_colors.dart';
import '../../../../core/network/api_error.dart';
import '../../../../root.dart';
import '../../../../shared/custom_text/coustom_taxt.dart';
import '../../../../shared/custom_text/custom_bottom.dart';
import '../../../../shared/custom_text/custom_snackbar.dart';
import '../../../../shared/custom_text/custom_textformfiled.dart';
import '../../../../shared/custom_text/glass_container.dart';

import '../widgets/Custom_auth_btn.dart';
import 'login_view.dart';


class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthRepo authRepo = AuthRepo();

  Future<void> signup () async {
    if(formkey.currentState!.validate()) {
      try {
        setState(() => isLoading = true);
        final user = await authRepo.signup(name.text.trim(), email.text.trim(), password.text.trim());
        if(user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (c) => Root()));
        }
        setState(() => isLoading = false);

      } catch (e) {
        setState(() => isLoading = false);
        String errMsg = 'Error in Register';
        if(e is ApiError) {
          errMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnack( errorMsg: errMsg));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: glassContainer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(140),
                    SvgPicture.asset('assets/logo/logo.svg' , color: Colors.white70),
                    Gap(10),
                    Center(child: CustomText(text: 'Welcome to our Food App' , color: Colors.white70)),
                    Gap(40),
                    Column(
                      children: [
                        Gap(30),
                        CustomTextformfiled(
                          controller: name,
                          hint: 'Name',
                          isPassword: false,
                        ),
                        Gap(8),
                        CustomTextformfiled(
                          controller: email,
                          hint: 'Email Address',
                          isPassword: false,
                        ),
                        Gap(8),
                        CustomTextformfiled(
                          controller: password,
                          hint: 'Password',
                          isPassword: true,
                        ),
                        Gap(20),

                        /// Sign up
                        CustomButton(
                          height: 45,
                          gap: 10,
                          widget: isLoading ? CupertinoActivityIndicator(color: AppColors.primaryColor,) : null,
                          color: Colors.white,
                          textColor: AppColors.primaryColor,
                          text: 'Sign up',
                          onTap: signup,
                        ),

                        Gap(20),
                        Row(
                          children: [
                            ///  Login
                            Expanded(
                              child:   CustomAuthBtn(
                                color: Colors.transparent,
                                textColor: Colors.white,
                                text: 'Login',
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
                                    return LoginView();
                                  }));
                                },
                              ),
                            ),
                            Gap(15),
                            /// Guest
                            Expanded(
                              child: CustomAuthBtn(
                                color: Colors.transparent,
                                textColor: Colors.white,
                                text: 'Guest',
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) {
                                      return Root();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(240),
                    CustomText(text: '@RichSonic2025', color: Colors.white, size: 12, font: FontWeight.bold),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
