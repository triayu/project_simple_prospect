import 'package:riverpod/riverpod.dart';
import 'package:simple_prospect/app/data/local/auth_storage.dart';
import 'package:simple_prospect/app/data/models/model.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User()) {
    getUser();
  }

  Future getUser() async {
    state = await AuthStorage.user();
  }
}

final userProvider = StateNotifierProvider.autoDispose<UserNotifier, AsyncValue<List<String>>>((ref) {
  return UserNotifier();
});
