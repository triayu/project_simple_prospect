import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeNotifier());

class HomeNotifier with ChangeNotifier {
  int activeIndex = 0;

  void setNavigation(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
