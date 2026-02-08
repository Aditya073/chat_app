import 'dart:async';
import 'package:chat_app/data/repositories/chat_repo.dart';
import 'package:chat_app/logic/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo _chatRepository;
  final String currentUserId;
  bool _isOnline = false;

  StreamSubscription? _messagesSubscription;

  ChatCubit({required ChatRepo chatRepository, required this.currentUserId})
    : _chatRepository = chatRepository,
      super(ChatState());

  Future<void> enterChat(String receiverId) async {
    emit(state.copyWith(status: ChatStatus.loding));
    _isOnline = true;
    print("_____________________________________isOnline");
    print(_isOnline);

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
      _subscribeToMessages(chatRoom.id!);
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
    try {
      String chatRoomId = state.chatRoomId ?? '';

      // If chatRoomId doesn't exist, create it
      if (chatRoomId.isEmpty) {
        print("____________ creating chatRoom");

        final chatRoom = await _chatRepository.getOrCreateChatRoom(
          currentUserId,
          receiverId,
        );

        chatRoomId = chatRoom.id!;

        emit(
          state.copyWith(
            chatRoomId: chatRoomId,
            receiverId: receiverId,
            status: ChatStatus.loaded,
          ),
        );

        // Start listening immediately
        _subscribeToMessages(chatRoomId);
      }

      print("____________________sending message to:");
      print(chatRoomId);

      await _chatRepository.sendMessage(
        chatRoomId: chatRoomId,
        senderId: currentUserId,
        receiverId: receiverId,
        content: content,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ChatStatus.error,
          error: "Failed to send message: $e",
        ),
      );
      rethrow;
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
            emit(
              state.copyWith(
                messages: messages,
                status: ChatStatus.loaded,
                error: null,
              ),
            );

            if (_isOnline) {
              _readTheUnreadMessages(chatRoomId);
            }
          },
          onError: (error) {
            emit(
              state.copyWith(
                error: "Failed to load messages",
                status: ChatStatus.error,
              ),
            );
          },
        );
  }

  Future<void> _readTheUnreadMessages(String chatRoomId) async {
    try {
      print("________________ in cubit _readTheUnreadMessages");
      await _chatRepository.readTheUnreadMessages(chatRoomId, currentUserId);
    } catch (e) {
      throw ("error marking messages as read $e");
    }
  }
}
