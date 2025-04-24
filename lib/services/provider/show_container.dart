import 'package:flutter/cupertino.dart';

class ShowContainer extends ChangeNotifier {
  bool _showContainer = false;
  bool get showContainer => _showContainer;

  void setShowContainer(bool show) {
    _showContainer = show;
    notifyListeners();
  }
}
