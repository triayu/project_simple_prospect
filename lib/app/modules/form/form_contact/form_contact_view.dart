import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/providers/contact/contact_post_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';

class FormContactView extends ConsumerWidget {
  const FormContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(contactPostProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tambah Kontak',
        canBack: true,
      ),
      body: LzFormList(
        style: LzFormStyle(
            inputLabelFontWeight: FontWeight.w400, type: FormType.topInner, inputBorderColor: ColorConstants.softBlack),
        children: [
          Row(
            children: [
              Flexible(
                child: LzForm.input(label: 'First name', hint: 'Enter first name', model: provider.forms['first_name']),
              ),
              SizedBox(width: 10),
              Flexible(
                child: LzForm.input(label: 'Last name', hint: 'Enter last name', model: provider.forms['last_name']),
              ),
            ],
          ),
          LzForm.input(label: 'Email', hint: 'Your email address', model: provider.forms['email']),
          LzForm.input(label: 'Phone number', hint: 'Enter phone number', model: provider.forms['phone_number']),
          LzForm.input(
              label: 'Work phone number', hint: 'Enter work phone number', model: provider.forms['work_phone_number']),
          LzForm.input(
              label: 'Home phone number', hint: 'Enter home phone number', model: provider.forms['home_phone_number']),
          LzForm.select(
            label: 'Category',
            hint: 'Select category',
            model: provider.forms['category'],
            // ini untuk ketika dia kamu tap, bakal jalnin apa (ontap) yg dipake
            onTap: (ctrl) async {
              await provider.getCategoryContact();
              provider.setCategory();
            },
            //
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: 'Tambah Kontak',
        color: ColorConstants.softBlack,
        onTap: (val) {
          provider.post(context);
        },
      ).dark(Colors.white).theme1(),
    );
  }
}
