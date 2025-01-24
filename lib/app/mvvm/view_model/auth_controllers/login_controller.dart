import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fire_chat/app/services/firebase_service.dart';
import 'package:get/get.dart';

import '../../../repository/chat_repo/chat_repo.dart';
import '../../../services/shared_preferences_helper.dart';
import '../../model/firebase_user_profile_model/firebase_user_model.dart';

class LoginController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool loginLoader = false.obs ;

  FirebaseService firebaseService =  FirebaseService();


  Future<bool> login()async {

    loginLoader.value = true ;
    try {
      UserCredential userCredential = await firebaseService.loginUser(emailController.text, passwordController.text);
      FireBaseUserModel? userModel = await  ChatRepo.getFireBaseUsersIdOneTime(userCredential.user!.uid);

      if(userModel !=  null){
        SharedPreferencesService.saveUserData(userModel);
      }
      loginLoader.value = false ;

      return true;
    } catch (e) {
      loginLoader.value = false ;

      debugPrint('Error in signup $e');
      return false;

    }
  }

}