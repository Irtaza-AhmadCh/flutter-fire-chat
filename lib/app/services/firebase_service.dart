import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire_chat/app/mvvm/model/firebase_user_profile_model/firebase_user_model.dart';


class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  //user auth
  Future<UserCredential> createUser(String email, String password) async {
    return await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> deleteUser(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
      return true; // Indicate success
    } catch (e) {
      print("Error deleting user: $e");
      return false; // Indicate failure
    }
  }
  Future<UserCredential> loginUser(String email, String password) async {
    return await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> addUserToFirestore(FireBaseUserModel userModel) async {
    await firestore.collection('users').doc(userModel.userAppId).set(userModel.toJson());
  }

  Future<DocumentSnapshot> getUserFromFirestore(String userId) async {
    return await firestore.collection('users').doc(userId).get();
  }

  Future<List<DocumentSnapshot>> getAllUsersFromFirestore() async {
    final querySnapshot = await firestore.collection('users').get();
    return querySnapshot.docs;
  }
}
