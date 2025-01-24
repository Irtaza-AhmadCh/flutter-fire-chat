import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_fire_chat/app/config/app_colors.dart';
import 'package:flutter_fire_chat/app/config/padding_extension.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_fire_chat/app/custom_widgets/custom_cached_image.dart';
import 'package:flutter_fire_chat/app/custom_widgets/image_picker/image_picker.dart';
import 'package:flutter_fire_chat/app/custom_widgets/jump_custom_button.dart';
import 'package:flutter_fire_chat/app/custom_widgets/jump_custom_field.dart';
import 'package:flutter_fire_chat/app/mvvm/view_model/auth_controllers/signup_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_routes.dart';
import '../../../config/app_text_style.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  PageController pageController = PageController( viewportFraction: 0.8);
  final SignupController controller = SignupController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              children: [
                kToolbarHeight.h.height,
               Container(
                 height: 200.h,
                 child: PageView.builder(
                   controller: pageController ,
                     scrollDirection: Axis.horizontal,
                   physics: BouncingScrollPhysics(),
                   itemCount: controller.imageAvatars.length,

                        itemBuilder:  ( context, index) {
                      return Obx(
                          ()=> GestureDetector(
                          onTap: (){
                            controller.selectedAvatar.value =  controller.imageAvatars[index];
                            print(controller.selectedAvatar.value) ;
                          },
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                  border:( controller.selectedAvatar.value ==controller.imageAvatars[index]  )?   Border.all(color: AppColors.primary ,width: 2.sp) : null ),
                                child: CustomCachedImage(height: 160.sp, width: 160.sp,
                                    imageUrl: controller.imageAvatars[index] , borderRadius: 4000.sp).paddingHorizontal(10.w)),
                          ),
                        ),
                      );
                    }),
               ),
                20.h.height,
                 CustomField(
                  controller:controller.nameController,
                  hintText: 'Enter name',
                  labelTitle: 'Name',
                ),
                10.h.height,
                 CustomField(
                  controller: controller.emailController,
                  hintText: 'Enter email',
                  labelTitle: 'Email',
                ),
                10.h.height,
                 CustomField(
                  controller: controller.passwordController,
                  hintText: 'Enter password',
                  labelTitle: 'Password',
                ),
                10.h.height,
                const Spacer(),
                Obx(
                    ()=> controller.signupLoader.value ?  CupertinoActivityIndicator() :CustomButton(title: 'Signup', onPressed: () async {
                  bool hasSignUp = await   controller.signUp();
                  if(hasSignUp ){
                    Get.toNamed(Routes.inboxView);
                  }

                  }).paddingHorizontal(20.w),
                ),
                10.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have a account,' ,style: AppTextStyles.customText14(fontWeight:  FontWeight.w400 , color:  AppColors.black) ),
                    GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.loginView);
                        },
                        child: Text('Login' , style: AppTextStyles.customText14(fontWeight:  FontWeight.w600 , color:  AppColors.primary),)),
                  ],
                ),
                30.h.height,
              ],
            ).paddingHorizontal(20.w),
          ),
        ),
      ),
    );
  }
}
