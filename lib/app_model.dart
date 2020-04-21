import 'package:flutter/material.dart';

class AppStateModel with ChangeNotifier {
  AppStateModel(this._pageIndex);

  int _pageIndex;
  final List<String> _pages = ["HOME", "WIDGETS", "STATE_NOTIFIER"];

  int get pageIndex => _pageIndex;
  List<String> get pages => _pages;
  
  setPage(int _index) {
    _pageIndex = _index;
    notifyListeners();
  }

}