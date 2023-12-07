import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class FormUser extends ConsumerWidget {
  final String? name;
  final int index;
  const FormUser({super.key, this.name, this.index = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // notifier.forms.fill({'name': name});

    return Wrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update User'),
        ),
        body: LzListView(
          children: [
            // LzForm.input(label: 'Name', hint: 'Enter your name', model: notifier.forms['name'], autofocus: true),
          ],
        ),
        bottomNavigationBar: LzButton(
          text: 'Submit',
          onTap: (state) async {
            // bool ok = await notifier.update(index);
            // if (ok && context.mounted) {
            //   Navigator.of(context).pop();
            // }
          },
        ).theme1(),
      ),
    );
  }
}
