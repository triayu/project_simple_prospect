import 'dart:io'; 

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/message_template_model.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';
import '../../data/api/api.dart';
import '../../modules/profile/widget/wi_image_preview.dart';

final postMessageTemplateProvider = AutoDisposeChangeNotifierProvider((ref) => PostMessage());

class PostMessage with ChangeNotifier, UseApi {
  final forms = LzForm.make(['title', 'message']);

  Future post(BuildContext context) async {
    try {
      // Variable Validation, nanti variable ini akan memilki nilai true jika semua form sudah terisi
      // Kamu bisa setting configurasi validasi nya dibawah ini, ada banyak pilihan pengaturan yang bisa kamu customize, diantaranya:
      // required: ['*'] => Semua form harus terisi
      // required: ['username', 'password'] => Hanya form username dan password yang harus terisi
      // notifier type : LzFormNotifier.text => Notifier akan berjalan ketika user mengetikkan text
      // messages: FormMessages(required: {'username': 'Username Tidak Boleh Kosong'}) => Pesan error yang akan ditampilkan jika form tidak terisi
      final validate = LzForm.validate(
        this.forms,
        required: ['*'],
        singleNotifier: false,
        notifierType: LzFormNotifier.text,
        // ini adalah custom text yang muncul ketika field kosong
        messages: FormMessages(
          required: {
            'title': 'Judul Pesan Tidak Boleh Kosong',
            'message': 'Pesan Tidak Boleh Kosong',
          },
        ),
      );

      if (validate.ok) {
        final map = forms.toMap();

        logg(map);

        LzToast.overlay('Menambahkan template pesan...');

        //  digunakan untuk koneksi api - menggunakan await karena ini proses nya respon dari api,

        ResHandler res = await messageTemplateApi.createMessageTemplate(map);

        // ketika proses di atas berjalan , variable res diatas akan mereturn beberapa nilai, salah satunya
        // res.status, yang nilainya beruba boolean, true or false,
        // kondisi dibwah menjunkkan jika kondisi api tersebut hasilnya false, maka dia akan memunculkan toast
        // yg ada di dalam if
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

  final ImagePicker _picker = ImagePicker();
  File image = File('');
  String filePath = '';

  void pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1500,
      maxHeight: 1500,
      imageQuality: 90,
    );

    if (pickedFile != null) {
      showDialog(context: context, builder: (context) => WidImagePreview(file: File(pickedFile.path))).then((value) {
        if (value != null) {
          image = File(pickedFile.path);
        }
      });
      filePath = pickedFile.path;
    }
  }

// Function ini dipergunakan untuk mengisi data yng mau diubah / diedit ke dalam form
  void fillForm(MessageTemplateModel? data) {
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

  Future editMessageTemplate(BuildContext context, int id) async {
    logg('Update Data');
    try {
      LzToast.overlay('Sedang Mengupdate Data..');
      final map = forms.toMap();
      ResHandler res = await messageTemplateApi.updateMessageTemplate(map, id);
      LzToast.dismiss();
      if (res.status) {
        LzToast.show('Berhasil Mengupdate Data');
        Navigator.of(context).pop();
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
