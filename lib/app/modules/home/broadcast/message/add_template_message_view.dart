import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/providers/message_template/post_message_template_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../../constants/color_constants.dart';

class AddTemplateMessage extends ConsumerWidget {
  const AddTemplateMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(postMessageTemplateProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tambah Template Pesan',
        canBack: true,
      ),
      body: LzFormList(
        padding: Ei.sym(v: 10, h: 10),
        style: LzFormStyle(
            inputLabelFontWeight: FontWeight.w400, type: FormType.topInner, inputBorderColor: ColorConstants.softBlack),
        children: [
          LzForm.input(label: 'Judul', hint: 'Masukkan judul', model: provider.forms['title']),
          LzForm.input(label: 'Pesan', hint: 'Masukkan pesan', model: provider.forms['message']),

          // Positioned(
          //   top: 10,
          //   left: 30,
          //   child: Text(
          //     'Lampiran File',
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Submit',
        color: ColorConstants.softBlack,
        onTap: (val) {
          // jalankan function post yang sudah kita buat di provider tadi
          provider.post(context);
        },
      ).dark(Colors.white).theme1(),
    );
  }
}
