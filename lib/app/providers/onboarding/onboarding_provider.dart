import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

final appIntroNotifier = ChangeNotifierProvider((ref) => AppIntroNotifier());

class AppIntroNotifier with ChangeNotifier {
  int index = 0;
  CarouselController carouselController = CarouselController();

  void onChange(int value) {
    index = value;
    notifyListeners();
  }
}
