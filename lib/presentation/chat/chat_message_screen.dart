import 'package:chat_app/data/models/chat_message.dart';
import 'package:chat_app/data/repositories/chat_repo.dart';
import 'package:chat_app/logic/chat/chat_cubit.dart';
import 'package:chat_app/logic/chat/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessageScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  const ChatMessageScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final TextEditingController message = TextEditingController();

  late final ChatCubit _chatCubit;

  @override
  void initState() {
    super.initState();
    print('__________________ here in initState');

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // handle error
      print('_________________user is null');
      return;
    }
    print(user);

    print('__________________ user is not null');

    _chatCubit = ChatCubit(chatRepository: ChatRepo(), currentUserId: user.uid);
    _chatCubit.enterChat(widget.receiverId);
  }

  Future<void> handleSendingMessage() async {

      final contentMessage = message.text.trim();
      message.clear();

      print("_____________________contentMessage");
      print(contentMessage);

      await _chatCubit.sendMessage(
        content: contentMessage,
        receiverId: widget.receiverId,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Text(widget.receiverName[0]),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiverName,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text(
                  'last seen at (time)',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return MessageBubble(
                  isMe: true,
                  message: ChatMessage(
                    id: "id",
                    chatRoomId: "chatRoomId",
                    senderId: "senderId",
                    receiverId: "receiverId",
                    content: "Hello World",
                    status: MessageStatus.read,
                    timestamp: Timestamp.now(),
                    readBy: [],
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.emoji_emotions,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: message,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).canvasColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        filled: true,
                        hint: Text(
                          'Type a message',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      handleSendingMessage();
                      // ChatRepo().sendMessage(
                      //   chatRoomId: chatRoomId,
                      //   senderId: senderId,
                      //   receiverId: receiverId,
                      //   content: message.text.trim(),
                      // );
                    },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  const MessageBubble({super.key, required this.isMe, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe
          ? AlignmentGeometry.centerRight
          : AlignmentGeometry.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isMe
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.1),

          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.zero,
                )
              : BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.only(
          left: isMe ? 64 : 8,
          right: isMe ? 8 : 64,
          bottom: 4,
        ),

        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Text(
                  'Time',
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Icon(
                    message.status == MessageStatus.read
                        ? Icons.done_all
                        : Icons.done,
                    // Icons.done_all,
                    size: 18,
                    color: message.status == MessageStatus.read
                        ? Colors.blueAccent
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
