import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';

final FeedbackPostProvider = AutoDisposeChangeNotifierProvider((ref) => FeedbackPost());

class FeedbackPost with ChangeNotifier, UseApi {
  final forms = LzForm.make(['title', 'feedback_message']);

  Future postFeedback(BuildContext context) async {
    logg('Post data');
    try {
      final validate = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(
            required: {
              'title': 'Title Tidak Boleh Kosong',
              'feedback_message': 'Feedback Message Tidak Boleh Kosong',
            },
          ),
          email: ['email']);
      if (validate.ok) {
        final map = forms.toMap();
        logg(
          map,
        );
        LzToast.overlay('Menambah Feedback ...');
        ResHandler res = await feedbackApi.postFeedback(map);
        LzToast.dismiss();

        if (!res.status) {
          LzToast.show(res.message);
        } else {
          LzToast.show('Berhasil Menambahkan Feedback');
          Navigator.of(context).pop;
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
