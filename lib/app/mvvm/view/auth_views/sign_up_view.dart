import 'package:flutter/material.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_fire_chat/app/custom_widgets/image_picker/image_picker.dart';
import 'package:flutter_fire_chat/app/custom_widgets/jump_custom_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          ReusableImagePicker(containerSize: 120.sp, onImageSelected: (image){}),
          20.h.height,
          CustomField(
            hintText: 'Enter name',
            labelTitle: 'Name',
          ),
          10.h.height,
          CustomField(
            hintText: 'Enter email',
            labelTitle: 'Email',
          ),
          10.h.height,
          CustomField(
            hintText: 'Enter password',
            labelTitle: 'Password',
          ),
          10.h.height,
        ],
      ),
    );
  }
}
