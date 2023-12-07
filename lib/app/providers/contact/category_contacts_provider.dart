import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';

class CategoryContactsProvider extends StateNotifier<AsyncValue<List<CategoryContactModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;
  CategoryContactsProvider({
    this.ref,
  }) : super(const AsyncValue.loading()) {
    getCategoryContact();
  }

  Future getCategoryContact() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await contactApi.getCategoryContact();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => CategoryContactModel.fromJson(e)).toList());

        //DeCode ResBody
        Map<String, dynamic> body = res.body;
        //Declare Respon Total To Variables
        total = body['meta']['total'] ?? 0;
        // Set Page To 1
        page = 1;
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }

  // Pagination
  int page = 1, total = 0;
  bool isLoadMore = false;
  Future getCategoryContactPaginate() async {
    try {
      if (state.value != null && state.value!.isNotEmpty) {
        if (state.value != null && state.value!.isNotEmpty) {
          final currentData = state.value!;
          state = AsyncValue.data(currentData);
        }
      }

      if (state.value != null && state.value!.length >= total) {
        isLoadMore = false;
        logg('No More Data');
        return;
      }

      logg('Load More');
      page += 1;
      isLoadMore = true;
      ResHandler res = await contactApi.getCategoryContact(page: page);

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data([...state.value ?? [], ...data.map((e) => CategoryContactModel.fromJson(e)).toList()]);
        isLoadMore = false;
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }

  Future delCategoryContact(int id) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await contactApi.deleteCategoryContact(id);

      if (res.status) {
        LzToast.show(res.message);
        getCategoryContact();
      } else {
        LzToast.show(res.message);
        getCategoryContact();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  final forms = LzForm.make([
    'name',
  ]);

  Future post(BuildContext context) async {
    logg('Post Category Contact');
    try {
      final validate = LzForm.validate(
        forms,
        required: ['*'],
        singleNotifier: false,
        notifierType: LzFormNotifier.text,
        messages: FormMessages(
          required: {
            'name': ' Nama Tidak Boleh Kosong',
          },
        ),
        // Jika ingin menambahkan validasi khusus untuk email, bisa menggunakan ini
      );

      if (validate.ok) {
        final map = forms.toMap();

        LzToast.overlay('Menambah Category ...');

        ResHandler res = await contactApi.createCategoryContact(map);

        LzToast.dismiss();

        if (!res.status) {
          forms.reset();
          LzToast.show(res.message);
          await getCategoryContact();
          Navigator.pop(context);
        } else {
          forms.reset();
          LzToast.show('Berhasil Menambahkan Category Contact');
          await getCategoryContact();
          Navigator.pop(context);
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future edit(BuildContext context, int id) async {
    logg(id);
    try {
      final validate = LzForm.validate(
        forms,
        required: ['*'],
        singleNotifier: false,
        notifierType: LzFormNotifier.text,
        messages: FormMessages(
          required: {
            'name': ' Nama Tidak Boleh Kosong',
          },
        ),
        // Jika ingin menambahkan validasi khusus untuk email, bisa menggunakan ini
      );

      if (validate.ok) {
        final map = forms.toMap();
        logg(map);
        LzToast.overlay('Mengedit Category ...');

        ResHandler res = await contactApi.updateCategoryContact(map, id);

        LzToast.dismiss();

        if (!res.status) {
          forms.reset();
          LzToast.show(res.message);
          await getCategoryContact();
          Navigator.pop(context);
        } else {
          forms.reset();
          LzToast.show('Berhasil Mengedit Category Contact');
          await getCategoryContact();
          Navigator.pop(context);
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void fillForm(CategoryContactModel categoryContactModel) async {
    logg('Fill Form');
    forms['name']!.controller.text = categoryContactModel.categoryName ?? '';
  }
}

final categoryContactsProvider =
    StateNotifierProvider.autoDispose<CategoryContactsProvider, AsyncValue<List<CategoryContactModel>>>((ref) {
  return CategoryContactsProvider(
    ref: ref,
  );
});
