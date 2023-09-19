// import 'package:example/core.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final String label;
  final TimeOfDay? value;
  final void Function(TimeOfDay)? onChanged;
  final String? Function(String?)? validator;
  TimePicker({Key? key, required this.label, this.value, this.onChanged, this.validator}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TextEditingController controller;
  TimeOfDay? selectedDate;

  @override
  void initState() {
    super.initState();
    var initialValue;
    controller = TextEditingController(text: initialValue);
  }

  String get initialValue {
    var hh = widget.value!.hour.toString().padLeft(2, "0");
    var mm = widget.value!.minute.toString().padLeft(2, "0");
    return "$hh:$mm";
  }

  String get formattedValue {
    var hh = selectedDate?.hour.toString().padLeft(2, "0");
    var mm = selectedDate?.minute.toString().padLeft(2, "0");
    return "$hh:$mm";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child ?? Container(),
            );
          },
        );

        selectedDate = pickedTime;
        controller.text = formattedValue;
        widget.onChanged?.call(selectedDate!);
        setState(() {});
      },
      child: TextFormField(
        controller: controller,
        maxLength: 20,
        validator: widget.validator,
        enabled: false,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          suffixIcon: const Icon(
            Icons.lock_clock,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
