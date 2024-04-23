import 'package:flutter/material.dart';

class Count extends ChangeNotifier {
  int count = 0;

  void countIncremented() {
    count++;
    notifyListeners();
  }
}
