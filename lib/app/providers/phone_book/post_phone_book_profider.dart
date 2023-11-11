import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';

import '../../utils/fetch/src/fetch.dart';

final phoneBookPostProvider = AutoDisposeChangeNotifierProvider((ref) => phoneBookPost());

class phoneBookPost with ChangeNotifier, UseApi {
  final forms = LzForm.make(['name', 'phone_number', 'email']);

  Future post(BuildContext context) async {
    try {
      final validate = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(
            required: {
              'email': 'Email Tidak Boleh Kosong',
              'password': 'Password Tidak Boleh Kosong',
              'name': 'Nama Tidak Boleh Kosong',
              'phone_number': 'No Telpon Tidak Boleh Kosong',
            },
            email: {
              'email': 'Email Tidak Valid, masukkan Email Yang Valid',
            },
          ),
          // Jika ingin menambahkan validasi khusus untuk email, bisa menggunakan ini
          email: ['email']);

      if (validate.ok) {
        final map = forms.toMap();

        LzToast.overlay('Menambah Buku Telepon...');

        ResHandler res = await phoneBookApi.addPhoneBook(map);

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
}
