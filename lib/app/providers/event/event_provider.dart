import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/event_model.dart';

import 'package:simple_prospect/app/utils/fetch/fetch.dart';
import '../../data/api/api.dart';

class EventProvider extends StateNotifier<AsyncValue<List<EventModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref; // if you want to use ref inside this provider

  EventProvider(this.ref) : super(const AsyncValue.loading()) {
    getEvent();
  }

  Future getEvent() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await eventApi.getEvent();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => EventModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }

Future delEvent(int id) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await eventApi.deleteEvent(id);

      if (res.status) {
        // Kalau dia true maka tmpilkan pesan sukses , dan panggil ulang fucntion get task , untuk mereload data task
        LzToast.show(res.message);
        getEvent();
      } else {
        // Kalau false maka tmpilkan pesan error
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }



}

 

final eventProvider = StateNotifierProvider.autoDispose<EventProvider, AsyncValue<List<EventModel>>>((ref) {
  return EventProvider(
    ref,
  );
});








// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Buat provider untuk data event
// final eventListProvider = StateNotifierProvider<EventList, List<String>>((ref) {
//   return EventList();
// });

// class EventList extends StateNotifier<List<String>> {
//   EventList() : super([]);

//   void addEvent(String event) {
//     state = [...state, event];
//   }
// }
