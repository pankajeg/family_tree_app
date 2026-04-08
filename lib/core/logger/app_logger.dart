import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static const String _name = 'family_tree_app';
  static const String _ansiReset = '\u001b[0m';
  static const String _ansiRed = '\u001b[31m';

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: _name,
        level: 500,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: _name,
      level: 800,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void warn(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: _name,
      level: 900,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: _name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Prints an API error block with request/response details.
  static void apiError(
    DioException dioError, {
    String? title,
    String? appInfo,
    String? stackLabel,
  }) {
    final request = dioError.requestOptions;
    final response = dioError.response;
    final now = DateTime.now();
    final time =
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    final requestId = request.extra['requestId']?.toString() ?? 'N/A';

    final buffer = StringBuffer()
      ..writeln('API ERROR | $time')
      ..writeln('REQUEST ID: $requestId')
      ..writeln()
      ..writeln('URL: ${request.uri}')
      ..writeln('METHOD: ${request.method}, STATUS Code: ${response?.statusCode ?? 'N/A'}')
      ..writeln()
      ..writeln('RESPONSE:')
      ..writeln(_safeResponseText(response?.data))
      ..writeln()
      ..writeln('MESSAGE: ${title ?? _resolveMessage(dioError)}')
      ..writeln('ERROR: ${dioError.message ?? dioError.error}')
      ..writeln('TYPE: ${dioError.type.name}');

    if (stackLabel != null && stackLabel.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('STACK:');
      buffer.writeln(stackLabel);
    }

    if (appInfo != null && appInfo.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('App info: $appInfo');
    }

    final message = buffer.toString();

    if (kDebugMode) {
      debugPrint('$_ansiRed$message$_ansiReset');
    }

    error(
      message,
      error: dioError,
      stackTrace: dioError.stackTrace,
    );
  }

  static String _resolveMessage(DioException dioError) {
    final data = dioError.response?.data;
    if (data is Map<String, dynamic> && data['message'] != null) {
      return data['message'].toString();
    }

    return dioError.message ?? 'Unknown API error';
  }

  static String _safeResponseText(dynamic data) {
    if (data == null) {
      return 'No response body';
    }

    final text = data.toString();
    if (text.length <= 4000) {
      return text;
    }

    return '${text.substring(0, 4000)}... [truncated]';
  }
}
