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

  // line bar progress
  double width = 0;
  int duration = 5;
  Timer? timer;

  void startTimer(double screenWidth) {
    timer?.cancel();

    try {
      width = 0;
      if (index >= 2) {
        index = 0;
        carouselController.animateToPage(0);
      }

      timer = Timer.periodic(150.ms, (timer) {
        width = (duration * 1000) / screenWidth * timer.tick;
        notifyListeners();

        if (width >= (screenWidth + 20)) {
          carouselController.nextPage();

          timer.cancel();
          startTimer(screenWidth);
        }

        logg(width);
      });
    } catch (e) {
      logg(e);
    }
  }

  void onDispose() {
    timer?.cancel();
    timer = null;
    dispose();
  }
}
