import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';

/// A tool to log messages for different purposes such as debug, crash etc.
abstract class Logger {
  /// Log [message] for debug purposes. Also, [callerType] can be provided
  /// to specify the caller runtime type (class name) in the log header.
  void debug(String message, {Type? callerType});

  /// Log [message] for general purpose. Also, [callerType] can be provided
  /// to specify the caller runtime type (class name) in the log header.
  void info(String message, {Type? callerType});

  /// Log [message] for error cases. Also, [callerType] can be provided
  /// to specify the caller runtime type (class name) in the log header.
  void error(String message, {Type? callerType});

  /// Log [message] for crash cases. Also, [callerType] can be provided
  /// to specify the caller runtime type (class name) in the log header.
  void critical(String message, {Type? callerType});
}

/// Logger Implementation
class LoggerImpl implements Logger {
  @override
  void debug(String message, {Type? callerType}) {
    if (kDebugMode) {
      log(_buildMessageLine('[D]', message, callerType));
    }
  }

  @override
  void info(String message, {Type? callerType}) {
    if (kDebugMode) {
      log(_buildMessageLine('[I]', message, callerType));
    }
  }

  @override
  void error(String message, {Type? callerType}) {
    if (kDebugMode) {
      log(_buildMessageLine('[E]', message, callerType));
    }
  }

  @override
  void critical(String message, {Type? callerType}) {
    if (kDebugMode) {
      log(_buildMessageLine('[C]', message, callerType));
    }
  }

  // Helpers
  String _buildMessageLine(String prefix, String message, Type? callerType) {
    var callerTypeText = '';
    if (callerType != null) callerTypeText = ' [@$callerType]';
    return '[APP] $prefix [${_getDateTime()}]$callerTypeText $message';
  }

  String _getDateTime() {
    return DateFormat('dd.MM.yyyy HH:mm:ss:S').format(DateTime.now().toUtc());
  }
  // - Helpers
}
