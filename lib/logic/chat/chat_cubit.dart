import 'dart:async';
import 'package:chat_app/data/repositories/chat_repo.dart';
import 'package:chat_app/logic/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo _chatRepository;
  final String currentUserId;

  StreamSubscription? _messagesSubscription;

  ChatCubit({required ChatRepo chatRepository, required this.currentUserId})
    : _chatRepository = chatRepository,
      super(ChatState());

  Future<void> enterChat(String receiverId) async {
    emit(state.copyWith(status: ChatStatus.loding));

    try {
      final chatRoom = await _chatRepository.getOrCreateChatRoom(
        currentUserId,
        receiverId,
      );
      // print("_______________________ the chatRoom was created");

      emit(
        state.copyWith(
          chatRoomId: chatRoom.id,
          receiverId: receiverId,
          status: ChatStatus.loaded,
        ),
      );
      print("_________________________subscribeToMessages");
      _subscribeToMessages(chatRoom.id as String);
    } catch (e) {
      emit(
        state.copyWith(
          status: ChatStatus.error,
          error: "Failed to create the room $e",
        ),
      );
    }
  }

  // Send messages method
  Future<void> sendMessage({
    required String content,
    required String receiverId,
  }) async {
    late final chatRoom;
    try {
      if (state.chatRoomId == null) {
        print("____________state.chatRoomId == null");

        // this will get the chatRoomId if it is null
        chatRoom = await _chatRepository.getOrCreateChatRoom(
          currentUserId,
          receiverId,
        );
        emit(
          state.copyWith(
            chatRoomId: chatRoom.id,
            receiverId: receiverId,
            status: ChatStatus.loaded,
          ),
        );
      }

      print("____________________chatRoom.id");
      print(chatRoom.id);
      await _chatRepository.sendMessage(
        chatRoomId: chatRoom.id!,
        senderId: currentUserId,
        receiverId: receiverId,
        content: content,
      );
    } catch (e) {
      emit(state.copyWith(error: "Failed to send the message $e"));
      throw e.toString();
    }
  }

  void _subscribeToMessages(String chatRoomId) {
    _messagesSubscription?.cancel();
    _messagesSubscription = _chatRepository
        .getMessages(chatRoomId)
        .listen(
          (messages) {
            print("_______________________messages");
            print(messages);
            emit(state.copyWith(messages: messages,status: ChatStatus.loaded, error: null));
          },
          onError: (error) {
            emit(
              state.copyWith(
                error: "Failed to send message",
                status: ChatStatus.error,
              ),
            );
          },
        );
  }
}
