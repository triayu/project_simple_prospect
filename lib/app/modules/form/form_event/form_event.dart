import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class FormEvent extends StatelessWidget {
  const FormEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final key = GlobalKey(), bottomKey = GlobalKey();

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Add Event',
          canBack: true,
        ),
        body: LzFormList(
          style: LzFormStyle(
              inputLabelFontWeight: FontWeight.w400,
              type: FormType.topInner,
              inputBorderColor: ColorConstants.softBlack),
          children: [
            LzForm.input(
              label: 'Title',
              hint: 'Enter your title',
              labelStyle: LzFormLabelStyle(),
            ),
            LzForm.input(
              label: 'Meeting With',
              hint: 'Enter meeting with',
              labelStyle: LzFormLabelStyle(),
            ),
            LzForm.select(
              label: 'Meeting Type',
              hint: 'Select category',
              options: List.generate(4, (i) {
                return Option(option: 'test');
              }),
              labelStyle: LzFormLabelStyle(),
            ),
            Row(
              children: [
                Flexible(
                  child: LzForm.input(
                    label: 'Start Time',
                    hint: 'Enter start time',
                    labelStyle: LzFormLabelStyle(),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: LzForm.input(
                    label: 'End Time',
                    hint: 'Enter end time',
                    labelStyle: LzFormLabelStyle(),
                  ),
                ),
              ],
            ),
            LzForm.input(
              label: 'Location',
              hint: 'Enter locationr',
              labelStyle: LzFormLabelStyle(),
            ),
            LzForm.input(
              label: 'Set Time Reminder',
              hint: 'Enter set time reminder',
              labelStyle: LzFormLabelStyle(),
            ),
            LzForm.input(
              label: 'Note Event',
              hint: 'Enter note event',
              labelStyle: LzFormLabelStyle(),
            ),
          ],
        ),
        bottomNavigationBar: LzButton(
          text: 'Add Event',
          color: ColorConstants.softBlack,
          onTap: (val) {},
        ).dark(Colors.white).theme1());
  }
}
