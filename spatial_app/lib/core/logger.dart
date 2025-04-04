// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

///Custom logger which can send info logs, errors and warning to firebase Crashlytics
class AppLogger {
  const AppLogger._();

  static final _logger = Logger(
    ///Setting default level
    level: _logLevel(),
    filter: _logFilter(),
    printer: _logPrinter(),
    output: _logOutput(),
  );

  /// Log level to be used with the logger
  static Level _logLevel() {
    if (kReleaseMode) {
      return Level.info;
    }
    return Level.all;
  }

  /// Log filter to be used with the logger
  static LogFilter _logFilter() {
    return ProductionFilter();
  }

  /// Log printer to be used with the logger
  static LogPrinter _logPrinter() {
    if (kReleaseMode) {
      /// this is the log printer crashlytics output
      return CustomPrinter();
    }

    /// this is the log printer for console output
    return PrettyPrinter(methodCount: 0, noBoxingByDefault: true);
  }

  /// Log output to be used with the logger
  static LogOutput _logOutput() {

    ///In debug mode it only prints the data to console
    if(kDebugMode){
      return ConsoleOutput();
    }
    return NoOutput();
  }

  ///[d] is for debugging
  static void d(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  ///[i] for information
  static void i(dynamic message,
      {Object? error, StackTrace? stackTrace}) {
    _logger.log(
         Level.info,
        message.toString(),
        error: error,
        stackTrace: stackTrace);
  }

  ///[w] is for warnings
  static void w(dynamic message,
      {Object? error, StackTrace? stackTrace}) {
    _logger.log(
         Level.warning,
         message.toString(),
        error: error,
        stackTrace: stackTrace);
  }

  ///[e] for error
  static void e(dynamic message,
      {Object? error, StackTrace? stackTrace}) {
    _logger.log(
         Level.error,
         message.toString(),
        error: error,
        stackTrace: stackTrace);
  }


}


///For production use
class NoOutput extends LogOutput {
  @override
  void output(OutputEvent event) {}
}

class CustomPrinter extends PrettyPrinter {
  @override
  List<String> log(LogEvent event) {
    String stackTraceStr = (event.stackTrace ?? StackTrace.current).toString();

    /// for firebase crashlytics we need to pass these three params, therefore passing them in an order in the list
    return [event.message.toString(), event.error.toString(), stackTraceStr];
  }
}
