import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class TambahPesanView extends StatelessWidget {
  const TambahPesanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Form Contact',
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
                Container(
                  height: 100,
                  margin: Ei.only(h: 5, t: 5, b: 20),
                  padding: Ei.only(h: 10, t: 20, b: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Ti.fileDownload,
                        size: 30,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Klik disini untuk upload File',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
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