import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/message_template_model.dart';
import 'package:simple_prospect/app/providers/message_template/post_message_template_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class AddTemplateMessage extends ConsumerWidget {
  final MessageTemplateModel? data;
  const AddTemplateMessage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(postMessageTemplateProvider);

    if (data != null) {
      provider.fillForm(data ?? null);
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: data != null ? 'Edit Message Template' : 'Tambah Template Pesan',
        canBack: true,
      ),
      body: LzFormList(
        padding: Ei.sym(v: 10, h: 10),
        style: LzFormStyle(
            inputLabelFontWeight: FontWeight.w400, type: FormType.topInner, inputBorderColor: ColorConstants.softBlack),
        children: [
          LzForm.input(label: 'Judul', hint: 'Masukkan judul', model: provider.forms['title']),
          LzForm.input(label: 'Pesan', hint: 'Masukkan pesan', model: provider.forms['message']),
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
              backgroundColor: Colors.white,
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
        text: 'Add Message Template',
        color: ColorConstants.primaryColor,
        onTap: (val) {
          if (data != null) {
            provider.editMessageTemplate(context, data!.id!);
          } else {
            provider.post(context);
          }
        },
      ).dark(Colors.white).theme1(),
    );
  }
}
