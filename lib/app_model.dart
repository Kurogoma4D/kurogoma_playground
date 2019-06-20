import 'package:flutter/material.dart';

class AppStateModel with ChangeNotifier {
  AppStateModel(this._pageIndex);

  int _pageIndex;
  int get pageIndex => _pageIndex;

  setPage(int _index) {
    _pageIndex = _index;
    notifyListeners();
  }

}