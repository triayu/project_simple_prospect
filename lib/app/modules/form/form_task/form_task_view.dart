import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/providers/task/task_post_provider.dart';

import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class FormTask extends ConsumerWidget {
  const FormTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(taskPostProvider);

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
            LzForm.input(label: 'Title', hint: 'Enter your title', model: provider.forms['title']),
            LzForm.input(label: 'Note', hint: 'Enter your note', model: provider.forms['note']),
            LzForm.select(
              label: 'Relate To',
              hint: 'Select category',
              model: provider.forms['relate_to'],
              options: List.generate(4, (i) {
                return Option(option: 'test');
              }),
            ),
            Row(
              children: [
                Flexible(
                  child: LzForm.input(
                    label: 'Start Date',
                    hint: 'Enter start date',
                    model: provider.forms['start_date'],
                    // model: formstart['date'],
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
                    label: 'End Date',
                    hint: 'Enter end date',
                    model: provider.forms['end_date'],
                    // model: formend['date'],
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
              model: provider.forms['priority'],
              options: List.generate(4, (i) {
                return Option(option: 'test');
              }),
            ),
            LzForm.input(
              label: 'Set Time Reminder',
              hint: 'Enter set time reminder',
              model: provider.forms['set_time_reminder'],
              onTap: (model) async {
                DateTime? date = await LzPicker.timePicker(context);
                if (date != null) model.text = date.format('HH:mm a');

                logg(model);
              },
            ),
          ],
        ),
        bottomNavigationBar: LzButton(
          text: 'Add Task',
          color: ColorConstants.softBlack,
          onTap: (val) {
            provider.post(context);
          },
        ).dark(Colors.white).theme1());
  }
}
