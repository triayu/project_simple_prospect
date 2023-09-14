import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'package:simple_prospect/app/widgets/custom_appbar.dart';

class FormContactView extends StatelessWidget {
  const FormContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Form Contact',
          canBack: true,
        ),
        body: LzFormList(
          style: LzFormStyle(),
          children: [
            Row(
              children: [
                Flexible(child: LzForm.input(label: 'Nama', hint: 'Masukkan Nama', labelStyle: LzFormLabelStyle())),
                SizedBox(
                  width: 10,
                ),
                Flexible(child: LzForm.input(label: 'Email', hint: 'Masukkan Email', labelStyle: LzFormLabelStyle())),
              ],
            ),
            LzForm.input(label: 'Password', labelStyle: LzFormLabelStyle()),
          ],
        ));
  }
}
