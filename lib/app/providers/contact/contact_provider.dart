import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'package:simple_prospect/app/utils/fetch/fetch.dart';
import '../../data/api/api.dart';
import '../../data/models/model.dart';

class ContactProvider extends StateNotifier<AsyncValue<List<ContactModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  ContactProvider(this.ref) : super(const AsyncValue.loading()) {
    getContact();
  }

  Future getContact() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await contactApi.getListContact();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => ContactModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }

  Future delContact(int id) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await contactApi.deleteContact(id);

      if (res.status) {
        LzToast.show(res.message);
        getContact();
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final contactProvider = StateNotifierProvider.autoDispose<ContactProvider, AsyncValue<List<ContactModel>>>((ref) {
  return ContactProvider(
    ref,
  );
});
