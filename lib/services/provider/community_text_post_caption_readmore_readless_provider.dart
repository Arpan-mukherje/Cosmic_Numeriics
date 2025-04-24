import 'package:flutter/material.dart';

class CommynityPostCaptionReadmoreReadless extends ChangeNotifier {
  bool _showFullText = true;
  bool get showFullText => _showFullText;

  void textCommynityPostCaption(bool captiomSize) {
    _showFullText = captiomSize;
    notifyListeners();
  }
}
