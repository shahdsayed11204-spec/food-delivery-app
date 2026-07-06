import 'dart:io';

import 'package:Hungry_App/core/network/api_error.dart';
import 'package:Hungry_App/features/auth/data/auth_model/user_model.dart';
import 'package:Hungry_App/shared/navigator/navigator_replace.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/api_colors.dart';
import '../../../../shared/custom_text/coustom_taxt.dart';
import '../../../../shared/custom_text/custom_bottom.dart';
import '../../../../shared/custom_text/custom_snackbar.dart';
import '../../data/repository/auth_reposi.dart';
import '../widgets/custom_user_txtfield.dart';
import 'login_view.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final deliverycontroller = TextEditingController();
  final visacontroller = TextEditingController();
  UserModel? _userModel;
  bool isGuest =false;
  AuthRepo authRepost = AuthRepo();

  /// Get Profile data
  Future<void> getProfileData() async {
    try {
      final user = await authRepost.getProfileData();
      // print('USER = $user');
      // print('NAME = ${user?.name}');
      // print('EMAIL = ${user?.email}');
      // print('ADDRESS = ${user?.address}');
      // print('IMAGE = ${user?.image}');
      if (!mounted) return;

      setState(() {
        _userModel = user;

        if (user != null) {
          namecontroller.text = user.name;
          emailcontroller.text = user.email;
          deliverycontroller.text = user.address ?? '';
          visacontroller.text = user.visa ?? '';
        }
      });
    } catch (e) {
      if (!mounted) return;

      String errorMsg = 'Error in Profile';

      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnack(errorMsg: errorMsg));
    }
  }

  /// PickerImage
  String? selectedImage;
  Future<void> pickImage() async {
    final pickImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickImage != null) {
      setState(() {
        selectedImage = pickImage.path;
      });
    }
  }

  /// Update Profile data
  bool isLoading = false;
  Future<void> updateProfileData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final user = await authRepost.updateProfile(
        name: namecontroller.text.trim(),
        email: emailcontroller.text.trim(),
        address: deliverycontroller.text.trim(),
        visa: visacontroller.text.trim(),
        imagepath: selectedImage,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnack(errorMsg: 'Profile Updated Successfully',color: Colors.green.shade300));
      setState(() {
        isLoading = false;
      });
      setState(() {
        _userModel = user;
        selectedImage = null;
      });
      await getProfileData();

    } catch (e) {
      if (!mounted) return;

      String errorMsg = 'Error in Profile';

      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnack(errorMsg: errorMsg));
    }
    finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  /// LogOut
  Future<void> logOut() async {
    final user = await authRepost.logOut();
    navigatorReplace(context, LoginView());
    ScaffoldMessenger.of(context).showSnackBar(
      customSnack(
        errorMsg: 'LogOut Successfully',
        color: Colors.green.shade300,
      ),
    );
  }

  /// AutoLogin
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

  @override
  void initState() {
    autoLogin();
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    if(!isGuest){
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            toolbarHeight: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.grey.shade400,
              onRefresh: getProfileData,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Skeletonizer(
                  enabled: _userModel == null,
                  containersColor: AppColors.primaryColor.withOpacity(0.3),
                  child: Column(
                    children: [
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),
                            child: Icon(CupertinoIcons.settings_solid),
                          ),
                        ],
                      ),

                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.black),
                          color: Colors.grey.shade300,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.primaryColor,
                                ),
                                color: Colors.grey.shade100,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: selectedImage != null
                                  ? Image.file(
                                File(selectedImage!),
                                fit: BoxFit.cover,
                              )
                                  : (_userModel?.image != null &&
                                  _userModel!.image!.isNotEmpty)
                                  ? Image.network(
                                _userModel!.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, builder) =>
                                    Icon(Icons.person_outline_rounded),
                              )
                                  : Icon(Icons.person_outline_rounded),
                            ),
                          ),
                        ),
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: Card(
                              elevation: 0.0,
                              color: const Color.fromARGB(255, 6, 78, 13),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: 'Upload',
                                      font: FontWeight.w500,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                    Gap(10),
                                    Icon(
                                      CupertinoIcons.camera,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: pickImage,
                            child: Card(
                              elevation: 0.0,
                              color: const Color.fromARGB(255, 111, 2, 40),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: 'Remove',
                                      font: FontWeight.w500,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                    Gap(10),
                                    Icon(
                                      CupertinoIcons.trash,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(15),
                      CustomUserTxtfield(
                        label: 'Name',
                        controller: namecontroller,
                        textInputType: TextInputType.name,
                      ),

                      const Gap(20),

                      CustomUserTxtfield(
                        label: 'Email',
                        controller: emailcontroller,
                        textInputType: TextInputType.emailAddress,
                      ),

                      const Gap(20),

                      CustomUserTxtfield(
                        label: 'Address',
                        controller: deliverycontroller,
                        textInputType: TextInputType.streetAddress,
                      ),

                      const Gap(10),
                      const Divider(),
                      const Gap(5),

                      _userModel?.visa == null
                          ? CustomUserTxtfield(
                        label: 'Visa Card',
                        controller: visacontroller,
                        textInputType: TextInputType.number,
                      )
                          : ListTile(
                        onTap: () {},
                        tileColor: const Color(0xff4a4a47),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                        ),
                        leading: Image.asset(
                          'assets/test/Icons2.png',
                          width: 50,
                        ),
                        title: CustomText(
                          text: 'Debit card',
                          size: 13,
                          color: Colors.white,
                        ),
                        subtitle: CustomText(
                          text: _userModel?.visa ?? '3566 **** **** 0505',
                          size: 13,
                          color: Colors.white70,
                        ),
                        trailing: CustomText(
                          text: 'Default',
                          size: 13,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(140), // مساحة للـ bottomSheet
                    ],
                  ),
                ),
              ),
            ),
          ),

          bottomSheet: Container(
            margin: EdgeInsets.only(bottom: 55.0),
            height: 100,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: isLoading ? null : updateProfileData,
                      child: CustomButton(
                        widget: isLoading
                            ? CupertinoActivityIndicator(color: Colors.white)
                            : const SizedBox.shrink(),
                        gap: 10,
                        text: 'Edit Profile',
                        textColor: Colors.white,
                        color: isLoading ? Color(0xff476a47) : AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: GestureDetector(
                      onTap: logOut,
                      child:CustomButton(
                        text: 'Log Out',textColor:AppColors.primaryColor,color: Colors.white,radius: 5,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    else {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline_rounded,
                    size: 70,
                    color: AppColors.primaryColor,
                  ),
                ),

                const Gap(25),

                CustomText(
                  text: 'Welcome Guest 👋',
                  size: 24,
                  font: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),

                const Gap(10),

                CustomText(
                  text:
                  'Create an account to save your orders, manage your profile and enjoy a personalized experience.',
                  size: 14,
                  color: Colors.grey,
                ),

                const Gap(30),

                CustomButton(
                  text: 'Create Account',
                  width: double.infinity,
                  height: 50,
                  radius: 15,
                  onTap: () {
                    navigatorReplace(context, LoginView());
                  },
                ),

                const Gap(12),

                TextButton(
                  onPressed: () {
                    navigatorReplace(context, LoginView());
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
