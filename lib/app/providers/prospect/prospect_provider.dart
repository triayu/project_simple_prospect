import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/prospect_model.dart';

import '../../utils/fetch/src/fetch.dart';

class ProspectProvider extends StateNotifier<AsyncValue<List<ProspectModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  ProspectProvider(this.ref) : super(const AsyncValue.loading()) {
    getProspect();
  }

  Future getProspect() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await prospectAPi.getProspect();

      logg(res.status);

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => ProspectModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }
}

final prospectProvider = StateNotifierProvider.autoDispose<ProspectProvider, AsyncValue<List<ProspectModel>>>((ref) {
  return ProspectProvider(
    ref,
  );
});

