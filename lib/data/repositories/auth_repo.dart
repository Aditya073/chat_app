import 'dart:developer';

import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/data/services/base_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo extends BaseRepositories {
  late final user;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  // SignUp Method
  signUp({
    required String fullName,
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final formatePhoneNumber = phoneNumber.replaceAll(
        RegExp(r'\s+'),
        "".trim(),
      );

      final emailExists = await checkEmailExists(email);
      if (emailExists) {
        throw "An account with same email exists";
      }

      final phoneNumberExists = await checkingPhonenumberExists(phoneNumber);
      if (phoneNumberExists) {
        throw "An account with same phone number exists";
      }


      final userNameExists = await checkingUsernameExists(userName);
      if (userNameExists) {
        throw "An account with same username exists";
      }

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
        phoneNumber: formatePhoneNumber,
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

  // SignIn Method

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
    } catch (e) {
      log("Firestore error: $e");
      rethrow;
    }
  }

  // SignOut Method
  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      final query = await firestore
          .collection("users")
          .where("email", isEqualTo: email.trim())
          .get();

      return query.docs.isNotEmpty; // true
    } catch (e) {
      print("Error checking email: $e");
      return false;
    }
  }

  Future<bool> checkingPhonenumberExists(String phoneNumber) async {
    try {
      final formatePhoneNumber = phoneNumber.replaceAll(
        RegExp(r'\s+'),
        "".trim(),
      );
      final quarySnapShort = await firestore
          .collection("users")
          .where("phoneNumber", isEqualTo: formatePhoneNumber)
          .get();
      return quarySnapShort.docs.isNotEmpty; // true
    } catch (e) {
      print('Error while checking email : $e');
      return false;
    }
  }

  Future<bool> checkingUsernameExists(String userName) async {
    try {
      final formateUsername = userName.trim();

      final quarySnapShort = await firestore
          .collection("users")
          .where("userName", isEqualTo: formateUsername)
          .get();
      return quarySnapShort.docs.isNotEmpty; // true
    } catch (e) {
      print('Error while checking UserName : $e');
      return false;
    }
  }
}
