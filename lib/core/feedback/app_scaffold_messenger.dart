import 'package:flutter/material.dart';

class AppScaffoldMessenger {
  AppScaffoldMessenger._();

  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static ScaffoldMessengerState? get _state => messengerKey.currentState;

  static void showInfo(String message) {
    _show(
      message,
      backgroundColor: const Color(0xFF2563EB),
    );
  }

  static void showSuccess(String message) {
    _show(
      message,
      backgroundColor: const Color(0xFF16A34A),
    );
  }

  static void showError(String message) {
    _show(
      message,
      backgroundColor: const Color(0xFFDC2626),
    );
  }

  static void hideCurrent() {
    _state?.hideCurrentSnackBar();
  }

  static void clearAll() {
    _state?.clearSnackBars();
  }

  static void _show(
    String message, {
    required Color backgroundColor,
  }) {
    if (_state == null) {
      return;
    }

    _state!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
