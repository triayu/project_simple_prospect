// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:simple_prospect/app/data/models/profile_model.dart';

// import 'package:simple_prospect/app/utils/fetch/fetch.dart';
// import '../../data/api/api.dart';

// class ProfileProvider extends StateNotifier<AsyncValue<List<ProfileModel>>> with UseApi {
//   final AutoDisposeStateNotifierProviderRef? ref;

//   ProfileProvider(this.ref) : super(const AsyncValue.loading()) {
//     getProfile();
//   }

//   Future getProfile() async {
//     try {
//       state = const AsyncValue.loading();

//       ResHandler res = await profileApi.getProfile();

//       logg(res.status);

//       if (res.status) {
//         List data = res.data ?? [];

//         state = AsyncValue.data(data.map((e) => ProfileModel.fromJson(e)).toList());
//       } else {
//         LzToast.show(res.message);
//       }
//     } catch (e, s) {
//       Errors.check(e, s);
//       state = AsyncValue.data([]);
//     }
//   }

//   // Variable For LzForm
//   final formstart = LzForm.make(['date']);
// }

// final profileProvider = StateNotifierProvider.autoDispose<ProfileProvider, AsyncValue<List<ProfileModel>>>((ref) {
//   return ProfileProvider(ref);
// });












// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // class UserProfile {
// //   final String name;
// //   final String imageUrl;

// //   UserProfile(this.name, this.imageUrl);
// // }

// // final userProfileProvider = Provider<UserProfile>((ref) {
// //   return UserProfile("Nama Pengguna", "URL_GAMBAR_PROFIL");
// // });
