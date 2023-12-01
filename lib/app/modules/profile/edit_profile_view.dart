import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/profile_model.dart';
import 'package:simple_prospect/app/providers/profile/profile_user_providers.dart';
import '../../constants/color_constants.dart';
import '../../widgets/custom_appbar.dart';

class EditProfileView extends ConsumerWidget {
  final ProfileModel? data;
  const EditProfileView({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(profileProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
        canBack: true,
      ),
      body: LzFormList(
        padding: Ei.sym(v: 10, h: 10),
        style: LzFormStyle(
            inputLabelFontWeight: FontWeight.w400, type: FormType.topInner, inputBorderColor: ColorConstants.softBlack),
        children: [
          Text(
            'Lampiran File',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          // PILIH FILE ==========
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                PlatformFile file = result.files.first;
                print('Picked file: ${file.name}');
              } else {}
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15),
                Icon(
                  Ti.fileDownload,
                  size: 30,
                  color: Colors.black,
                ),
                SizedBox(height: 15),
                Text(
                  'Klik disini untuk upload file',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Edit Profile',
        color: ColorConstants.primaryColor,
      ).dark(Colors.white).theme1(),
    );
  }
}
