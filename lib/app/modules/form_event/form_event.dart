import 'package:flutter/material.dart';

import '../../text_form_field/text_form_field.dart';
import '../../validator/validator.dart';

class FormEvent extends StatefulWidget {
  const FormEvent({Key? key}) : super(key: key);

  @override
  State<FormEvent> createState() => _FormEventState();
}

class _FormEventState extends State<FormEvent> {
  final _formState = GlobalKey<FormState>();

  Map<String, dynamic> values = {
    "title": TextEditingController(),
    "meetingwith": TextEditingController(),
    "meetingtype": TextEditingController(),
    "noteevent": TextEditingController(),
  };

  List<Map<String, String>> listArray = [];

  @override
  void initState() {
    super.initState();
  }

  void onTap() {
    if (_formState.currentState!.validate()) {
      String titleText = values["title"]?.text ?? '';
      String meetingwithtText = values["meetingwith"]?.text ?? '';
      String meetingtypeText = values["meetingtype"]?.text ?? '';
      String noteeventText = values["noteevent"]?.text ?? '';

      listArray.add({
        'title': titleText,
        'meetingwith': meetingwithtText,
        'meetingtype': meetingtypeText,
        'noteevent': noteeventText,
      });

      _formState.currentState?.reset();

      // Navigator.push(
      //   context,
      //   // MaterialPageRoute(
      //   //   builder: (context) => NextPage(
      //   //     values: listArray,
      //   //   ),
      //   // ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
          child: Form(
            key: _formState,
            child: Column(
              children: [
                TextFieldView(
                  label: "Title",
                  value: values["title"]?.text ?? '',
                  validator: Validator.required,
                  onChanged: (value) {
                    values["title"]?.text = value;
                  },
                ),
                TextFieldView(
                  label: "Meeting With",
                  value: values["meetingwith"]?.text ?? '',
                  validator: Validator.required,
                  onChanged: (value) {
                    values["meetingwith"]?.text = value;
                  },
                ),
                TextFieldView(
                  label: "Meeting Type",
                  value: values["meetingtype"]?.text ?? '',
                  validator: Validator.required,
                  onChanged: (value) {
                    values["meetingtype"]?.text = value;
                  },
                ),
                TextFieldView(
                  label: "Note Event ",
                  value: values["noteevent"]?.text ?? '',
                  validator: Validator.required,
                  onChanged: (value) {
                    values["noteevent"]?.text = value;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onTap,
                    child: Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
