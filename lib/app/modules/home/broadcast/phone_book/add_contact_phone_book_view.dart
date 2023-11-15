import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/providers/phone_book/post_phone_book_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../../constants/color_constants.dart';

class AddContactPhoneBook extends ConsumerWidget {
  const AddContactPhoneBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(phoneBookPostProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Contact Phone Book',
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
                hint: 'Masukkan nama phone book',
                model: provider.forms['name'],
              ),
              LzForm.input(
                label: 'No Telephone',
                hint: 'Masukkan No Telpn',
                model: provider.forms['phone_number'],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Tambah Kontak',
        color: ColorConstants.softBlack,
        onTap: (val) {
          provider.post(context);
        },
      ).dark(Colors.white).theme1(),
    );
  }
}
