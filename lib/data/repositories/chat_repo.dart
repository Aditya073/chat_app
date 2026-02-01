import 'package:chat_app/data/models/chat_message.dart';
import 'package:chat_app/data/models/chat_room_model.dart';
import 'package:chat_app/data/services/base_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepo extends BaseRepositories {
  CollectionReference get _chatRooms => firestore.collection('chatRooms');

  // this will give u access to the messages of a chatroom
  CollectionReference getchatRoomMessage(String chatRoomId) {
    return _chatRooms.doc(chatRoomId).collection('messages');
  }

  // Enter a chatRoom or create one method
  Future<ChatRoomModel> getOrCreateChatRoom(
    String currentUserId,
    String otherUserId,
  ) async {
    final users = [currentUserId, otherUserId]
      ..sort(); // this will give the same documentname for both the users
    final roomId = users.join('_');

    final roomDoc = await firestore.collection('chatRooms').doc(roomId).get();

    if (roomDoc.exists) {
      // give the SnapShot to the "ChatRoomModel"
      print("__________________________The chatRoom already exists");
      return ChatRoomModel.fromFirestore(roomDoc);
    }

    if (!roomDoc.exists) {
      print("__________________________The chatRoom does not exists");
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

    // if room dosen`t exsists then create it
    final newRoom = ChatRoomModel(
      id: roomId,
      participants: users,
      participantsName: participantsName,
      lastReadTime: {
        currentUserId: Timestamp.now(),
        otherUserId: Timestamp.now(),
      },
    );

    print(
      "__________________________we are creating a chatRoom using (currentUserData) and (otherUserData)",
    );

    await firestore.collection('chatRooms').doc(roomId).set(newRoom.toMap());
    print("_______________________the chatRoom is now created");
    return newRoom;
  }

  // send message method
  Future<void> sendMessage({
    required String chatRoomId,
    required String senderId,
    required String receiverId,
    required String content,
    MessageType type = MessageType.text,
  }) async {
    final batch = firestore.batch();

    final messageRef = getchatRoomMessage(chatRoomId);
    final messageDoc = messageRef.doc();
    print(messageDoc.get());

    final message = ChatMessage(
      id: messageDoc.id,
      chatRoomId: chatRoomId,
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      type: type,
      timestamp: Timestamp.now(),
      readBy: [senderId],
    );

    batch.set(messageDoc, message.toMap());

    batch.update(_chatRooms.doc(chatRoomId), {
      "lastMessage": content,
      "lastMessageSenderId": senderId,
      "lastMessageTime": message.timestamp,
    });

    await batch.commit();
    print("____________________ Users message content");
    print(content);
  }

  // get the above messages

  Stream<List<ChatMessage>> getMessages(
    String chatroomId, {
    DocumentSnapshot? lastDocument,
  }) {
    var query = getchatRoomMessage(
      chatroomId,
    ).orderBy('timeStamp', descending: true).limit(20);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots().map(
      (snapshort) =>
          snapshort.docs.map((doc) => ChatMessage.fromFirestore(doc)).toList(),
    );
  }

  Future<List<ChatMessage>> getMoreMessages(
    String chatroomId, {
    required DocumentSnapshot lastDocument,
  }) async {
    final query = getchatRoomMessage(chatroomId)
        .orderBy('timeStamp', descending: true)
        .startAfterDocument(lastDocument)
        .limit(20);

    final snapshort = await query.get();

    return snapshort.docs.map((doc) => ChatMessage.fromFirestore(doc)).toList();
  }
}
