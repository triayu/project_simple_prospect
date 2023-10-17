import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class FormTask extends StatelessWidget {
  const FormTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formstart = LzForm.make(['date']);
    final formend = LzForm.make(['date']);

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Add Task',
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
            ),
            LzForm.input(
              label: 'Note',
              hint: 'Enter your note',
            ),
            LzForm.input(
              label: 'Date',
              hint: 'Enter date',
            ),
            Row(
              children: [
                Flexible(
                  child: LzForm.input(
                    label: 'Start Time',
                    hint: 'Enter start time',
                    model: formstart['date'],
                    suffixIcon: La.calendar,
                    onTap: (model) async {
                      DateTime? date = await LzPicker.datePicker(context);
                      if (date != null) model.text = date.format();
                    },
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: LzForm.input(
                    label: 'End Time',
                    hint: 'Enter end time',
                    model: formend['date'],
                    suffixIcon: La.calendar,
                    onTap: (model) async {
                      DateTime? date = await LzPicker.datePicker(context);
                      if (date != null) model.text = date.format();
                    },
                  ),
                ),
              ],
            ),
            LzForm.select(
              label: 'Priority',
              hint: 'Select category',
              options: List.generate(4, (i) {
                return Option(option: 'test');
              }),
            ),
            LzForm.input(
              label: 'Set Time Reminder',
              hint: 'Enter set time reminder',
            ),
          ],
        ),
        bottomNavigationBar: LzButton(
          text: 'Add Task',
          color: ColorConstants.softBlack,
          onTap: (val) {},
        ).dark(Colors.white).theme1());
  }
}
