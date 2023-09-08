import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/banner_intro_model.dart';

class CarouselState {
  final int id;

  CarouselState(this.id);
}

// final carouselStateProvider = StateNotifierProvider<CarouselNotifier, CarouselState>(
//   (ref) => CarouselNotifier(),
// );

// class CarouselNotifier extends StateNotifier<CarouselState> {
//   CarouselNotifier() : super(CarouselState(0));

//   void setBanner(BannerIntroModel banner) {
//     state = CarouselState(banner.id);
//   }
// }
