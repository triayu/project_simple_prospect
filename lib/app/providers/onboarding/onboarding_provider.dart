import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_example/app/data/models/banner_intro_model.dart';

class CarouselStateNotifier extends StateNotifier<BannerIntroModel> {
  CarouselStateNotifier() : super(BannerIntroModel());

  void setBanner(BannerIntroModel banners) {
    state = banners;
  }

  void setPage(int index) {}

  // void goToNext() {
  //   state++;
  // }

  // void goToPrevious() {
  //   state--;
  // }

  // void setPage(int index) {
  //   state = index;
  // }
}

final carouselStateProvider = StateNotifierProvider<CarouselStateNotifier, BannerIntroModel>((ref) {
  return CarouselStateNotifier();
});
