import 'package:flutter/cupertino.dart';

/// Public enum representing the bottom navigation tabs
enum SelectedTab { home, devices, shop, profile }

class DashBoardProvider with ChangeNotifier {
  /// Default selected tab
  SelectedTab _selectedTab = SelectedTab.home;

  SelectedTab get selectedTab => _selectedTab;

  /// Handle navigation index changes
  void handleIndexChanged(int index) {
    if (index < 0 || index >= SelectedTab.values.length) return;
    _selectedTab = SelectedTab.values[index];
    notifyListeners();
  }
}