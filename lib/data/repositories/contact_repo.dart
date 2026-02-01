import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/data/services/base_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactRepo extends BaseRepositories {
  // to get the Uid of current user from firebase
  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? '';

  // Future<bool> requireContactPermission() async {
  //   final granted = await FlutterContacts.requestPermission();
  //   return granted;
  // }

  String normalizePhone(String phone) {
    return phone
        .replaceAll(RegExp(r'[^\d]'), '') // remove +, spaces, -
        .replaceFirst(RegExp(r'^1'), ''); // optional: remove country code : 1
  }

  Future<List<Map<String, dynamic>>> getRegristeredContacts() async {
    try {
      final granted = await FlutterContacts.requestPermission();
      if (!granted) {
        print("Contacts permission denied");
        return [];
      }
      // get all the devices contact Phone Number
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      print(
        '--------------------------------------------Fetching the contacts from the Users mobile',
      );
      print(contacts);

      // extract PhoneNumber and normalize them
      final phoneNumbers = contacts
          .where((contact) => contact.phones.isNotEmpty)
          .map(
            (contact) => {
              'name': contact.displayName,
              'phoneNumber': normalizePhone(
                contact.phones.first.number,
              ), // giving the number to the function to generalize it
              'photo': contact.photo, // Store contact photo if available
            },
          )
          .toList();
      print(
        '--------------------------------------------phoneNumbers in normalizs form',
      );

      print(phoneNumbers);

      // get all users from firebase
      final userSnapShot = await firestore.collection('users').get();
      print('--------------------------------------------userSnapShot');
      print(userSnapShot.docs.first);

      final registeredUsers = userSnapShot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();
      print('-------------------------------------------- registeredUsers');

      for (var user in registeredUsers) {
        // list all the phoneNumbers
        print('Firestore user phone: ${user.phoneNumber}');
      }

      // Match contact with registered User
      // So for contact to display the phone number from 'contacts' should match the phone number from 'firestore database'

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
      print('-------------------------------------------- matchContacts ');

      print(matchContacts);
      return matchContacts;
    } catch (e) {
      return [];
    }
  }
}