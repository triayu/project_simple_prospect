import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/local/shared_preferences.dart';
import 'package:simple_prospect/app/modules/home/home_view.dart';
import 'package:simple_prospect/app/modules/login/login_view.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';
import '../../data/api/api.dart';

final authProvider = ChangeNotifierProvider((ref) => Auth());

class Auth with ChangeNotifier, UseApi {
  final forms = LzForm.make(['email', 'password']);

  Future login(BuildContext context) async {
    try {
      // Variable Validation, nanti variable ini akan memilki nilai true jika semua form sudah terisi
      // Kamu bisa setting configurasi validasi nya dibawah ini, ada banyak pilihan pengaturan yang bisa kamu customize, diantaranya:
      // required: ['*'] => Semua form harus terisi
      // required: ['username', 'password'] => Hanya form username dan password yang harus terisi
      // notifier type : LzFormNotifier.text => Notifier akan berjalan ketika user mengetikkan text
      // messages: FormMessages(required: {'username': 'Username Tidak Boleh Kosong'}) => Pesan error yang akan ditampilkan jika form tidak terisi
      final validate = LzForm.validate(this.forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {
            'email': 'Username Tidak Boleh Kosong',
            'password': 'Password Tidak Boleh Kosong',
          }));

      if (validate.ok) {
        // ini data Form Body yg dikirim dari inputan, data yg dikitim berupa json, / atau dalam dart itu map
        // string dynamic
        final map = forms.toMap();

        // Kemudian Munculkan overlay loading,
        LzToast.overlay('Logging in...');

        // lalu fungsi ini yg digunakan untuk koneksi api, kenapa harus menggunakan await, karena ini proses nya
        // menunggu respon dari api, jadi proses ini akan ditunggu smpai proses ini selesai, maka dia akan melanjutkan
        // ke proses bwahnya
        ResHandler res = await authApi.login(map);

        // Nah ketika proses di atas berjalan , variable res diata akan mereturn beberapa nilai, salah satunya
        // res.status, yang nilainya beruba boolean, true or false,
        // nah kondisi dibwah menjunkkan jika kondisi api tersebut hasilnya false, maka dia akan memunculkan toast
        // yg ada di dalam if
        if (!res.status) {
          return LzToast.show(res.message);
        }
        // Set user data to local storage agar user model bisa diakses di seluruh aplikasi
        SharedPreferencesHelper.setMap('user', res.data);

        // Set token to local storage agar token bisa diakses di seluruh aplikasi
        // Kenapa res.data[access_token], karena kita ingin menyimpan data token yang diterima oleh
        SharedPreferencesHelper.setString('token', res.data['access_token']);

        // Navigasi ke page home ketika sudah login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );

        forms.clear();

        return LzToast.show('Nice! You are logged in');
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }

  Future logOut(BuildContext context) async {
    try {
      // Untuk logout , kita harus menghapus token dan menghapus user serta , jika ada api kita post ke api
      // Tapi smntra kita hpus token dan user saja
      LzToast.overlay('Sedang Logout...');
      prefs.remove('user');
      prefs.remove('token');

      // lalu navigate ke halaman login
      Utils.timer(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ),
        );
      }, 5.s);

      LzToast.dismiss();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
