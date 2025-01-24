import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fire_chat/app/config/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5) , (){
      Get.toNamed(Routes.loginView);

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: AnimatedScale(
              scale: 1,
          duration: const Duration(milliseconds: 600),
          child: Image.asset(AppAssets.logoBlack , scale: 5/1.sp,))),
        ],
      ),
    );
  }
}
