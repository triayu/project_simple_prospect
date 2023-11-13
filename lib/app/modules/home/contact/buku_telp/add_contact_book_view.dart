import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/providers/phone_book/phone_book_provider.dart';
import 'package:simple_prospect/app/providers/phone_book/post_phone_book_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../../constants/color_constants.dart';

class AddContactBook extends ConsumerWidget {
  const AddContactBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(phoneBookPostProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Form Tambah Buku Telpn',
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
              LzForm.input(
                label: 'Nama',
                hint: 'Masukkan Nama',
                model: provider.forms['name'],
              ),
              LzForm.input(
                label: 'Title',
                hint: 'Masukkan No Telpon',
                model: provider.forms['phone_number'],
              ),
              LzForm.input(
                label: 'Email',
                hint: 'Masukkan Email',
                model: provider.forms['email'],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Tambah Data',
        color: ColorConstants.softBlack,
        onTap: (val) {
          provider.post(context);
        },
      ).dark(Colors.white).theme1(),
    );
  }
}
