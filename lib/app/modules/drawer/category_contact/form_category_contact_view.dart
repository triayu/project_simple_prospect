import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/providers/contact/category_contacts_provider.dart';
import 'package:simple_prospect/app/widgets/widget.dart';

class FormCategoryContact extends ConsumerWidget {
  final CategoryContactModel? data;
  const FormCategoryContact({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(categoryContactsProvider.notifier);

    if (data != null) {
      provider.fillForm(data!);
    }

    return WiDialogForm(
      onSubmit: () {
        if (data != null) {
          provider.edit(context, data!.id!);
        } else {
          provider.post(context);
        }
      },
      tittle: data != null ? 'Edit Category Contact' : 'Add Category Contact',
      children: [
        LzFormGroup(
          type: FormType.topInner,
          keepLabel: true,
          children: [
            LzForm.input(label: 'Kategori Name', model: provider.forms['name'], hint: "Masukkan Nama Kategori"),
          ],
        )
      ],
    );
  }
}
