import 'package:chat_app/data/models/chat_message.dart';
import 'package:chat_app/data/repositories/chat_repo.dart';
import 'package:chat_app/logic/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo _chatRepository;
  final String currentUserId;

  ChatCubit({required ChatRepo chatRepository, required this.currentUserId})
    : _chatRepository = chatRepository,
      super(ChatState());

  Future<void> enterChat(String receiverId) async {
    emit(state.copyWith(status: ChatStatus.loding));

    try {
      print("_______________________ here in chatCubit to create a chatRoom");
      final chatRoom = await _chatRepository.getOrCreateChatRoom(
        currentUserId,
        receiverId,
      );
      print("_______________________ the chatRoom was created");

      emit(
        state.copyWith(
          chatRoomId: chatRoom.id,
          receiverId: receiverId,
          status: ChatStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ChatStatus.error,
          error: "Failed to create the room $e",
        ),
      );
    }
  }

  Future<void> sendMessage({
    required String content,
    required String receiverId,
  }) async {
    if (state.chatRoomId == null) {
      return;
    }
    try {
      print("___________________________________________state.chatRoomId");
      print(state.chatRoomId);
      await _chatRepository.sendMessage(
        chatRoomId: state.chatRoomId!,
        senderId: currentUserId,
        receiverId: receiverId,
        content: content,
      );
    } catch (e) {
      emit(state.copyWith(error: "Failed to send the message $e"));
    }
  }
}
