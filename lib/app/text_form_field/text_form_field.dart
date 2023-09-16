import 'package:flutter/material.dart';

class TextFieldView extends StatefulWidget {
  final String label;
  final String? value;
  final String? Function(String?)? validator;
  final String? helperText;
  final TextEditingController? controller;
  final TextInputType? keyboard;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const TextFieldView({
    Key? key,
    required this.label,
    required this.value,
    required this.validator,
    this.controller,
    this.helperText,
    this.keyboard,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TextFieldView> createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      initialValue: widget.value,
      validator: widget.validator,
      maxLength: 20,
      controller: widget.controller,
      keyboardType: widget.keyboard,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        // suffixIcon: const Icon(
        //   Icons.text_format,
        // ),
        helperText: widget.helperText ?? '',
        hintStyle: TextStyle(
          fontSize: 10,
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
