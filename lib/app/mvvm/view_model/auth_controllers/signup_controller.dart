import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fire_chat/app/mvvm/model/firebase_user_profile_model/firebase_user_model.dart';
import 'package:flutter_fire_chat/app/repository/chat_repo/chat_repo.dart';
import 'package:flutter_fire_chat/app/services/firebase_service.dart';
import 'package:flutter_fire_chat/app/services/shared_preferences_helper.dart';
import 'package:get/get.dart';

class SignupController  extends GetxController {
  RxList<String> imageAvatars =  <String>[
    'https://cdn.pixabay.com/photo/2014/04/02/17/07/user-307993_640.png',
   'https://cdn.pixabay.com/photo/2013/07/12/14/36/man-148582_640.png',
    'https://cdn.pixabay.com/photo/2014/03/25/16/54/user-297566_640.png',
  ].obs;

  RxString selectedAvatar  = ''.obs;
  Rx<File>? file ;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseService firebaseService = FirebaseService();
  RxBool signupLoader = false.obs;

  FireBaseUserModel createUserModel (String userFireID){
    return FireBaseUserModel(
        userEmail: emailController.text,
        role: 'user',
        fireId: DateTime.now().millisecondsSinceEpoch.toString(),
        userAppId:  userFireID,
        userName: nameController.text,
        status: 'online',
        profileImage: selectedAvatar.value
    );
  }


 Future<bool> signUp()async {

    signupLoader.value = true ;
   try {
      UserCredential userCredential = await firebaseService.createUser(emailController.text, passwordController.text);
     FireBaseUserModel userModel = createUserModel(userCredential.user!.uid);
     print("================================= ${userModel.userName}");
      ChatRepo.addUserDataOnFirebase(userDataModel: userModel);

      if(userCredential.user !=  null){
        SharedPreferencesService.saveUserData(userModel);

      }
     signupLoader.value = false ;

      return true;
   } catch (e) {
     signupLoader.value = false ;

     debugPrint('Error in signup $e');
     return false;

   }
 }



}