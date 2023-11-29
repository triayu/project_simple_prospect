import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/profile_model.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';

class ProfileProvider extends StateNotifier<AsyncValue<ProfileModel?>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  ProfileProvider(this.ref) : super(const AsyncValue.loading()) {
    getProfile();
  }

  Future getProfile() async {
    try {
      state = const AsyncValue.loading();
      ResHandler res = await profileApi.getProfile();

      if (res.status) {
        state = AsyncValue.data(ProfileModel.fromJson(res.data));
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final profileProvider = StateNotifierProvider.autoDispose<ProfileProvider, AsyncValue<ProfileModel?>>((ref) {
  return ProfileProvider(ref);
});
