import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:flutter/material.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import '../../utils/fetch/src/fetch.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';

class ContactProvider extends StateNotifier<AsyncValue<List<ContactModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  ContactProvider(this.ref) : super(const AsyncValue.loading()) {
    getContact();
  }

  bool isLoadMore = false;

  Future getContact() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await contactApi.getListContact();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => ContactModel.fromJson(e)).toList());

        //DeCode ResBody
        Map<String, dynamic> body = res.body;
        //Declare Respon Total To Variables
        total = body['meta']['total'] ?? 0;
        // Set Page To 1
        page = 1;

        logg(total);
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }

  // Pagination
  int page = 1, total = 0;
  // Function Load More

  // Function Load More
  Future getPaginateContact() async {
    if (state.value != null && state.value!.isNotEmpty) {
      if (state.value != null && state.value!.isNotEmpty) {
        final currentData = state.value!;
        state = AsyncValue.data(currentData);
      }
    }

    if (state.value != null && state.value!.length >= total) {
      isLoadMore = false;
      return;
    }

    logg('Load More');
    page += 1;
    isLoadMore = true;
    try {
      ResHandler res = await contactApi.getListContact(page: page);
      if (!res.status && res.message != null) {
        LzToast.show(res.message);
      }

      List data = res.data ?? [];
      state = AsyncValue.data([...state.value ?? [], ...data.map((e) => ContactModel.fromJson(e)).toList()]);
      isLoadMore = false;
    } catch (e, s) {
      Errors.check(e, s);
      isLoadMore = false;
      // On error, set the state to error
      state = AsyncValue.error(e, s);
    }
  }

  Future delContact(int id) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await contactApi.deleteContact(id);

      if (res.status) {
        LzToast.show(res.message);
        getContact();
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  final forms =
      LzForm.make(['first_name', 'last_name', 'email', 'phone_number', 'work_number', 'home_number', 'category']);

  Future post(BuildContext context) async {
    try {
      final validate = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(
            required: {
              'first_name': 'First Name Tidak Boleh Kosong',
              'last_name': 'Last Name Tidak Boleh Kosong',
              'email': 'Email Type Tidak Boleh Kosong',
              'phone_number': 'Phone Number Tidak Boleh Kosong',
              'work_number': 'Work Phone Number',
              'home_number': 'Home Phone Number Tidak Boleh Kosong',
              'category': 'Category Reminder',
            },
            email: {
              'email': 'Email Tidak Valid, masukkan Email Yang Valid',
            },
          ),
          // Jika ingin menambahkan validasi khusus untuk email, bisa menggunakan ini
          email: ['email']);

      if (validate.ok) {
        final map = forms.toMap(except: ['category']);

        map['category_id'] = categoryContactsSelected!.id;

        LzToast.overlay('Menambah Contact ...');

        ResHandler res = await contactApi.createContact(map);

        LzToast.dismiss();

        if (!res.status) {
          LzToast.show(res.message);
        } else {
          LzToast.show('Berhasil Menambahkan Contact');
          await getContact();
        }

        Navigator.of(context).pop;
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  List<CategoryContactModel> categoryContacts = [];
  CategoryContactModel? categoryContactsSelected;

  Future getCategoryContact() async {
    try {
      LzToast.overlay('Loading data...');
      ResHandler res = await contactApi.getCategoryContact();
      LzToast.dismiss();
      if (!res.status) {
        LzToast.show(res.message);
      }
      List data = res.data ?? [];
      categoryContacts = data.map((e) => CategoryContactModel.fromJson(e)).toList();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void setCategory() async {
    // Ini variable yang merepresentasikan model dari formnya
    final form = forms['category']?.notifier;
    // trus di set null jadi option nya tu isinya kosong
    form?.setOption(null);
    // lalu kita get catgory nya dari api

    // kemudian kita tangkap datanya ubah jadikan variable yang return nya List Of Option
    // Biar mau tampil dia di Lzform.select value nya, harus pake option
    List<Option> options = List.generate(categoryContacts.length, (i) {
      return Option(
        option: categoryContacts[i].categoryName ?? '',
        value: categoryContacts[i].id ?? '',
      );
    });
    form?.setOption(null);
    // Lalu terakhir tinggal setIsi dari LzFormSelectnya
    form?.setOptions(options);
  }

  // EDIT CONTACT
  void fillForm(ContactModel? data) {
    try {
      if (data != null) {
        logg(data, limit: 20000);

        final map = data.toJson();

        map.forEach((key, value) {
          if (forms.containsKey(key) && value != null) {
            forms[key]!.controller.text = value.toString();
          }
        });
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future editContact(BuildContext context, int id) async {
    // Logg
    logg('Update Data');
    try {
      LzToast.overlay('Sedang Mengupdate Data..');
      ResHandler res = await contactApi.updateContact(forms, id);
      LzToast.dismiss();
      if (res.status) {
        LzToast.show('Berhasil Mengupdate Data');
        await getContact();
      } else if (res.message != null) {
        LzToast.show(res.message);
      }

      Navigator.of(context).pop;
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final contactProvider = StateNotifierProvider.autoDispose<ContactProvider, AsyncValue<List<ContactModel>>>((ref) {
  return ContactProvider(
    ref,
  );
});
