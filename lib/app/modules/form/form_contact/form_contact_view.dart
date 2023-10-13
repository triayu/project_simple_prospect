import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class FormContactView extends StatelessWidget {
  const FormContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tambah Kontak',
        canBack: true,
      ),
      body: LzFormList(
        style: LzFormStyle(
            inputLabelFontWeight: FontWeight.w400, type: FormType.topInner, inputBorderColor: ColorConstants.softBlack),
        children: [
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'First name',
                  hint: 'Enter first name',
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: LzForm.input(
                  label: 'Last name',
                  hint: 'Enter last name',
                ),
              ),
            ],
          ),
          LzForm.input(
            label: 'Email',
            hint: 'Your email address',
          ),
          LzForm.input(
            label: 'Phone number',
            hint: 'Enter phone number',
          ),
          LzForm.input(
            label: 'Work phone number',
            hint: 'Enter work phone number',
          ),
          LzForm.input(
            label: 'Home phone number',
            hint: 'Enter home phone number',
          ),
          LzForm.select(
            label: 'Category',
            hint: 'Select category',
            options: List.generate(4, (i) {
              return Option(option: 'test');
            }),
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
