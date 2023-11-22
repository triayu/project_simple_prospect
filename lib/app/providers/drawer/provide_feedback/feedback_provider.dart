import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/feedback_model.dart';

import 'package:simple_prospect/app/utils/fetch/fetch.dart';

class FeedbackProvider extends StateNotifier<AsyncValue<List<FeedbackModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  FeedbackProvider(this.ref) : super(const AsyncValue.loading()) {
    getFeedback();
  }

  Future getFeedback() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await feedbackApi.getFeedback();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => FeedbackModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }
}

final feedbackProvider = StateNotifierProvider.autoDispose<FeedbackProvider, AsyncValue<List<FeedbackModel>>>((ref) {
  return FeedbackProvider(
    ref,
  );
});
