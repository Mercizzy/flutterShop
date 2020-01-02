import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int count = 0;
  // int get getcount=> _count;

  void increment() {
    count++;
    notifyListeners();
  }

  void setCount(int length) {
    count = length;
    notifyListeners();
  }
}