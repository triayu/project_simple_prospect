import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/banner_intro_model.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';

import '../../data/api/api.dart';

class BannerIntroModelProvider extends StateNotifier<AsyncValue<List<BannerIntroModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref; // if you want to use ref inside this provider

  BannerIntroModelProvider({this.ref}) : super(const AsyncValue.loading()) {
    getIntro();
  }

  Future getIntro() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await goalApi.getGoal();
      // if (res.status) {
      //   List data = res.data ?? [];
      //   logg(res.data);

      //   state = AsyncValue.data(data.map((e) => BannerIntroModel.fromJson(e)).toList());
      // } else {
      //   LzToast.show(res.message);
      // }

      List data = res.data ?? [];
      logg(res.data);

      state = AsyncValue.data(data.map((e) => BannerIntroModel.fromJson(e)).toList());
    } catch (e, s) {
      Errors.check(e, s);
      state = const AsyncValue.data([]);
    }
  }
}

final introProvider =
    StateNotifierProvider.autoDispose<BannerIntroModelProvider, AsyncValue<List<BannerIntroModel>>>((ref) {
  ref.onDispose(() {
    logg('--- introProvider disposed');
  });

  return BannerIntroModelProvider(ref: ref);
});
