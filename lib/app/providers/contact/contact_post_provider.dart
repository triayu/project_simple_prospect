import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/model.dart';

import '../../utils/fetch/src/fetch.dart';

final contactPostProvider = AutoDisposeChangeNotifierProvider((ref) => contactPost());

class contactPost with ChangeNotifier, UseApi {
  final forms = LzForm.make(
      ['first_name', 'last_name', 'email', 'phone_number', 'work_phone_number', 'home_phone_number', 'categor']);

  Future post(BuildContext context) async {
    try {
      final validate = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(
            required: {
              'first_name': 'First Name Tidak Boleh Kosong',
              'last_name': 'Last Name Tidak Boleh Kosong',
              'email': 'Email Type Tidak Boleh Kosong',
              'phone_number': 'Phone Number Tidak Boleh Kosong',
              'work_phone_number': 'Work Phone Number',
              'home_phone_number': 'Home Phone Number Tidak Boleh Kosong',
              'category': 'Category Reminder',
            },
            email: {
              'email': 'Email Tidak Valid, masukkan Email Yang Valid',
            },
          ),
          // Jika ingin menambahkan validasi khusus untuk email, bisa menggunakan ini
          email: ['email']);

      if (validate.ok) {
        final map = forms.toMap();

        LzToast.overlay('Menambah Contact ...');

        ResHandler res = await contactApi.createContact(map);

        LzToast.dismiss();

        if (!res.status) {
          LzToast.show(res.message);
        } else {
          LzToast.show('Berhasil Menambahkan Contact');
          Navigator.of(context).pop;
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }


  List<CategoryContactModel> categoryContacts = [];


  Future getCategoryContact() async {
    try {
      LzToast.overlay('Loading data...') ;
      ResHandler res = await contactApi.getCategoryContact();
      LzToast.dismiss();

      if(res.status) {
        List data = res.data ?? [];

        categoryContacts = data.map((e) => CategoryContactModel.fromJson(e)).toList();
        notifyListeners();
      } else {}

    } catch (e,s) {

      Errors.check(e, s);
    }
  }
}
