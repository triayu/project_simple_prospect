import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/local/shared_preferences.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';
import '../../data/api/api.dart';

final authProvider = ChangeNotifierProvider((ref) => Auth());

class Auth with ChangeNotifier, UseApi {
  final forms = LzForm.make(['username', 'password']);

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
            'username': 'Username Tidak Boleh Kosong',
            'password': 'Password Tidak Boleh Kosong',
          }));

      if (validate.ok) {
        final map = forms.toMap();
        LzToast.overlay('Logging in...');
        ResHandler res = await authApi.login(map);
        logg(res.data);

        if (!res.status) {
          return LzToast.show(res.message);
        }
        // Set user data to local storage agar user model bisa diakses di seluruh aplikasi
        SharedPreferencesHelper.setMap('user', res.data);

        // Set token to local storage agar token bisa diakses di seluruh aplikasi
        SharedPreferencesHelper.setString('token', res.data['token']);

        logg(prefs.getString('user'), color: LogColor.red);
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => HomeView(),
        //   ),
        // );

        return LzToast.show('Nice! You are logged in');
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}
