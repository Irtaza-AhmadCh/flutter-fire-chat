import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController  extends GetxController {
  Rx<File>? file ;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool signupLoader = false.obs;

}