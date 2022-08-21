import 'package:flutter/material.dart';

class PlayerIventory extends ChangeNotifier {
  int _arrowCount = 0;
  int _keyCount = 0;

  int get arrowCount => _arrowCount;
  int get keyCount => _keyCount;

  void incrementArrow({int count = 1}) {
    _arrowCount += count;
    notifyListeners();
  }

  void decrementArrow({int count = 1}) {
    _arrowCount -= count;
    notifyListeners();
  }

  void incrementKey({int count = 1}) {
    _keyCount += count;
    notifyListeners();
  }

  void decrementKey({int count = 1}) {
    _keyCount -= count;
    notifyListeners();
  }
}
