import 'package:riverpod/riverpod.dart';

final registerProvider = StateNotifierProvider<AuthController, bool>((ref) {
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
