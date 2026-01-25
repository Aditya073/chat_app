import 'package:chat_app/data/models/chat_room_model.dart';
import 'package:chat_app/data/services/base_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepo extends BaseRepositories {
  CollectionReference get _chatRooms => firestore.collection("chatRooms");

  Future<ChatRoomModel> getOrCreateChatRoom(
    String currentUserId,
    String otherUserId,
  ) async {
    final users = [currentUserId, otherUserId]
      ..sort(); // this will give the same documentname for both the users
    final roomId = users.join('_');

    final roomDoc = await _chatRooms.doc(roomId).get();

    if (roomDoc.exists) {
      // give the SnapShot to the "ChatRoomModel"
      return ChatRoomModel.fromFirestore(roomDoc);
    }

    final currentUserData = // this will get the data of the particular user from "firestore.collection('users')"
        (await firestore.collection('users').doc(currentUserId).get()).data()
            as Map<String, dynamic>;

    final otherUserData = // this will get the data of the particular user from "firestore.collection('users')"
        (await firestore.collection('users').doc(otherUserId).get()).data()
            as Map<String, dynamic>;

    final participantsName = {
      currentUserId: currentUserData['Fullname']?.toString() ?? "",
      otherUserId: otherUserData['Fullname']?.toString() ?? "",
    };

    final newRoom = ChatRoomModel(
      id: roomId,
      participants: users,
      participantsName: participantsName,
      lastReadTime: {
        currentUserId: Timestamp.now(),
        otherUserId: Timestamp.now(),
      },
    );

    await _chatRooms.doc(roomId).set(newRoom.toMap());

    return newRoom;
  }
}
