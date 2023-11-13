import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class EditMessage extends StatelessWidget {
  const EditMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Pesan',
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
                  label: 'Judul',
                  hint: 'Masukkan judul',
                ),
                LzForm.input(
                  label: 'Pesan',
                  hint: 'Masukkan pesan',
                ),
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
