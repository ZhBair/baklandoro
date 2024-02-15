import 'dart:async';

import 'package:flutter/material.dart';

class GeneralTimer extends ChangeNotifier {
  Duration _totalDuration = const Duration();

  bool isRunning = false;
  Duration durationPassed = const Duration();

  void startTimer(Duration totalTimeMillis) {
    if (isRunning) {
      return;
    }
    assert(!totalTimeMillis.isNegative);
    _totalDuration = totalTimeMillis;
    isRunning = true;

    Timer.periodic(const Duration(seconds: 1), _onTimerTick);
  }

  void _onTimerTick(Timer timer) {
    durationPassed = Duration(seconds: timer.tick);
    if (durationPassed.compareTo(_totalDuration) > 0) {
      timer.cancel();
      isRunning = false;
      notifyListeners();
    } else {
      notifyListeners();
    }
  }
}

class WorkTimer extends GeneralTimer {}

class BreakTimer extends GeneralTimer {}
