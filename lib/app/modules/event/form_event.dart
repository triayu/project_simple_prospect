import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/modules/event/widget/gmaps.dart';
import 'package:simple_prospect/app/providers/event/event_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';
import '../../constants/color_constants.dart';
import '../../data/models/event_model.dart';

class FormEvent extends ConsumerWidget {
  // data yang diterima dari list bentuk nya event model
  final EventModel? data;
  const FormEvent({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(eventProvider.notifier);

    if (data != null) {
      provider.fillForm(data ?? null);
    } else {
      provider.forms.reset();
    }

    return Scaffold(
        appBar: CustomAppBar(
          title: data != null ? 'Edit Event' : 'Add Event',
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
                    maxLines: 2,
                    onTap: (model) async {
                      DateTime? date = await LzPicker.datePicker(context);
                      if (date != null) {
                        provider.forms['start_date']?.notifier.setText(date.format('yyyy-MM-dd'));
                      }
                      ;
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
                      DateTime? date = await LzPicker.datePicker(context);
                      if (date != null) {
                        provider.forms['end_date']?.notifier.setText(date.format('yyyy-MM-dd'));
                      }
                    },
                  ),
                ),
              ],
            ),
            LzForm.select(
              onTap: (selector) async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return GmapsLocation();
                    }).then((value) {
                  if (value != null) {
                    logg(value, color: LogColor.red);
                  }
                });
              },
              label: 'Location',
              hint: 'Enter location',
              model: provider.forms['location'],
            ),
            LzForm.input(
              label: 'Set Time Reminder',
              hint: 'Enter set time reminder',
              model: provider.forms['reminder'],
              suffixIcon: La.clock,
              onTap: (model) async {
                DateTime? date = await LzPicker.timePicker(context);
                if (date != null) {
                  provider.forms['reminder']?.notifier.setText(date.format('HH:mm:ss'));
                }
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
          color: ColorConstants.primaryColor,
          onTap: (val) {
            // Tinggal kasi kondisi dsni kalau ada data yg diterima berati dia update
            if (data != null) {
              provider.editEvent(context, data!.id!);
            } else {
              provider.postEvent(context);
            }
          },
        ).dark(Colors.white).theme1());
  }
}
