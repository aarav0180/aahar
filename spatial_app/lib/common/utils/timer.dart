import 'dart:async';

///[AppTimer] is useful for creating timers like stopwatch
///or an internal timer when the section expires
///[AppTimer] continue running even if the app is in the background
class AppTimer {
  AppTimer();

  static const _interval = Duration(seconds: 1);

  int _seconds = 0;
  Stream<int>? timeStream;
  StreamSubscription<int>? _timeSub;
  StreamController<int>? _timerController;

  Stream<int> _createTimerStream(int startTime) {
    _seconds = startTime;

    Timer? timer;

    void stopTimer() {
      _timerController?.close();
      timer?.cancel();
    }

    void pauseTimer() {
      timer?.cancel();
      timer = null;
    }

    void tick(_) {
      _timerController?.add(_seconds);
      _seconds--;
      if (_seconds <= 0) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(_interval, tick);
    }

    _timerController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onPause: pauseTimer,
      onResume: startTimer,
    );

    return _timerController!.stream;

  }

  Future<Stream<int>> start({
    required int seconds,
    void Function(int)? onData,
    void Function()? onDone,
  }) async {
    await stop();

    timeStream = _createTimerStream(seconds).asBroadcastStream();

    _timeSub = timeStream!.listen(onData, onDone: onDone);

    return timeStream!;
  }

  Future<void> stop() async {
    await _timeSub?.cancel();
    _timeSub = null;
    timeStream = null;
    await _timerController?.close();
    _timerController = null;
    _seconds = 0;
  }
}
