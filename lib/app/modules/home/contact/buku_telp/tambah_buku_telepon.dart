import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../../constants/color_constants.dart';

class TambahBukuTelepon extends StatelessWidget {
  const TambahBukuTelepon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ),
              LzForm.input(
                label: 'Title',
                hint: 'Masukkan Title',
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Tambah Data',
        color: ColorConstants.softBlack,
        onTap: (val) {},
      ).dark(Colors.white).theme1(),
    );
  }
}
