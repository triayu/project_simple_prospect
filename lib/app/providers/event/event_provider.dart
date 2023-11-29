import 'package:flutter/widgets.dart';
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

  final forms =
      LzForm.make(['title', 'meeting_with', 'meeting_type', 'location', 'note', 'start_date', 'end_date', 'reminder']);

  Future postEvent(BuildContext context) async {
    try {
      final validate = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(
            required: {
              'title': 'Title Tidak Boleh Kosong',
              'meeting_with': 'Meeting With Tidak Boleh Kosong',
              'meeting_type': 'Meeting Type Tidak Boleh Kosong',
              'location': 'Location Tidak Boleh Kosong',
              'note': 'Note Tidak Boleh Kosong',
              'reminder': 'Reminder Tidak Boleh Kosong',
            },
            // email: {
            //   'email': 'Email Tidak Valid, masukkan Email Yang Valid',
            // },
          ),
          // Jika ingin menambahkan validasi khusus untuk email, bisa menggunakan ini
          email: ['email']);

      logg(validate.ok);

      if (validate.ok) {
        final map = forms.toMap();

        map['latitude'] = '-8.6634992';
        map['longitude'] = '115.2109661';

        LzToast.overlay('Menambah Event ...');
        ResHandler res = await eventApi.addEvent(map);
        LzToast.dismiss();

        if (!res.status) {
          LzToast.show(res.message);
          forms.reset();
        } else {
          LzToast.show('Berhasil Menambahkan Event');
          Navigator.of(context).pop();
          forms.reset();
          await getEvent();
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  // Function ini dipergunakan untuk mengisi data yng mau diubah / diedit ke dalam form
  void fillForm(EventModel? data) {
    try {
      if (data != null) {
        logg(data, limit: 20000);

        final map = data.toJson();

        // Nah nanti kan udah dapat data detail nya dia ketika kita mencet edit tu
        // nah nanti tinggal nyocokin aja key nya sama forms key nya
        // ini kan masih ada yg belum sesuai tu, tinggal format aja skrang
        logg(map, color: LogColor.blue);
        map.forEach((key, value) {
          if (forms.containsKey(key) && value != null) {
            forms[key]!.controller.text = value.toString();

            if (key == 'start_date' || key == 'end_date') {
              forms[key]!.controller.text = DateTime.parse(value).format('yyyy-MM-dd');
            }

            if (key == 'reminder') {
              forms[key]!.controller.text = DateTime.parse(value).format('HH:mm:ss');
            }
          }
        });
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future editEvent(BuildContext context, int id) async {
    // Logg
    logg('Update Data');
    try {
      LzToast.overlay('Sedang Mengupdate Data..');
      ResHandler res = await eventApi.updateEvent(forms, id);
      LzToast.dismiss();
      if (res.status) {
        LzToast.show('Berhasil Mengupdate Data');
        Navigator.of(context).pop;
        getEvent();
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
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
