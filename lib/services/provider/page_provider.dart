// ignore: file_names
import 'package:flutter/material.dart';

class PageChange extends ChangeNotifier {
  int _i = 0;
  int get ind => _i;
  page(int index) {
    _i = index;
    notifyListeners();
  }

  bool _isVisible = true;

  bool get isVisible => _isVisible;

  void show() {
    _isVisible = true;
    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    notifyListeners();
  }
}
