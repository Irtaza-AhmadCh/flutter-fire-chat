import 'dart:io';

import 'package:flutter_fire_chat/app/config/app_colors.dart';
import 'package:flutter_fire_chat/app/config/padding_extension.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_fire_chat/app/custom_widgets/image_picker/image_picker.dart';
import 'package:flutter_fire_chat/app/custom_widgets/jump_custom_button.dart';
import 'package:flutter_fire_chat/app/custom_widgets/jump_custom_field.dart';
import 'package:flutter_fire_chat/app/mvvm/view_model/auth_controllers/signup_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
                ReusableImagePicker(
                    containerSize: 120.sp, onImageSelected: (image){
                      controller.file?.value  = File(image ?? '');

                }),
                20.h.height,
                 CustomField(
                  controller:controller.nameController ,
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
                CustomButton(title: 'Signup', onPressed: (){

                }).paddingHorizontal(20.w),
                20.h.height,
              ],
            ).paddingHorizontal(20.w),
          ),
        ),
      ),
    );
  }
}
