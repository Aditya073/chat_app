import 'package:chat_app/data/repositories/chat_repo.dart';
import 'package:flutter/material.dart';

class AppLifeCycleObserver extends WidgetsBindingObserver {
  final String userId;
  final ChatRepo chatRepo;

  AppLifeCycleObserver({required this.userId, required this.chatRepo});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        chatRepo.updateOnlineStats(userId, false);
        break;

      case AppLifecycleState.resumed:
        chatRepo.updateOnlineStats(userId, true);

      default:
        break;
    }
  }
}
