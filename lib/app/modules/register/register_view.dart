import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/modules/home/home_view.dart';

final authProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController();
});

class AuthController extends StateNotifier<bool> {
  AuthController() : super(false);

  void login() {
    Future.delayed(Duration(seconds: 2), () {
      state = true;
    });
  }

  void logout() {
    state = false;
  }
}

class RegisterView extends ConsumerWidget {
  const RegisterView({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LzImage(
                  'logo.png',
                  size: 150,
                ),
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                LzFormGroup(
                  children: [
                    LzForm.input(
                      label: 'Fisrt name',
                      hint: 'Type your username',
                    ),
                    LzForm.input(
                      label: 'Last name',
                      hint: 'Type your username',
                    ),
                    LzForm.input(
                      label: 'Email',
                      hint: 'Your email address',
                    ),
                    LzForm.input(
                      label: 'Password',
                      hint: 'Type your password',
                      obsecureToggle: true,
                    ),
                  ],
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
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 120),
                  radius: 25.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
