// import 'dart:developer';

// import 'package:chat_app/Pages/home.dart';
// import 'package:chat_app/data/models/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthRepositorie {

//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   // SignUp method
//   Future<UserModel> signUp({
//     required String fullName,
//     required String userName,
//     required String email,
//     required String phoneNumber,
//     required String password,
//   }) async {
//     try {
//       final UserCredential = await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (UserCredential.user == null) {
//         throw "Failed to create user";
//       }
//       final user = UserModel(
//         uid: UserCredential.user!.uid,
//         userName: userName,
//         fullName: fullName,
//         email: email,
//         phoneNumber: phoneNumber,
//       );

//       await saveUserData(user);

//       // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
//       return user;
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }

//   Future<void> saveUserData(UserModel user) async {
//     try {
//       firestore.collection("users").doc(user.uid).set(user.toMap());
//     } catch (e) {
//       throw "Failed to create user";
//     }
//   }

//   // SignIn method
//   Future<void> signIn({required String email, required String password}) async {
//     try {
//       final UserCredential = await auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (UserCredential.user == null) {
//         throw "User not found";
//       }
//       final userData = await getUserData(UserCredential.user!.uid);

//       print(userData.fullName);
//       print(userData.userName);
//       print(userData.email);
//       print(userData.phoneNumber);
//       print(userData.uid);
//       print(userData.uid);
//       print(userData.lastSeen);
//       print(userData.createdAt);

//       // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }

//   Future<UserModel> getUserData(String uid) async {
//     try {
//       final doc = await firestore.collection("users").doc(uid).get();
//       if (!doc.exists) {
//         throw "User does not exists";
//       }
//       return UserModel.fromFirestore(doc);
//     } catch (e) {
//       throw "Failed to create user";
//     }
//   }
// }

// // @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }
// // }
