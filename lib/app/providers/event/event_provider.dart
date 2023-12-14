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

        logg(map);

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

  void fillForm(EventModel? data) {
    try {
      if (data != null) {
        logg(data, limit: 20000);

        forms['title']?.controller.text = data.title ?? '';
        forms['meeting_with']?.controller.text = data.meetingWith ?? '';
        forms['meeting_type']?.controller.text = data.meetingType ?? '';
        forms['location']?.controller.text = data.location ?? '';
        forms['note']?.controller.text = data.note ?? '';

        void setDateTime(String key, String? value, String format) {
          forms[key]?.controller.text = value != null ? DateTime.parse(value).format(format) : '';
        }

        // setDateTime('start_date', data.startDate, 'yyyy-MM-dd');
        // setDateTime('end_date', data.endDate, 'yyyy-MM-dd');
        setDateTime('reminder', data.reminder, 'HH:mm:ss');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future editEvent(BuildContext context, int id) async {
    try {
      LzToast.overlay('Sedang Mengupdate Data..');

      final validate = LzForm.validate(forms, required: [
        'title',
        'meeting_with',
        'start_date',
        'end_date',
        'latitude',
        'longitude',
        'location',
        'reminder',
        'note'
      ]);
      if (!validate.ok) {
        LzToast.dismiss();
        return;
      }

      final map = forms.toMap();
      ResHandler res = await eventApi.updateEvent(map, id);

      LzToast.dismiss();
      if (res.status) {
        LzToast.show('Berhasil Mengupdate Data');
        Navigator.of(context).pop();
        await getEvent();
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

  void setDateTime(String key, String? value, String format) {
    try {
      if (value != null && value.isNotEmpty) {
        DateTime parsedDate = DateTime.parse(value);
        forms[key]?.controller.text = parsedDate.format(format);
      } else {
        forms[key]?.controller.text = '';
      }
    } catch (e, stackTrace) {
      print('Error parsing date: $value');
      print('Stack Trace: $stackTrace');
      forms[key]?.controller.text = '';
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
