import 'dart:developer';

import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/data/services/base_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo extends BaseRepositories {
  Future<UserModel> signUp({
    required String fullName,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final UserCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (UserCredential.user == null) {
        throw "Failed to create user";
      }
      final user = UserModel(
        uid: UserCredential.user!.uid,
        userName: userName,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
      );

      await saveUserData(user);
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> saveUserData(UserModel user) async {
    try {
      firestore.collection("users").doc(user.uid).set(user.toMap());
    } catch (e) {
      throw "Failed to create user";
    }
  }
}
