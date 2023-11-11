import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/api/api.dart';
import '../../data/models/model.dart';

class PhoneBookNotifier extends StateNotifier<AsyncValue<List<Todo>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref; // if you want to use ref inside this provider

  PhoneBookNotifier(this.ref) : super(const AsyncValue.loading()) {
    getPhoneBook();
  }

  Future getPhoneBook() async {
    try {
      state = const AsyncValue.loading();
    } catch (e, s) {
      Errors.check(e, s);

      // state = AsyncValue.error(e, s); // Use this if you want to show error message on screen
    }
  }


}

final phoneBookProvider = StateNotifierProvider.autoDispose<PhoneBookNotifier, AsyncValue<List<Todo>>>((ref) {
  ref.onDispose(() {
    logg('--- phoneBookProvider disposed');
  });

  return PhoneBookNotifier(ref);
});

