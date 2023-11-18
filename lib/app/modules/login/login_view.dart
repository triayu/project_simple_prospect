import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../constants/color_constants.dart';
import '../../providers/auth/auth_provider.dart';
import '../register/register_view.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: Ei.sym(h: 10),
            child: Column(
              children: [
                LzImage('logo.png', size: 130, fit: BoxFit.fill),
                Text(
                  'PROSPECT',
                  style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                LzFormGroup(
                  keepLabel: true,
                  sublabelStyle: SublabelStyle.text,
                  children: [
                    LzForm.input(
                      label: 'Email',
                      hint: 'Your email address',
                      model: notifier.forms['email'],
                    ),
                    LzForm.input(
                      label: 'Password',
                      hint: 'Type your password',
                      model: notifier.forms['password'],
                      obsecureToggle: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                LzButton(
                  text: 'Login',
                  onTap: (state) {
                    notifier.login(context);
                  },
                  type: ButtonType.primary,
                  gradient: true,
                  color: null,
                  padding: Ei.sym(v: 10, h: 110),
                  radius: 25.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: Caa.center,
                  mainAxisAlignment: Maa.center,
                  children: [
                    // Gak perlu pakai text style lagi, pakai class gfont
                    Text('Belum mempunyai akun?', style: Gfont.fs14.copyWith(color: ColorConstants.primaryColor)),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView()));
                      },
                      child: Text('Register',
                          style: Gfont.black.copyWith(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              color: ColorConstants.primaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
