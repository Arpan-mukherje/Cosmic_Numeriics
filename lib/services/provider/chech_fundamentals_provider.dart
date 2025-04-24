import 'package:flutter/material.dart';

class CheckFundamentalsProvider extends ChangeNotifier {
  String _result = "";
  String get result => _result;
  void setResult(String res) {
    _result = res;
    notifyListeners();
  }
}
