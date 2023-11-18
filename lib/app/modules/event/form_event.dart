import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/providers/event/event_post_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../constants/color_constants.dart';

class FormEvent extends ConsumerWidget {
  const FormEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(eventPostProvider);
    

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
              model: provider.forms['title'],
            ),
            LzForm.input(
              label: 'Meeting With',
              hint: 'Enter meeting with',
              model: provider.forms['meeting_with'],
            ),
            LzForm.select(
              label: 'Meeting Type',
              hint: 'Select category',
              model: provider.forms['meeting_type'],
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
                    suffixIcon: La.calendar,
                    onTap: (model) async {
                      DateTime? date = await LzPicker.datePicker(context);
                      if (date != null) model.text = date.format();
                    },
                  ),
                ),
              ],
            ),
            LzForm.input(
              label: 'Location',
              hint: 'Enter location',
              model: provider.forms['location'],
            ),
            LzForm.input(
              label: 'Set Time Reminder',
              hint: 'Enter set time reminder',
              model: provider.forms['set_time_reminder'],
              suffixIcon: La.clock,
              onTap: (model) async {
                DateTime? date = await LzPicker.timePicker(context);
                if (date != null) model.text = date.format('HH:mm a');

                logg(model);
              },
            ),
            LzForm.input(
              label: 'Note',
              hint: 'Enter note event',
              model: provider.forms['note'],
            ),
          ],
        ),
      
      
        bottomNavigationBar: LzButton(
          text: 'Add Event',
          color: ColorConstants.softBlack,
          onTap: (val) {
            provider.post(context);
          },
        ).dark(Colors.white).theme1());
  }
}
