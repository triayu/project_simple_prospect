import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/data/models/task_model.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';
import '../../data/api/api.dart';

class TaskProvider extends StateNotifier<AsyncValue<List<TaskModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  TaskProvider({this.ref}) : super(const AsyncValue.loading()) {
    getTask();
  }

  // variable
  final forms = LzForm.make(['title', 'note', 'relate_to', 'start_date', 'end_date', 'priority', 'reminder']);
  ContactModel? selectedContact;

  Future getTask() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await taskApi.getTask();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => TaskModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }

  void fillForm(TaskModel? data) {
    try {
      if (data != null) {
        final map = data.toJson();

        logg(map);

        map.forEach((key, value) {
          if (forms.containsKey(key) && value != null) {
            forms[key]!.controller.text = value.toString();

            if (key == 'start_date' || key == 'end_date') {
              forms[key]!.controller.text = DateTime.parse(value).format('yyyy-MM-dd');
            }

            // if (key == 'reminder') {
            //   forms[key]!.controller.text = DateTime.parse(value).format('HH:mm:ss');
            // }
          }
        });
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future editTask(BuildContext context, int id) async {
    // Logg

    try {
      LzToast.overlay('Sedang Mengupdate Data..');
      ResHandler res = await taskApi.updateTask(forms, id);
      LzToast.dismiss();
      if (res.status) {
        LzToast.show('Berhasil Mengupdate Data');
        Navigator.of(context).pop;
        await getTask();
      } else if (res.message != null) {
        Navigator.of(context).pop;
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future deltask(int id) async {
    try {
      LzToast.overlay('Sedang Menghapus Data..');
      ResHandler res = await taskApi.deleteTask(id);
      LzToast.dismiss();
      if (res.status) {
        LzToast.show('Berhasil Menghapus Data');
        await getTask();
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  // Ini untuk category contact
  List<ContactModel> contacts = [];
  ContactModel? contactSelected;

  Future getContact() async {
    try {
      LzToast.overlay('Sedang Mengambil Data..');
      ResHandler res = await contactApi.getListContact();
      LzToast.dismiss();
      if (res.status) {
        List data = res.data ?? [];

        contacts = data.map((e) => ContactModel.fromJson(e)).toList();
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void setContact() async {
    // Ini variable yang merepresentasikan model dari formnya
    final form = forms['relate_to']?.notifier;
    // trus di set null jadi option nya tu isinya kosong
    form?.setOption(null);

    // lalu kita get catgory nya dari api

    // kemudian kita tangkap datanya ubah jadikan variable yang return nya List Of Option
    // Biar mau tampil dia di Lzform.select value nya, harus pake option
    List<Option> options = List.generate(contacts.length, (i) {
      return Option(
        option: contacts[i].fullName ?? '',
        value: contacts[i].contactId ?? '',
      );
    });

    if (options.isNotEmpty) {
      // Lalu terakhir tinggal setIsi dari LzFormSelectnya
      form?.setOptions(options);
    }
  }

  Future post(BuildContext context) async {
    try {
      final validate = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(
            required: {
              'title': 'Title Tidak Boleh Kosong',
              'note': 'Note Tidak Boleh Kosong',
              'relate_to': 'Contact Id Tidak Boleh Kosong',
              'start_date': '-',
              'end_date': '-',
              'priority': 'Priority Tidak Boleh Kosong',
              'set_time_reminder': 'Set Time Reminder',
            },
            // email: {
            //   'email': 'Email Tidak Valid, masukkan Email Yang Valid',
            // },
          ),
          // Jika ingin menambahkan validasi khusus untuk email, bisa menggunakan ini
          email: ['email']);

      if (validate.ok) {
        final map = forms.toMap(except: ['relate_to']);

        map['priority'] = map['priority'].toString().toLowerCase();
        map['contact_id'] = contactSelected!.id;
        map['relate_to'] = contactSelected!.id;
        map['reminder'] = "${map['start_date']} ${map['reminder']} ";

        logg(map);

        LzToast.overlay('Sedang Menambah Task...');
        ResHandler res = await taskApi.postTask(map);
        LzToast.dismiss();

        if (!res.status) {
          LzToast.show(res.message);
          forms.reset();
        } else {
          LzToast.show(res.message);
          Navigator.pop(context);
          forms.reset();
        }
        await getTask();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final taskProvider = StateNotifierProvider.autoDispose<TaskProvider, AsyncValue<List<TaskModel>>>((ref) {
  return TaskProvider(ref: ref);
});
