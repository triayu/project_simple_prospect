import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/message_model.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';
import '../../data/api/api.dart';

final postMessageProvider = AutoDisposeChangeNotifierProvider((ref) => PostMessage());

class PostMessage with ChangeNotifier, UseApi {
  final forms = LzForm.make(['name', 'phone_number', 'message']);

  Future post(BuildContext context) async {
    try {
      final validate = LzForm.validate(
        this.forms,
        required: ['*'],
        singleNotifier: false,
        notifierType: LzFormNotifier.text,
        messages: FormMessages(
          required: {
            'name': 'Nama Tidak Boleh Kosong',
            'phone_number': 'Phone Number Tidak Boleh Kosong',
            'message': 'Pesan Tidak Boleh Kosong',
          },
        ),
      );

      if (validate.ok) {
        final map = forms.toMap();

        logg(map);

        LzToast.overlay('Menambahkan template pesan...');

        ResHandler res = await messageApi.postMessage(map);

        if (!res.status) {
          LzToast.show(res.message);
        } else {
          LzToast.show('Berhasil Menambahkan Data');
        }

        Navigator.of(context).pop();
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }

// Function ini dipergunakan untuk mengisi data yng mau diubah / diedit ke dalam form
  void fillForm(MessageModel? data) {
    try {
      if (data != null) {
        logg(data, limit: 20000);

        final map = data.toJson();

        logg(map, color: LogColor.blue);
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

  Future editMessage(BuildContext context, int id) async {
    // Logg
    logg('Update Data');
    try {
      LzToast.overlay('Sedang Mengupdate Data..');
      ResHandler res = await messageApi.updateMessage(forms, id);
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
