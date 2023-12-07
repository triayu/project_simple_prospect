import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'package:simple_prospect/app/data/models/up_daily_task_model.dart';

import 'package:simple_prospect/app/utils/fetch/fetch.dart';
import '../../data/api/api.dart';

class DashboardUpDailyTaskProvider extends StateNotifier<AsyncValue<List<UpDailyTaskModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref; // if you want to use ref inside this provider

  DashboardUpDailyTaskProvider(this.ref) : super(const AsyncValue.loading()) {
    getUpDailyTask();
  }

  Future getUpDailyTask() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await upDailyTaskApi.getUpDailyTask();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => UpDailyTaskModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }
}

final upTaskProvider =
    StateNotifierProvider.autoDispose<DashboardUpDailyTaskProvider, AsyncValue<List<UpDailyTaskModel>>>((ref) {
  return DashboardUpDailyTaskProvider(
    ref,
  );
});
