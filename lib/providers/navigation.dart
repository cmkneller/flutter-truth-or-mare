import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _pageID = 0;

  int get pageID {
    return _pageID;
  }


  void setPageID(int iD) {
    _pageID = iD;
    notifyListeners();
  }
}
