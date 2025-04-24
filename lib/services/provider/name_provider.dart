import 'package:flutter/cupertino.dart';

class NameChange extends ChangeNotifier {
  bool _name = false;
  bool get namechange => _name;

  List<Widget> _cardsList = [];
  List<Widget> get cardsList => _cardsList;

  bool _showContainer = false;
  bool get showContainer => _showContainer;

  void namec(bool n) {
    _name = n;
    notifyListeners();
  }

  void updateCardsList(List<Widget> newList) {
    _cardsList = newList;
    notifyListeners();
  }

  void updateShowContainer(bool value) {
    _showContainer = value;
    notifyListeners();
  }
}
