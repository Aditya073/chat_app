import 'package:flutter/material.dart';

class ChatMessageScreen extends StatefulWidget {
  final String senderId;
  final String receiverId;
  const ChatMessageScreen({super.key, required this.senderId, required this.receiverId});

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //5:17:12
      ),
    );
  }
}
