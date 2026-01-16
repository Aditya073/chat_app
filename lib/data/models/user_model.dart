import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String userName;
  final String fullName;
  final String email;
  final String phoneNumber;
  final bool isOnline;
  final Timestamp lastSeen;
  final Timestamp createdAt;
  final String? fcmTocken;
  final List<String> blockedUsers;

  UserModel({
    required this.uid,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.isOnline = false,
    Timestamp? lastSeen,
    Timestamp? createdAt,
    this.fcmTocken,
    this.blockedUsers = const [],
  }) : lastSeen = lastSeen ?? Timestamp.now(),
       createdAt = createdAt ?? Timestamp.now();

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      userName: data["Username"],
      fullName: data["Fullname"],
      email: data["Email"],
      phoneNumber: data["phoneNumber"],
      lastSeen: data["LastSeen"],
      isOnline: data["isOnline"],
      createdAt: data["createdAt"],
      blockedUsers: data["BlockedUsers"],
      fcmTocken: data["fcmTocken"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Uid': uid,
      'Username': userName,
      'Fullname': fullName,
      'Email': userName,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'LastSeen': lastSeen,
      'createdAt': createdAt,
      'fcmTocken': fcmTocken,
      'BlockedUsers': blockedUsers,
    };
  }
}
