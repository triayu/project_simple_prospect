import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/modules/login/login_view.dart';
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
            'first_name': 'First Name Tidak Boleh Kosong',
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

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ),
        );

        formm.clear();

        return LzToast.show('Nice! You are regist in');
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}
