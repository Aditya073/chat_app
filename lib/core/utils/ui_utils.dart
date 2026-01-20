import 'package:flutter/material.dart';

class UiUtils {
  static void showSnackBarr(
    BuildContext context, {
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      backgroundColor: isError ? Colors.red : Colors.greenAccent ,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16),
      duration: duration,
      )
    );
  }
}
