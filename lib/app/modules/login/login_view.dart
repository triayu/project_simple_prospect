import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazyui/lazyui.dart';
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
                  size: 150,
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
                SizedBox(height: 20),
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
                LzButton(
                  text: 'Login',
                  onTap: (state) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => RegisterView(),
                      ),
                    );
                  },
                  type: ButtonType.primary,
                  gradient: true,
                  color: null,
                  padding: Ei.sym(v: 10, h: 120),
                  radius: 25.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
