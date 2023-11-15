import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';

import 'package:simple_prospect/app/utils/fetch/fetch.dart';

import '../../../data/models/model.dart';

class TutorialProvider extends StateNotifier<AsyncValue<List<TutorialModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref; // if you want to use ref inside this provider

  TutorialProvider(this.ref) : super(const AsyncValue.loading()) {
    getTutorial();
  }

  Future getTutorial() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await tutorialApi.getTutorial();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => TutorialModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }
}

final tutorialProvider = StateNotifierProvider.autoDispose<TutorialProvider, AsyncValue<List<TutorialModel>>>((ref) {
  return TutorialProvider(
    ref,
  );
});
