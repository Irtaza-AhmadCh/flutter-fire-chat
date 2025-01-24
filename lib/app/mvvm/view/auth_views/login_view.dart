import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_chat/app/config/app_text_style.dart';
import 'package:flutter_fire_chat/app/config/padding_extension.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_fire_chat/app/custom_widgets/jump_custom_field.dart';
import 'package:flutter_fire_chat/app/mvvm/view_model/auth_controllers/login_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';
import '../../../custom_widgets/jump_custom_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = LoginController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              children: [
                40.h.h.height,
                Image.asset(AppAssets.logoBlack , scale: 6/1.sp,),
                20.h.height,
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
                      ()=> controller.loginLoader.value ?   const CupertinoActivityIndicator( color: AppColors.primary,)  :CustomButton(title: 'Login', onPressed: () async {

                        bool hasSignUp = await   controller.login();

                    if(hasSignUp ){
                      Get.toNamed(Routes.inboxView);
                    }

                  }).paddingHorizontal(20.w),
                ),
                10.h.height,
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have no account,' ,style: AppTextStyles.customText14(fontWeight:  FontWeight.w400 , color:  AppColors.black) ),
                    GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.signUpView);
                        },
                        child: Text('Sign Up' , style: AppTextStyles.customText14(fontWeight:  FontWeight.w600 , color:  AppColors.primary),)),
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
