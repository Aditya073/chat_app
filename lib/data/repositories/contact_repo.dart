import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/data/services/base_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactRepo extends BaseRepositories {
  // to get the Uid of current user from firebase
  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<bool> requireContactPermission() async {
    return await FlutterContacts.requestPermission();
  }

  Future<List<Map<String, dynamic>>> getRegristeredContacts() async {
    try {
      // get all the devices contact Phone Number
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      print(contacts);

      // extract PhoneNumber and normalize them
      final phoneNumbers = contacts
          .where((contact) => contact.phones.isNotEmpty)
          .map(
            (contact) => {
              'name': contact.displayName,
              'phoneNumber': contact.phones.first.number.replaceAll(
                RegExp(r'[^\d+]'),
                '',
              ),
              'photo': contact.photo, // Store contact photo if available
            },
          )
          .toList();
      print(phoneNumbers);

      // get all users from firebase
      final userSnapShot = await firestore.collection('users').get();
      print(userSnapShot);

      final registeredUsers = userSnapShot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();

      // Match contact with registered User

      final matchContacts = phoneNumbers
          .where((contact) {
            final phoneNumber = contact['phoneNumber'];
            return registeredUsers.any(
              (user) =>
                  user.phoneNumber == phoneNumber && user.uid != currentUserId,
            );
          })
          .map((contact) {
            final registeredUser = registeredUsers.firstWhere(
              (User) => User.phoneNumber == contact['phoneNumber'],
            );

            return {
              'id': registeredUser.uid,
              'name': contact['name'],
              'phoneNumber': contact['phoneNumber'],
            };
          })
          .toList();

      print(matchContacts);
      return matchContacts;
    } catch (e) {
      return [];
    }
  }
}
