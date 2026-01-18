import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String userName;
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final bool isOnline;
  final Timestamp lastSeen;
  final Timestamp createdAt;
  final String? fcmToken;
  final List<String> blockedUsers;

  UserModel({
    required this.uid,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.isOnline = false,
    Timestamp? lastSeen,
    Timestamp? createdAt,
    this.fcmToken,
    List<String>? blockedUsers,
  })  : lastSeen = lastSeen ?? Timestamp.now(),
        createdAt = createdAt ?? Timestamp.now(),
        blockedUsers = blockedUsers ?? [];

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: doc.id,
      userName: data["userName"] ?? '',
      fullName: data["fullName"] ?? '',
      email: data["email"] ?? '',
      password: data["password"] ?? '',
      phoneNumber: data["phoneNumber"] ?? '',
      isOnline: data["isOnline"] ?? false,
      lastSeen: data["lastSeen"] ?? Timestamp.now(),
      createdAt: data["createdAt"] ?? Timestamp.now(),

      // ✅ SAFE LIST PARSING (NO MORE CRASH)
      blockedUsers: List<String>.from(data["blockedUsers"] ?? []),

      fcmToken: data["fcmToken"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "userName": userName,
      "fullName": fullName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "isOnline": isOnline,
      "lastSeen": lastSeen,
      "createdAt": createdAt,
      "fcmToken": fcmToken,
      "blockedUsers": blockedUsers,
    };
  }
}
