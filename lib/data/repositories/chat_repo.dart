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
      currentUserId: currentUserData['fullName']?.toString() ?? "",
      otherUserId: otherUserData['fullName']?.toString() ?? "",
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
    ).orderBy('timestamp', descending: true).limit(20);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots().map(
      (snapshot) => snapshot.docs.map(ChatMessage.fromFirestore).toList(),
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

  // To display chatRoom on users home screen
  Stream<List<ChatRoomModel>> getChatRoom(String userId) {
    // from "chatRoom" ---> search through "partcapents" ---> if "userId" is present  ---> and sort based on "lastmessageTime"

    return _chatRooms
        .where('participants', arrayContains: userId)
        .orderBy("lastMessageTime", descending: true)
        .snapshots()
        .map(
          (snapshort) => snapshort.docs
              .map((doc) => ChatRoomModel.fromFirestore(doc))
              .toList(),
        );
  }

  // Gets the count of unread message
  Stream<int> getUnreadCount(String chatRoomId, String userId) {
    return getchatRoomMessage(
          chatRoomId,
        ) // "getchatRoomMessage" will get the 'message' collection
        .where("receiverId", isEqualTo: userId)
        .where("status", isEqualTo: MessageStatus.sent.toString())
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // unRead Messages => the receiver has not seen the message
  Future<void> readTheUnreadMessages(
    String chatRoomId,
    String userId, // the sender
  ) async {
    try {
      final batch = firestore.batch();

      // get the unRead messages where user is the receiver
      final unReadMessages =
          await getchatRoomMessage(
                chatRoomId,
              ) // "getchatRoomMessage" will get the 'message' collection inside ChatRoom
              .where("receiverId", isEqualTo: userId)
              .where("status", isEqualTo: MessageStatus.sent.toString())
              .get();

      print("Found ${unReadMessages.docs.length} unread Messages");

      // mark these unread messages as read by the receiver
      for (var doc in unReadMessages.docs) {
        batch.update(doc.reference, {
          "readBy": FieldValue.arrayUnion([
            userId,
          ]), // make it read by the receiver
          "status": MessageStatus.read.toString(), // update the message Status
        });
      }

      // imp to commit the changes
      await batch.commit();
    } catch (e) {
      throw "Error :- ${e.toString()}";
    }
  }

  Stream<Map<String, dynamic>> getUsersOnlineStatus(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map((
      snapshot,
    ) {
      final data = snapshot.data();
      print("________________________ data in chatRepo.\"getUsersOnlineStatus\"");
      print(data.toString());
      return {
        'isOnline': data?['isOnline'] ?? false,
        'lastSeen': data?['lastSeen'],
      };
    });
  }

  Stream<Map<String, dynamic>> getUsersTypingStatus(String chatRoomId) {
    return _chatRooms.doc('chatRooms').snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return {'isTyping': false, 'isTypingUserId': null};
      }
      final data = snapshot.data() as Map<String, dynamic>;

      print("________________________ data in \"getUsersTypingStatus\"");
      print(data.toString());
      return {
        'isTyping': data['isTyping'] ?? false,
        'isTypingUserId': data['isTypingUserId'],
      };
    });
  }

  Future<void> updateOnlineStats(String userId, bool isOnline) async {
    return await firestore.collection('usres').doc(userId).update({
      'isOnline': isOnline,
      'lastSeen': Timestamp.now(),
    });
  }
}
