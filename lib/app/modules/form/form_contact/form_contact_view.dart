import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

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
                  labelStyle: LzFormLabelStyle(),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: LzForm.input(
                  label: 'Last name',
                  hint: 'Enter last name',
                  labelStyle: LzFormLabelStyle(),
                ),
              ),
            ],
          ),
          Flexible(
            child: LzForm.input(
              label: 'Email',
              hint: 'Your email address',
              labelStyle: LzFormLabelStyle(),
            ),
          ),
          Flexible(
            child: LzForm.input(
              label: 'Phone number',
              hint: 'Enter phone number',
              labelStyle: LzFormLabelStyle(),
            ),
          ),
          Flexible(
            child: LzForm.input(
              label: 'Work phone number',
              hint: 'Enter work phone number',
              labelStyle: LzFormLabelStyle(),
            ),
          ),
          Flexible(
            child: LzForm.input(
              label: 'Home phone number',
              hint: 'Enter home phone number',
              labelStyle: LzFormLabelStyle(),
            ),
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                final options = ['Prospect', 'Team', 'Clients', 'Other'].options();
                DropX.show(bottomKey, options: options);
              },
              child: LzForm.select(
                label: 'Category',
                hint: 'Select category',
                labelStyle: LzFormLabelStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
