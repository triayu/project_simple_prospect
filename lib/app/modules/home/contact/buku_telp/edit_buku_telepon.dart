import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

class EditPhonebook extends StatelessWidget {
  const EditPhonebook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Buku Telepon',
        canBack: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 25,
            child: Text(
              'Form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: Ei.only(t: 30),
            child: LzFormList(
              style: LzFormStyle(
                  inputLabelFontWeight: FontWeight.w400,
                  type: FormType.topInner,
                  inputBorderColor: ColorConstants.softBlack),
              children: [
                LzForm.input(
                  label: 'Nama',
                  hint: 'Masukkan nama baru',
                ),
                LzForm.input(
                  label: 'Title',
                  hint: 'Masukkan title baru',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Submit',
        color: ColorConstants.softBlack,
        onTap: (val) {},
      ).dark(Colors.white).theme1(),
    );
  }
}
