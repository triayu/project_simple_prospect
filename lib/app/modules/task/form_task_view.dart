import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/task_model.dart';
import 'package:simple_prospect/app/providers/task/task_provider.dart';

import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../constants/color_constants.dart';

class FormTask extends ConsumerWidget {
  final TaskModel? data;
  const FormTask({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(taskProvider.notifier);

    if (data != null) {
      provider.fillForm(data ?? null);
    } else {
      provider.forms.reset();
    }

    return Wrapper(
      child: Scaffold(
          appBar: CustomAppBar(
            title: data != null ? 'Edit Task' : 'Add Task',
            canBack: true,
          ),
          body: LzFormList(
            style: LzFormStyle(
                inputLabelFontWeight: FontWeight.w400,
                type: FormType.topInner,
                inputBorderColor: ColorConstants.softBlack),
            children: [
              LzForm.input(label: 'Title', hint: 'Enter your title', model: provider.forms['title']),
              LzForm.input(
                  maxLength: 1000, maxLines: 2, label: 'Note', hint: 'Enter your note', model: provider.forms['note']),
              LzForm.select(
                label: 'Relate To',
                hint: 'Select category',
                model: provider.forms['relate_to'],
                onTap: (model) async {
                  await provider.getContact();
                  provider.setContact();
                },
                onSelect: (selector) {
                  if (selector.option?.option != null) {
                    provider.contactSelected =
                        provider.contacts.firstWhere((e) => e.userFirstName == selector.option!.option);

                    logg(provider.contactSelected!.userFirstName);
                  }
                },
              ),
              Row(
                children: [
                  Flexible(
                    child: LzForm.input(
                      label: 'Start Date',
                      hint: 'Enter start date',
                      maxLines: 2,
                      model: provider.forms['start_date'],
                      // model: formstart['date'],
                      suffixIcon: La.calendar,
                      onTap: (model) async {
                        DateTime? date = await LzPicker.datePicker(context,
                            minDate: DateTime(
                              DateTime.now().year,
                              DateTime.now().month - 1,
                              DateTime.now().day - 30,
                            ));

                        if (date != null) model.text = date.format();
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: LzForm.input(
                      label: 'End Date',
                      hint: 'Enter end date',
                      maxLines: 2,
                      model: provider.forms['end_date'],
                      suffixIcon: La.calendar,
                      onTap: (model) async {
                        DateTime? date = await LzPicker.datePicker(context,
                            minDate: DateTime(
                              DateTime.now().year,
                              DateTime.now().month - 1,
                              DateTime.now().day - 30,
                            ));

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
                options: List.generate(3, (i) {
                  List<String> priority = ['Low', 'Medium', 'High'];

                  return Option(option: priority[i], value: priority[i]);
                }),
              ),
              LzForm.input(
                label: 'Set Time Reminder',
                hint: 'Enter set time reminder',
                model: provider.forms['reminder'],
                onTap: (model) async {
                  DateTime? date = await LzPicker.timePicker(context);
                  if (date != null) model.text = date.format('HH:mm:ss');

                  logg(model);
                },
              ),
            ],
          ),
          bottomNavigationBar: LzButton(
            text: 'Add Task',
            color: ColorConstants.primaryColor,
            onTap: (val) {
              if (data != null) {
                provider.editTask(context, data!.id!);
              } else {
                provider.post(context);
              }
            },
          ).dark(Colors.white).theme1()),
    );
  }
}
