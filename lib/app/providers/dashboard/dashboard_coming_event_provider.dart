import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/coming_event_model.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';
import '../../data/api/api.dart';

class DashboardComingEvent extends StateNotifier<AsyncValue<List<UpcomingEventModel>>> with UseApi {
  DashboardComingEvent() : super(const AsyncValue.loading()) {
    getUpComingEvent();
  }

  Future<void> getUpComingEvent() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await comingEvent.getUpComingEvent();

      if (res.status) {
        final Map<String, dynamic>? responseData = res.data;

        if (responseData != null) {
          final List<dynamic>? upcomingEventsData = responseData['upcomingEvents'];

          if (upcomingEventsData != null) {
            state = AsyncValue.data(upcomingEventsData.map((e) => UpcomingEventModel.fromJson(e)).toList());
          } else {
            // Handle the case where 'upcomingEvents' key is not found in the response
            LzToast.show('Upcoming events data not found in the response');
          }
        } else {
          // Handle the case where 'data' key is not found in the response
          LzToast.show('Data key not found in the response');
        }
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
    StateNotifierProvider.autoDispose<DashboardComingEvent, AsyncValue<List<UpcomingEventModel>>>(
  (ref) {
    return DashboardComingEvent();
  },
);
