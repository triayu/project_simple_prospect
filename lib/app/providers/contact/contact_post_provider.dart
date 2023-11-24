import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/model.dart';

import '../../utils/fetch/src/fetch.dart';

final contactPostProvider = AutoDisposeChangeNotifierProvider((ref) => contactPost());

class contactPost with ChangeNotifier, UseApi {
  final forms = LzForm.make(
      ['first_name', 'last_name', 'email', 'phone_number', 'work_phone_number', 'home_phone_number', 'category']);

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
      LzToast.overlay('Loading data...');
      ResHandler res = await contactApi.getCategoryContact();
      LzToast.dismiss();
      if (!res.status) {
        LzToast.show(res.message);
      }
      List data = res.data ?? [];
      categoryContacts = data.map((e) => CategoryContactModel.fromJson(e)).toList();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void setCategory() async {
    // Ini variable yang merepresentasikan model dari formnya
    final form = forms['category']?.notifier;
    // trus di set null jadi option nya tu isinya kosong
    form?.setOption(null);
    // lalu kita get catgory nya dari api

    // kemudian kita tangkap datanya ubah jadikan variable yang return nya List Of Option
    // Biar mau tampil dia di Lzform.select value nya, harus pake option
    List<Option> options = List.generate(categoryContacts.length, (i) {
      return Option(
        option: categoryContacts[i].categoryName ?? '',
        value: categoryContacts[i].id ?? '',
      );
    });
    form?.setOption(null);
    // Lalu terakhir tinggal setIsi dari LzFormSelectnya
    form?.setOptions(options);
  }

  // EDIT CONTACT
  void fillForm(ContactModel? data) {
    try {
      if (data != null) {
        logg(data, limit: 20000);

        final map = data.toJson();

        map.forEach((key, value) {
          if (forms.containsKey(key) && value != null) {
            forms[key]!.controller.text = value.toString();
          }
        });
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future editContact(BuildContext context, int id) async {
    // Logg
    logg('Update Data');
    try {
      LzToast.overlay('Sedang Mengupdate Data..');
      ResHandler res = await contactApi.updateContact(forms, id);
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
