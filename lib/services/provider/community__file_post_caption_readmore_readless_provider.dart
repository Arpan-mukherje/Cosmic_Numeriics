import 'package:flutter/material.dart';

class CommynityFilePostCaptionReadmoreReadless extends ChangeNotifier {
  bool _showFullTextForFilePost = true;
  bool get showFullTextForFilePost => _showFullTextForFilePost;

  void fileCommynityPostCaption(bool captiomSize) {
    _showFullTextForFilePost = captiomSize;
    notifyListeners();
  }
}
