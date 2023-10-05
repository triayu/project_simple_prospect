part of widget;

class LzSlidebar extends StatelessWidget {
  /// ```dart
  /// int active = 1;
  /// LzSlidebar(active: active, spacing: 10, size: (int i) => [i == active ? 20 : 5, 5]),
  /// ```
  const LzSlidebar(
      {super.key,
      this.length = 3,
      this.size,
      this.active = 0,
      this.color,
      this.activeColor,
      this.radius = 5.0,
      this.spacing = 7,
      this.position = Caa.center});

  final int length;

  /// size = [width, height]
  final List<double> Function(int index)? size;
  final int active;
  final Color? activeColor, color;
  final double radius, spacing;
  final CrossAxisAlignment position;

  @override
  Widget build(BuildContext context) {
    double width = 10;
    double height = 10;

    return Row(
      crossAxisAlignment: position,
      mainAxisSize: Mas.min,
      children: List.generate(length, (i) {
        if (size != null) {
          List<double> size = this.size!(i);
          width = size.isNotEmpty ? size[0] : 10;
          height = size.length > 1 ? size[1] : 10;
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: Ei.only(r: spacing),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: active == i ? (activeColor ?? Theme.of(context).primaryColor) : (color ?? Colors.grey),
            borderRadius: BorderRadius.circular(radius),
          ),
        );
      }),
    );
  }
}
