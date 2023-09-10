import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor, titleAndIconColor;
  final dynamic title;
  final double? spacing, elevation;
  final bool canBack, centerTitle;
  final Widget? leading;
  final Function()? onBack;
  final PreferredSizeWidget? bottom;
  final List<Widget> actions;

  const CustomAppBar(
      {Key? key,
      this.backgroundColor,
      this.titleAndIconColor,
      this.title,
      this.centerTitle = false,
      this.spacing = 0,
      this.elevation = 0.5,
      this.canBack = true,
      this.leading,
      this.onBack,
      this.bottom,
      this.actions = const []})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.amber),
      backgroundColor: backgroundColor ?? Colors.black12,
      title: title is String
          ? Text(
              title,
            )
          : title,
      titleSpacing: spacing != 0
          ? spacing
          : !canBack
              ? NavigationToolbar.kMiddleSpacing
              : spacing,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: !canBack
          ? null
          : leading ??
              IconButton(
                  onPressed: () {
                    if (onBack != null) {
                      onBack!();
                    } else {}
                  },
                  icon: Icon(Icons.arrow_back, color: titleAndIconColor ?? Colors.black)),
      actions: actions,
      bottom: bottom,
    );
  }
}
