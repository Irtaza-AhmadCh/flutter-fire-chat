// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
//
// class FirebaseErrorHandler {
//   // Static method to handle Firebase errors across the app
//   static String handleFirebaseError(dynamic e) {
//     if (e is FirebaseAuthException) {
//       // Handle FirebaseAuthException
//       switch (e.code) {
//         case 'user-not-found':
//         case 'wrong-password':
//           return 'Invalid email or password. Please try again.';
//         case 'user-disabled':
//           return 'This account has been disabled.';
//         case 'too-many-requests':
//           return 'Too many requests. Please try again later.';
//         case 'email-already-in-use':
//           return 'The email address is already in use by another account.';
//         case 'operation-not-allowed':
//           return 'Operation not allowed. Please contact support.';
//         case 'weak-password':
//           return 'The password is too weak. Please choose a stronger password.';
//         case 'invalid-email':
//           return 'The email address is not valid. Please check and try again.';
//         case 'requires-recent-login':
//           return 'Please log in again to perform this action.';
//         default:
//           return 'An authentication error occurred. Please try again later.';
//       }
//     } else if (e is FirebaseFirestoreException) {
//       // Handle Firestore exceptions
//       switch (e.code) {
//         case 'not-found':
//           return 'The requested document was not found.';
//         case 'permission-denied':
//           return 'You do not have permission to perform this action.';
//         case 'resource-exhausted':
//           return 'Quota exhausted. Please try again later.';
//         case 'cancelled':
//           return 'The operation was cancelled.';
//         case 'already-exists':
//           return 'The document already exists.';
//         case 'invalid-argument':
//           return 'An invalid argument was provided. Please check the data and try again.';
//         case 'deadline-exceeded':
//           return 'The operation took too long to complete. Please try again later.';
//         case 'unavailable':
//           return 'The Firestore service is currently unavailable. Please try again later.';
//         case 'aborted':
//           return 'The operation was aborted due to a concurrency issue. Please try again.';
//         default:
//           return 'An error occurred while accessing Firestore. Please try again later.';
//       }
//     } else if (e is FirebaseException) {
//       // General Firebase exceptions (covers other Firebase services)
//       switch (e.code) {
//         case 'unknown':
//           return 'An unknown error occurred. Please try again later.';
//         case 'network-request-failed':
//           return 'Network error. Please check your internet connection.';
//         case 'unauthenticated':
//           return 'You are not authenticated. Please log in again.';
//         case 'internal':
//           return 'An internal error occurred. Please try again later.';
//         case 'data-loss':
//           return 'Data corruption error. Please contact support.';
//         case 'unimplemented':
//           return 'This operation is not supported on the current platform.';
//         case 'failed-precondition':
//           return 'The operation is not allowed in the current state. Please retry.';
//         default:
//           return 'A Firebase error occurred. Please try again later.';
//       }
//     } else if (e is PlatformException) {
//       // Handle non-Firebase platform exceptions
//       return 'An error occurred on the platform: ${e.message}';
//     } else {
//       // Fallback for other exception types
//       return 'An unexpected error occurred. Please try again later.';
//     }
//   }
// }
