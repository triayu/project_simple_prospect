import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String title;
  final String? hint;
  final IconData? icon;
  final IconData? showPasswordIcon;
  final FontWeight? fontWeight;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Function()? onTapShowPassword;

  const TextInput({
    Key? key,
    required this.title,
    this.hint,
    this.icon,
    this.showPasswordIcon,
    this.fontWeight,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.onTapShowPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != ''
            ? Text(
                title,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: fontWeight,
                  color: const Color.fromARGB(255, 15, 104, 177),
                ),
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: TextFormField(
            validator: validator,
            onChanged: onChanged,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: icon != null ? Icon(icon) : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: const Color.fromARGB(255, 15, 104, 177)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: const Color.fromARGB(255, 15, 104, 177)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              isDense: true,
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
