import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/profile_model.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';

class ProfileProvider extends StateNotifier<AsyncValue<List<ProfileModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  ProfileProvider(this.ref) : super(const AsyncValue.loading()) {
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      state = const AsyncValue.loading();
      ResHandler res = await profileApi.getProfile();

      logg(res.status);

      if (res.status) {
        LzToast.show(res.message);
        getProfile();
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  // Variable For LzForm
  final lzForm = LzForm.make(['date']);
}

final profileProvider = StateNotifierProvider.autoDispose<ProfileProvider, AsyncValue<List<ProfileModel>>>((ref) {
  return ProfileProvider(ref);
});
