import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';

import '../../utils/fetch/src/fetch.dart';

final eventPostProvider = AutoDisposeChangeNotifierProvider((ref) => EventPost());

class EventPost with ChangeNotifier, UseApi {
  final forms = LzForm.make(
      ['title', 'meeting_with', 'meeting_type', 'start_date', 'end_date', 'location', 'set_time_reminder', 'note']);

  Future post(BuildContext context) async {
    try {
      final validate = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(
            required: {
              'title': 'Title Tidak Boleh Kosong',
              'meeting_with': 'Meeting With Tidak Boleh Kosong',
              'meeting_type': 'Meeting Type Tidak Boleh Kosong',
              'start_date': '-',
              'end_date': '-',
              'location': 'Location Tidak Boleh Kosong',
              'set_time_reminder': 'Set Time Reminder',
              'note': 'Note Tidak Boleh Kosong',
            },
            // email: {
            //   'email': 'Email Tidak Valid, masukkan Email Yang Valid',
            // },
          ),
          // Jika ingin menambahkan validasi khusus untuk email, bisa menggunakan ini
          email: ['email']);

      if (validate.ok) {
        final map = forms.toMap();

        LzToast.overlay('Menambah Event ...');

        ResHandler res = await eventApi.addEvent(map);

        LzToast.dismiss();

        if (!res.status) {
          LzToast.show(res.message);
        } else {
          LzToast.show('Berhasil Menambahkan Event');
          Navigator.of(context).pop;
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
