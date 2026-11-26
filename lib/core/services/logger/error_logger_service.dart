import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter_pos/core/utilities/console_logger.dart';
import 'package:flutter_pos/core/utilities/debug_mode_wrapper.dart';

/// Global error logging service
class ErrorLoggerService {
  final FirebaseCrashlytics _crashlytics;
  final DebugModeWrapper _debugMode;

  ErrorLoggerService(
    this._crashlytics, {
    DebugModeWrapper? debugMode,
  }) : _debugMode = debugMode ?? DebugModeWrapper();

  /// Log error to Firebase Crashlytics
  void log({
    required Object error,
    StackTrace? stackTrace,
    String? title,
    String? message,
    String? state,
  }) {
    // Always log to console in debug mode
    ce(error, title: title, message: message, state: state);

    if (!_debugMode.isDebugMode) {
      unawaited(_crashlytics.recordError(error, stackTrace));
    }
  }
}
