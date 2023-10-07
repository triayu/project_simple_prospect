import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class EditPesanView extends StatelessWidget {
  const EditPesanView({Key? key}) : super(key: key);

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
              style: LzFormStyle(),
              children: [
                Flexible(
                  child: LzForm.input(
                    label: 'Judul',
                    hint: 'Masukkan Judul pesan',
                    labelStyle: LzFormLabelStyle(),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: LzForm.input(
                    label: 'Pesan',
                    hint: 'Masukkan Pesan',
                    labelStyle: LzFormLabelStyle(),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 30,
                  child: Text(
                    'Lampiran File',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryColor,
                  ),
                  onPressed: () {
                    // ...
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
