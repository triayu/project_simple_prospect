import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class FormTask extends StatelessWidget {
  const FormTask({Key? key}) : super(key: key);

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
          Flexible(
            child: LzForm.input(
              label: 'Title',
              hint: 'Enter your title',
            ),
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
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: LzForm.input(
                  label: 'End Time',
                  hint: 'Enter end time',
                ),
              ),
            ],
          ),
          InkWell(
            child: LzForm.select(
              label: 'Priority',
              hint: 'Select category',
              options: List.generate(4, (i) {
                return Option(option: 'test');
              }),
            ),
          ),
          Flexible(
            child: LzForm.input(
              label: 'Set Time Reminder',
              hint: 'Enter set time reminder',
            ),
          ),
          Flexible(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor,
              ),
              onPressed: () {
                // ...
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
