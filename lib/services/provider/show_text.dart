import 'package:flutter/foundation.dart';

class ShowText extends ChangeNotifier {
  bool _showText = false;
  bool get showContainer => _showText;

  void setShowEText(bool show) {
    _showText = show;
    notifyListeners();
  }
}
