import 'package:flutter/material.dart';

class SearchSheetController with ChangeNotifier {
  final List<String> _searchHistory = [];

  List<String> get searchHistory => _searchHistory;

  void addSearchTerm(String term) {
    if (term.trim().isEmpty) return;

    _searchHistory.remove(term);
    _searchHistory.insert(0, term);

    if (_searchHistory.length > 3) {
      _searchHistory.removeLast();
    }

    notifyListeners();
  }

}
