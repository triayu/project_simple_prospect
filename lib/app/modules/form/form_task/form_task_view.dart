import 'package:flutter/material.dart';

import '../../../text_form_field/text_form_field.dart';
import '../../../validator/validator.dart';
import '../timepicker.dart';

class FormTask extends StatefulWidget {
  const FormTask({Key? key}) : super(key: key);

  @override
  State<FormTask> createState() => _FormTaskState();
}

class _FormTaskState extends State<FormTask> {
  final _formState = GlobalKey<FormState>();

  Map<String, dynamic> values = {
    "title": TextEditingController(),
    "meetingwith": TextEditingController(),
    "meetingtype": TextEditingController(),
    "starttime": '',
    "endtime": '',
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
      String starttime = values["starttimee"];
      String endtime = values["endtime"];
      String noteeventText = values["noteevent"]?.text ?? '';

      listArray.add({
        'title': titleText,
        'meetingwith': meetingwithtText,
        'meetingtype': meetingtypeText,
        'starttime': starttime,
        'endtime': endtime,
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

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = TimeOfDay.fromDateTime(dateTime).format(context);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Pusatkan judul
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
                TimePicker(
                  label: "Start Time",
                  value: TimeOfDay.now(),
                  validator: Validator.required,
                  onChanged: (p0) {
                    values['startime'] = formatTimeOfDay(p0);
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
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onTap,
                      child: Text("Submit"),
                    ),
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
