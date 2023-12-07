import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/providers/contact/contact_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class FormContactView extends ConsumerWidget {
  final ContactModel? data;
  const FormContactView({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(contactProvider.notifier);

    if (data != null) {
      provider.fillForm(data ?? null);
    } else {
      provider.forms.reset();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: data != null ? 'Edit Contact' : 'Tambah Kontak',
        canBack: true,
      ),
      body: LzFormList(
        style: LzFormStyle(
            inputLabelFontWeight: FontWeight.w400, type: FormType.topInner, inputBorderColor: ColorConstants.softBlack),
        children: [
          LzForm.input(label: 'First name', hint: 'Enter first name', model: provider.forms['first_name'], maxLines: 3),
          LzForm.input(label: 'Last name', hint: 'Enter last name', model: provider.forms['last_name'], maxLines: 3),
          LzForm.input(
            label: 'Email',
            hint: 'Your email address',
            model: provider.forms['email'],
          ),
          LzForm.input(
              keyboard: Tit.number,
              label: 'Phone number',
              hint: 'Enter phone number',
              model: provider.forms['phone_number']),
          LzForm.input(
              keyboard: Tit.number,
              label: 'Work phone number',
              hint: 'Enter work phone number',
              model: provider.forms['work_number']),
          LzForm.input(
              keyboard: Tit.number,
              label: 'Home phone number',
              hint: 'Enter home phone number',
              model: provider.forms['home_number']),
          LzForm.select(
            label: 'Category',
            hint: 'Select category',
            model: provider.forms['category'],
            // ini untuk ketika dia kamu tap, bakal jalnin apa (ontap) yg dipake
            onTap: (ctrl) async {
              await provider.getCategoryContact();
              provider.setCategory();
            },
            onChange: (value) {
              logg(value);
            },
            onSelect: (selector) {
              if (selector.option?.option != null) {
                provider.categoryContactsSelected =
                    provider.categoryContacts.firstWhere((e) => e.categoryName == selector.option!.option);

                logg(provider.categoryContactsSelected!.id);
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Tambah Kontak',
        color: ColorConstants.softBlack,
        onTap: (val) {
          if (data != null) {
            provider.editContact(context, data!.id!);
          } else {
            provider.post(context);
          }
        },
      ).dark(Colors.white).theme1(),
    );
  }
}
