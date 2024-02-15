import 'package:flutter/material.dart';

class CycleCounter extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }

  void reset() {
    counter = 0;
  }
}
