import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/models/profile_model.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';

class ProfileProvider extends StateNotifier<AsyncValue<ProfileModel?>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  ProfileProvider(this.ref) : super(const AsyncValue.loading()) {
    getProfile();
  }

  final forms = LzForm.make(['id', 'first_name', 'email']);

  Future post(BuildContext context) async {
    try {
      final validate = LzForm.validate(
        this.forms,
        required: ['*'],
        singleNotifier: false,
        notifierType: LzFormNotifier.text,
        // ini adalah custom text yang muncul ketika field kosong
        messages: FormMessages(
          required: {
            'first_name': 'First Name Tidak Boleh Kosong',
            'email': 'Email Tidak Boleh Kosong',
          },
        ),
      );

      if (validate.ok) {
        final map = forms.toMap();

        logg(map);

        LzToast.overlay('Menambahkan template pesan...');

        ResHandler res = await profileApi.postProfile(map);

        if (!res.status) {
          LzToast.show(res.message);
        } else {
          LzToast.show('Berhasil Menambahkan Data');
        }

        Navigator.of(context).pop();
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }

  void fillForm(ProfileModel? data) {
    try {
      if (data != null) {
        logg(data, limit: 20000);

        final map = data.toJson();

        logg(map, color: LogColor.blue);
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

    Future editMessageTemplate(BuildContext context, int id) async {
    // Logg
    logg('Update Data');
    try {
      LzToast.overlay('Sedang Mengupdate Data..');
      ResHandler res = await profileApi.updateProfile(forms, id);
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


  Future getProfile() async {
    try {
      state = const AsyncValue.loading();
      ResHandler res = await profileApi.getProfile();

      if (res.status) {
        state = AsyncValue.data(ProfileModel.fromJson(res.data));
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final profileProvider = StateNotifierProvider.autoDispose<ProfileProvider, AsyncValue<ProfileModel?>>((ref) {
  return ProfileProvider(ref);
});
