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

//Wi Dialog Form (Form) ========================================================
class WiDialogForm extends StatelessWidget {
  final double padding;
  final List<Widget> children;
  final String cancelLabel;
  final Function()? onSubmit;
  final String? tittle;
  const WiDialogForm(
      {Key? key, this.children = const [], this.padding = 25, this.tittle, this.cancelLabel = 'Batal', this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CenterDialog(
        child: Column(children: [
      SlideUp(
        child: ClipRRect(
            borderRadius: Br.radius(5),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: Caa.start,
                children: [
                  tittle != null
                      ? Textr(
                          tittle!.ucwords,
                          padding: Ei.only(t: 20, l: 15, r: 15, b: 15),
                          style: Gfont.autoSizeText(context, FontSizeManager.getSublineFontSize()),
                        )
                      : None(),
                  Padding(
                    padding: Ei.only(l: 15, r: 15, b: 10),
                    child: Column(
                      children: children,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border(top: Br.side(Colors.black.withOpacity(0.1)))),
                    child: Intrinsic(
                      children: List.generate(
                        2,
                        (i) {
                          return Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(left: Br.side(i == 0 ? Colors.transparent : Colors.black12))),
                              child: InkTouch(
                                  onTap: i == 0 ? () => Navigator.pop(context, i) : onSubmit,
                                  padding: Ei.all(15),
                                  color: i == 0 ? Colors.white : Colors.black12,
                                  child: Text(i == 0 ? cancelLabel : 'Simpan',
                                      style: i == 0
                                          ? Gfont.autoSizeText(context, FontSizeManager.getTittleFontSize(),
                                              color: Colors.black)
                                          : Gfont.autoSizeText(context, FontSizeManager.getTittleFontSize(),
                                              color: Colors.black),
                                      textAlign: Ta.center)),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    ]));
  }
}
