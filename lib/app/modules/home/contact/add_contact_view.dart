import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

class AddContact extends ConsumerWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final provider = ref.watch(phoneBookPostProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tambah Kontak',
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
                label: 'Nama Kontak',
                hint: 'Masukkan nama kontak',
                // model: provider.forms['name'],
              ),
              LzForm.input(
                label: 'No Telepon',
                hint: ' Masukkan no telpon',
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Tambah Kontak',
        color: ColorConstants.softBlack,
        // onTap: (val) {
        //   provider.post(context);
        // },
      ).dark(Colors.white).theme1(),
    );
  }
}
