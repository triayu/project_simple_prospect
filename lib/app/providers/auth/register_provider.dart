import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/local/shared_preferences.dart';
import 'package:simple_prospect/app/providers/auth/auth_provider.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';
import '../../data/api/api.dart';

final RegisterProvider = ChangeNotifierProvider((ref) => Register());

class Register with ChangeNotifier, UseApi {
  final formm = LzForm.make(['first_name', 'last_name', 'email', 'password', 'password_confirmation']);

  Future register(BuildContext context) async {
    try {
      final validate = LzForm.validate(this.formm,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {
            'fisrt_name': 'Fisrt Name Tidak Boleh Kosong',
            'last_name': 'Last Name Tidak Boleh Kosong',
            'email': 'Email Tidak Boleh Kosong',
            'password_confirmation': 'Password Tidak Boleh Kosong'
          }));

      if (validate.ok) {
        final map = formm.toMap();
        LzToast.show('Register...');

        ResHandler res = await authApi.register(map);

        if (!res.status) {
          return LzToast.show(res.message);
        }

        SharedPreferencesHelper.setMap('user', res.data);

        SharedPreferencesHelper.setString('token', res.data['token']);

        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => LoginView(),
        //   ),
        // );

        return LzToast.show('Nice! You are regist in');
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}
