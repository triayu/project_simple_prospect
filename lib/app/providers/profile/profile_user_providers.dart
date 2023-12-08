import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart' hide MultipartFile;
import 'package:simple_prospect/app/data/api/api.dart';
import 'package:simple_prospect/app/data/local/shared_preferences.dart';
import 'package:simple_prospect/app/data/models/profile_model.dart';
import 'package:simple_prospect/app/modules/profile/widget/wi_image_preview.dart';
import 'package:simple_prospect/app/utils/fetch/fetch.dart';

class ProfileProvider extends StateNotifier<AsyncValue<ProfileModel?>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  ProfileProvider(this.ref) : super(const AsyncValue.loading()) {
    getProfile();
  }

  final forms = LzForm.make(['id', 'first_name', 'email']);

  Future getProfile() async {
    try {
      state = const AsyncValue.loading();
      ResHandler res = await profileApi.getProfile();
      // write to local storage
      SharedPreferencesHelper.setMap('user', res.data);

      if (res.status) {
        state = AsyncValue.data(ProfileModel.fromJson(res.data));
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  final ImagePicker _picker = ImagePicker();
  File image = File('');
  String filePath = '';

  void pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1500,
      maxHeight: 1500,
      imageQuality: 90,
    );

    if (pickedFile != null) {
      showDialog(context: context, builder: (context) => WidImagePreview(file: File(pickedFile.path))).then((value) {
        if (value != null) {
          image = File(pickedFile.path);
          changeProfilePicture();
        }
      });
      filePath = pickedFile.path;
    }
  }

  //ChangeProfilePicture
  Future changeProfilePicture() async {
    logg('changeProfilePicture');
    try {
      LzToast.overlay('Mengubah Foto Profile...');

      // create file data
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Send File Image with multipart
      MultipartFile file = await MultipartFile.fromFile(filePath, filename: fileName);
      Map<String, dynamic> map = {
        'foto_profile': file,
        'method': "put",
      };

      ResHandler res = await profileApi.updateProfile(map, state.value!.id ?? 0);
      LzToast.dismiss();
      if (res.status) {
        // update
        await getProfile();

        // alert info
        LzToast.show('Foto profil berhasil diperbarui.');
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
