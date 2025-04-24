import 'package:flutter/material.dart';

class ItemStateNotifier extends ChangeNotifier {
  List<bool> isPressList = List.filled(14, false);

  void toggleItemState(int index) {
    isPressList[index] = !isPressList[index];
    notifyListeners();
  }
}
