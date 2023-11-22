import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import '../../data/models/event_model.dart';
import '../../utils/fetch/src/fetch.dart';

final eventPostProvider = AutoDisposeChangeNotifierProvider((ref) => EventPost());

class EventPost with ChangeNotifier, UseApi {
  final forms =
      LzForm.make(['title', 'meeting_with', 'meeting_type', 'location', 'note', 'start_date', 'end_date', 'reminder']);

  Future postEvent(BuildContext context) async {
    logg('Post data');
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

      if (validate.ok) {
        final map = forms.toMap();

        map['latitude'] = '-8.6634992';
        map['longitude'] = '115.2109661';

        ///
        ///
        ///-8.6634992,115.2109661

        logg(
          map,
        );

        LzToast.overlay('Menambah Event ...');
        ResHandler res = await eventApi.addEvent(map);
        LzToast.dismiss();

        if (!res.status) {
          LzToast.show(res.message);
        } else {
          LzToast.show('Berhasil Menambahkan Event');
          Navigator.of(context).pop;
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
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
