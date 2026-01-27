import 'package:equatable/equatable.dart';

enum ChatStatus { inital, loding, loaded, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final String? error;
  final String? receiverId;
  final String? chatRoomId;

  const ChatState({
    this.status = ChatStatus.inital,
    this.error,
    this.receiverId,
    this.chatRoomId,
  });

  ChatState copyWith({String? chatRoomId, ChatStatus? status, String? error, String? receiverId}) {
    return ChatState(
      status: status ?? this.status,
      receiverId: receiverId ?? this.receiverId,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, receiverId, error, chatRoomId];
}
