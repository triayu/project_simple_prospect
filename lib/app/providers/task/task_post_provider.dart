import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/task_model.dart';

import '../../utils/fetch/src/fetch.dart';

final taskPostProvider = AutoDisposeChangeNotifierProvider((ref) => TaskPost());

class TaskPost with ChangeNotifier, UseApi {
  final forms = LzForm.make(['title', 'note', 'relate_to', 'start_date', 'end_date', 'priority', 'set_time_reminder']);

  Future post(BuildContext context) async {
    try {
      final validate = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(
            required: {
              'title': 'Title Tidak Boleh Kosong',
              'note': 'Note Tidak Boleh Kosong',
              'relate_to': 'Relate To Tidak Boleh Kosong',
              'start_date': '-',
              'end_date': '-',
              'priority': 'Priority Tidak Boleh Kosong',
              'set_time_reminder': 'Set Time Reminder',
            },
            // email: {
            //   'email': 'Email Tidak Valid, masukkan Email Yang Valid',
            // },
          ),
          // Jika ingin menambahkan validasi khusus untuk email, bisa menggunakan ini
          email: ['email']);

      if (validate.ok) {
        final map = forms.toMap();

        LzToast.overlay('Menambah Buku Telepon...');

        ResHandler res = await taskApi.postTask(map);

        LzToast.dismiss();

        if (!res.status) {
          return LzToast.show(res.message);
        } else {
          LzToast.show(res.message);
          return Navigator.pop(context);
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }


 void fillForm(TaskModel? data) {
    try {
      if (data != null) {
        logg(data, limit: 20000);

        final map = data.toJson();

        map.forEach((key, value) {
          if (forms.containsKey(key) && value != null) {
            forms[key]!.controller.text = value.toString();

            if (key == 'start_date' || key == 'end_date') {
              forms[key]!.controller.text = DateTime.parse(value).format('yyyy-MM-dd');
            }

            if (key == 'reminder') {
              forms[key]!.controller.text = DateTime.parse(value).format('HH:mm:ss');
            }
          }
        });
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future editTask(BuildContext context, int id) async {
    // Logg
    logg('Update Data');
    try {
      LzToast.overlay('Sedang Mengupdate Data..');
      ResHandler res = await taskApi.updateTask(forms, id);
      LzToast.dismiss();
      if (res.status) {
        LzToast.show('Berhasil Mengupdate Data');
        Navigator.of(context).pop;
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
