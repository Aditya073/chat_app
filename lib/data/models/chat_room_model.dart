import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String? id;
  final List<String> participants;
  final String? lastMessage;
  final String? lastMessageSenderId;
  final Timestamp? lastMessageTime;
  final Map<String, Timestamp>? lastReadTime;
  final Map<String, String>? participantsName;
  final bool isTyping;
  final String? isTypingUserId;
  final bool isCallActive;

  ChatRoomModel({
    required this.id,
    required this.participants,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageSenderId,
    Map<String, Timestamp>? lastReadTime,
    Map<String, String>? participantsName,
    this.isTyping = false,
    this.isTypingUserId,
    this.isCallActive = false,
  })
  :lastReadTime = lastReadTime ?? {},
  participantsName = participantsName ?? {}
  ;
  
  // It’s a named constructor whose job is to convert Firestore data into a ChatRoomModel object safely.
   factory ChatRoomModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;  // this gets the data from firestore
    return ChatRoomModel(
      id: doc.id,
      participants: List<String>.from(
        data['participants'],
      ),
      lastMessage: data['lastMessage'],
      lastMessageSenderId: data['lastMessageSenderId'],
      lastMessageTime: data['lastMessageTime'],
      lastReadTime: Map<String, Timestamp>.from(data['lastReadTime'] ?? {}),
      participantsName: Map<String, String>.from(
        data['participantsName'] ?? {},
      ),
      isTyping: data['isTyping'] ?? false,
      isTypingUserId: data['isTypingUserId'],
      isCallActive: data['isCallActive'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "participants": participants,
      "lastMessage": lastMessage,
      "lastMessageSenderId": lastMessageSenderId,
      "lastReadTime": lastReadTime,
      "lastMessageTime": lastMessageTime,
      "participantsName": participantsName,
      "isTyping": isTyping,
      "isTypingUserId": isTypingUserId,
      "isCallActive": isCallActive,
    };
  }
}
