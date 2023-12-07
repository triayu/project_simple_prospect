part of widget;

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

class TextInputTransparent extends StatelessWidget {
  final String? hint;
  final TextInputType? keyboard;
  final TextInputAction? inputAction;
  final Function(String)? onSubmit, onChanged;
  final bool autofocus, enabled, obsecure, showMaxLength;
  final FocusNode? node;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final int? maxLength, maxLines;
  final List<TextInputFormatter> formatters;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle, hintStyle;

  TextInputTransparent(
      {this.hint,
      this.keyboard,
      this.inputAction,
      this.onSubmit,
      this.obsecure = false,
      this.onChanged,
      this.autofocus = false,
      this.showMaxLength = false,
      this.node,
      this.controller,
      this.textAlign,
      this.enabled = true,
      this.maxLength = 1800,
      this.formatters = const [],
      this.contentPadding,
      this.maxLines,
      this.textStyle,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    Widget textField = TextField(
      style: textStyle ?? Gfont.fs16,
      keyboardType: keyboard,
      textInputAction: inputAction,
      onSubmitted: onSubmit,
      onChanged: onChanged,
      autofocus: autofocus,
      focusNode: node,
      obscureText: obsecure,
      enabled: enabled,
      textAlign: textAlign ?? TextAlign.start,
      controller: controller,
      maxLines: maxLines == null ? 1 : maxLines,
      minLines: 1,
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)]..addAll(formatters),
      decoration: InputDecoration(
        contentPadding: contentPadding ?? Ei.sym(v: 5),
        hintText: hint,
        hintStyle: hintStyle ?? Gfont.fs16,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );

    return textField;
  }
}
