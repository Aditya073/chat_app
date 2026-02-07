import 'package:chat_app/data/models/chat_room_model.dart';
import 'package:flutter/material.dart';

class ChatRoomDisplay extends StatelessWidget {
  final ChatRoomModel chat;
  final String currentUserId;
  final VoidCallback onTap;
  const ChatRoomDisplay({
    super.key,
    required this.chat,
    required this.currentUserId,
    required this.onTap,
  });

  // String _getOtherUserId() {
  //   final otherUserId = chat.participants.firstWhere(
  //     (id) => id != currentUserId,
  //   );
  //   return chat.participantsName![otherUserId] ?? "unKnown";
  // }
  String _getOtherUserName() {
  try {
    final otherUserId = chat.participants.firstWhere(
      (id) => id != currentUserId,
    );

    final name = chat.participantsName?[otherUserId];

    if (name == null || name.trim().isEmpty) {
      return "Unknown";
    }

    return name;
  } catch (e) {
    return "Unknown";
  }
}


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),

        child: Text(_getOtherUserName()[0].toUpperCase()),
      ),
      title: Text(
        _getOtherUserName(),
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        chat.lastMessage ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: Text('3'),
      ),
    );
  }
}
