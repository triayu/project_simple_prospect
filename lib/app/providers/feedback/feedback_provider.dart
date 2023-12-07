import 'package:flutter/material.dart';
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

  final forms = LzForm.make(['title', 'feedback_message', 'rating']);

  Future postFeedback(BuildContext context) async {
    logg('Post data');
    try {
      final validate = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: true,
          notifierType: LzFormNotifier.toast,
          messages: FormMessages(
            required: {
              'title': 'Title Tidak Boleh Kosong',
              'feedback_message': 'Message Tidak Boleh Kosong',
            },
          ),
          email: ['email']);
      if (validate.ok) {
        final map = forms.toMap();
        LzToast.overlay('Menambah Feedback ...');
        ResHandler res = await feedbackApi.postFeedback(map);
        LzToast.dismiss();

        if (!res.status) {
          LzToast.show(res.message);

          Navigator.pop(context);
          await getFeedback();
          forms.reset();
        } else {
          forms.reset();
          LzToast.show('Berhasil Menambahkan Feedback');
          await getFeedback();
          Navigator.pop(context);
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
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

  // Delete Feedback
  // =====================================
  Future delFeedback(int id) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await feedbackApi.deleteFeedback(id);

      if (res.status) {
        LzToast.show(res.message);
        getFeedback();
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final feedbackProvider = StateNotifierProvider.autoDispose<FeedbackProvider, AsyncValue<List<FeedbackModel>>>((ref) {
  return FeedbackProvider(
    ref,
  );
});
