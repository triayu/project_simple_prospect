import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/coming_event_model.dart';

import 'package:simple_prospect/app/utils/fetch/fetch.dart';
import '../../data/api/api.dart';

class DashboardComingEvent extends StateNotifier<AsyncValue<List<ComingEventModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref; // if you want to use ref inside this provider

  DashboardComingEvent(this.ref) : super(const AsyncValue.loading()) {
    getUpComingEvent();
  }

  Future getUpComingEvent() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await comingEvent.getUpComingEvent();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => ComingEventModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }
}

final comingeventProvider =
    StateNotifierProvider.autoDispose<DashboardComingEvent, AsyncValue<List<ComingEventModel>>>((ref) {
  return DashboardComingEvent(
    ref,
  );
});
