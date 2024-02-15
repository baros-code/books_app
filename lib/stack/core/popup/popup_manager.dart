import 'package:flutter/material.dart';

abstract class PopupManager {
  Future<void> showSnackBar(
    BuildContext context,
    Widget content, {
    Color? backgroundColor,
  });
}

class PopupManagerImpl implements PopupManager {
  @override
  Future<void> showSnackBar(
    BuildContext context,
    Widget content, {
    Color? backgroundColor,
    Duration displayDuration = const Duration(seconds: 2),
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: backgroundColor,
        duration: displayDuration,
      ),
    );
  }
}
