import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/event_model.dart';

import 'package:simple_prospect/app/utils/fetch/fetch.dart';
import '../../data/api/api.dart';

class EventProvider extends StateNotifier<AsyncValue<List<EventModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref; 

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

// ini function untuk apa ? untuk ngeget apa vivi ?
// itu untuk liat hasil dari event itu ya kak
// untuk detail event ?? iya betul
// kalau dia untuk detail event buatin nae judul nya getDetailEvent VIVI, biar gk bingungg
// nanti aku yg nglanjutin project ini bsa stres sndiri kalau anamnya gk sesuai wkwkw
// ini respon nya emang sama pake Event Model Juga ?
// iya sama kak
  Future getDetailEvent(int id) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await eventApi.showEvent(id);

      if (res.status) {
   
        EventModel event = EventModel.fromJson(res.data);

      
        LzToast.show("Event Details: ${event}");
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future delEvent(int id) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await eventApi.deleteEvent(id);

      if (res.status) {
        LzToast.show(res.message);
        getEvent();
      } else {
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
