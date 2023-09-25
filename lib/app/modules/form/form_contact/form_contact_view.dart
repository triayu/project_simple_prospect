import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class FormContactView extends StatelessWidget {
  const FormContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey(), bottomKey = GlobalKey();
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
          Flexible(
            child: LzForm.input(
              label: 'Email',
              hint: 'Your email address',
            ),
          ),
          Flexible(
            child: LzForm.input(
              label: 'Phone number',
              hint: 'Enter phone number',
            ),
          ),
          LzForm.input(
            label: 'Work phone number',
            hint: 'Enter work phone number',
          ),
          LzForm.input(
            label: 'Home phone number',
            hint: 'Enter home phone number',
          ),
          InkWell(
            child: LzForm.select(
              label: 'Category',
              hint: 'Select category',
              options: List.generate(4, (i) {
                return Option(option: 'test');
              }),
              labelStyle: LzFormLabelStyle(),
            ),
          ),
          Flexible(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor,
              ),
              onPressed: () {
                //  ---
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
