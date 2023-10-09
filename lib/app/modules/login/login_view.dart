import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/modules/home/dashboard_view.dart';
import 'package:simple_prospect/app/modules/home/home_view.dart';
import '../../constants/color_constants.dart';
import '../register/register_view.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final notifier = ref.watch(authProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: Ei.sym(h: 20),
            child: Column(
              children: [
                LzImage(
                  'logo.png',
                  size: 200,
                  fit: BoxFit.contain,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                LzFormGroup(
                  keepLabel: true,
                  sublabelStyle: SublabelStyle.text,
                  children: [
                    LzForm.input(
                      label: 'Username',
                      hint: 'Type your username',
                    ),
                    LzForm.input(
                      label: 'Password',
                      hint: 'Type your password',
                      obsecureToggle: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                LzButton(
                  text: 'Continue',
                  onTap: (state) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomeView(),
                      ),
                    );
                  },
                  type: ButtonType.primary,
                  gradient: true,
                  color: null,
                  padding: Ei.sym(v: 10, h: 130),
                  radius: 25.0,
                ),
                Container(
                  padding: Ei.sym(h: 35),
                  child: Row(
                    children: [
                      Text(
                        'Belum mempunyai akun?',
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView()));
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
