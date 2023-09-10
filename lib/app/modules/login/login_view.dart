import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/modules/register/register_view.dart';

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

class LoginView extends ConsumerWidget {
  const LoginView({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isAuthenticated = ref.watch(authProvider);

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
                  'Login',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: Ei.only(t: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue, width: 1),
                  ),
                  child: LzForm.input(
                    label: 'Username',
                    hint: 'Type your username',
                  ),
                ),
                Container(
                  margin: Ei.only(t: 20, b: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue, width: 1),
                  ),
                  child: LzForm.input(
                    label: 'Password',
                    hint: 'Type your password',
                    obsecureToggle: true,
                  ),
                ),
                LzButton(
                  text: 'Login',
                  onTap: (state) {
                    ref.read(authProvider.notifier).login();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => RegisterView(),
                      ),
                    );
                  },
                  type: ButtonType.primary,
                  gradient: true,
                  color: null,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 120),
                  radius: 25.0,
                ),
                if (isAuthenticated)
                  Text(
                    'Anda berhasil login!',
                    style: TextStyle(color: Colors.blue),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
