import 'dart:developer';

import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/data/services/base_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo extends BaseRepositories {
  late final user;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  signUp({
    required String fullName,
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      // this creates the user based on the email and password
      final createUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (createUser.user == null) {
        return "Failed to create user";
      }

      // the user model is created so we can send this to the firestore database
      user = UserModel(
        uid: createUser.user!.uid,
        userName: userName,
        fullName: fullName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      try {
        // this adds the user info on firebase
        await firestore.collection("users").doc(user.uid).set(user.toMap());
      } catch (e) {
        return "User already exists";
      }
    } catch (e) {
      print(e.toString());
    }
    return user; // and we return the usermodel from this function
  }

  signIn({required String email, required String password}) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        return "User not found";
      }
      final userData = await getUserData(userCredential.user!.uid);
      return userData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserModel> getUserData(String uid) async {
    try {
      final doc = await firestore.collection("users").doc(uid).get();

      if (!doc.exists) {
        throw Exception("User data not found in Firestore");
      }

      log("User document fetched: ${doc.id}");
      return UserModel.fromFirestore(doc);
    } catch (e, stackTrace) {
      log("Firestore error: $e");
      log("Stacktrace: $stackTrace");
      rethrow;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
