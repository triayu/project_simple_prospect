import 'package:flutter/material.dart';


class LzElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Key? key;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;

  const LzElevatedButton({
    this.onPressed,
    required this.child,
    this.key,
    this.style,
    this.focusNode,
    this.autofocus,
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      key: key,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus ?? false,
      clipBehavior: clipBehavior ?? Clip.none,
    );
  }
}
