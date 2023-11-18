import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';
import '../../data/api/api.dart';

// Auto Dispose digunakan untuk menghapus provider ketika tidak digunakan lagi
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
        // ini data Form Body yg dikirim dari inputan, data yg dikitim berupa json, / atau dalam dart itu map
        // string dynamic
        final map = forms.toMap();

        logg(map);

        // Kemudian Munculkan overlay loading,
        LzToast.overlay('Menambahkan template pesan...');

        // lalu fungsi ini yg digunakan untuk koneksi api, kenapa harus menggunakan await, karena ini proses nya
        // menunggu respon dari api, jadi proses ini akan ditunggu smpai proses ini selesai, maka dia akan melanjutkan
        // ke proses bwahnya
        ResHandler res = await messageTemplateApi.createMessageTemplate(map);

        // Nah ketika proses di atas berjalan , variable res diata akan mereturn beberapa nilai, salah satunya
        // res.status, yang nilainya beruba boolean, true or false,
        // nah kondisi dibwah menjunkkan jika kondisi api tersebut hasilnya false, maka dia akan memunculkan toast
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
}
