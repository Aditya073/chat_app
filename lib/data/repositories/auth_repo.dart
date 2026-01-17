import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/data/services/base_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo extends BaseRepositories {
  late final user;

  Future<UserModel> signUp({
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
        throw "Failed to create user";
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
        throw "User already exists";
      }
    } catch (e) {
      print(e.toString());
    }
    return user; // and we return the usermodel from this function
  }

  Future<UserModel> signIn({required String email, required String password}) async {

    // using a firebase method to verify the email and password
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    try {
      final doc = await firestore.collection("users").doc(userCredential.user!.uid).get();
      if (!doc.exists) {
        throw "User does not exists";
      }
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw "Failed to create user";
    }
    
  }
}
