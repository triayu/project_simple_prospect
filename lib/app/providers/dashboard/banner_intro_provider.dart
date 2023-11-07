import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/banner_intro_model.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';
import '../../data/api/api.dart';

class BannerIntroProvider extends StateNotifier<AsyncValue<List<BannerIntroModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref; // if you want to use ref inside this provider

  BannerIntroProvider(this.ref) : super(const AsyncValue.loading()) {
    getIntro();
  }

  Future getIntro() async {
    try {
      // Kita akan mengubah state dari provider ini menjadi loading
      state = const AsyncValue.loading();

      // Koneksi Ke api untuk mendapatkan data
      ResHandler res = await goalApi.getGoal();

      // Kemudian variable respon diatas akan mengembalikan sejumlah nilai, diantaranya:
      // res.status  --> Status dari respon (true atau false)
      // res.message --> Pesan dari respon (Ini untuk pesan yang ada pada object message)
      // res.data --> Data dari respon (Ini untuk respon yang ada pada object data)
      // res.body --> Body dari respon (Ini untuk semua respon yang ada ketika kita menggunakan fetch)

      if (res.status) {
        List data = res.data ?? [];

        // Jika status dari respon adalah true, maka kita akan mengubah state dari provider ini menjadi data
        state = AsyncValue.data(data.map((e) => BannerIntroModel.fromJson(e)).toList());
      } else {
        // Jika status dari respon adalah false, maka kita akan menampilkan pesan error
        LzToast.show(res.message);
      }
    } catch (e, s) {
      // Jika terjadi error, maka kita akan menampilkan pesan error
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }
}

final introProvider = StateNotifierProvider.autoDispose<BannerIntroProvider, AsyncValue<List<BannerIntroModel>>>((ref) {
  return BannerIntroProvider(
    ref,
  );
});
