import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../data/models/message_model.dart';
import '../../../providers/message/post_message_provider.dart';

class AddContact extends ConsumerWidget {
  final MessageModel? data;
  const AddContact({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(postMessageProvider);

    if (data != null) {
      provider.fillForm(data ?? null);
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: data != null ? 'Edit Contact' : 'Tambah Kontak',
        canBack: true,
      ),
      body: Stack(
        children: [
          LzFormList(
            style: LzFormStyle(
                inputLabelFontWeight: FontWeight.w400,
                type: FormType.topInner,
                inputBorderColor: ColorConstants.softBlack),
            children: [
              LzForm.input(label: 'Name', hint: 'Masukkan nama', model: provider.forms['name'], maxLines: 3),
              LzForm.input(
                  label: 'Phone Number',
                  hint: 'Masukkan Nomor Telephone',
                  model: provider.forms['phone_number'],
                  maxLines: 3),
              LzForm.input(
                  label: 'Keterangan', hint: 'Masukkan Keterangan', model: provider.forms['message'], maxLines: 3),
            ],
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Tambah Kontak',
        color: ColorConstants.softBlack,
        onTap: (val) {
          if (data != null) {
            provider.editMessage(context, data!.id!);
          } else {
            logg('tmbah');
            provider.post(context);
          }
        },
      ).dark(Colors.white).theme1(),
    );
  }
}
