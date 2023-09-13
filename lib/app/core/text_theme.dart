import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
// import 'package:riverpod_example/app/constants/color_constants.dart';

TextStyle gfont = GoogleFonts.getFont(
  "Open Sans",
  fontSize: 15.5,
  color: ColorConstants.textPrimaryColor,
);

TextStyle gfontBold =
    GoogleFonts.getFont("Open Sans", fontSize: 15.5, color: ColorConstants.primaryColor, fontWeight: FontWeight.bold);

class Gfont {
  // size
  static final fs12 = gfont.copyWith(fontSize: 12);
  static final fs13 = gfont.copyWith(fontSize: 13);
  static final fs14 = gfont.copyWith(fontSize: 14);
  static final fs15 = gfont.copyWith(fontSize: 15);
  static final fs16 = gfont.copyWith(fontSize: 16);
  static final fs17 = gfont.copyWith(fontSize: 17);
  static final fs18 = gfont.copyWith(fontSize: 18);
  static final fs19 = gfont.copyWith(fontSize: 19);
  static final fs20 = gfont.copyWith(fontSize: 20);

  static fs(double size) => gfont.copyWith(fontSize: size);
  static final TextStyle bold = gfont.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle normal = gfont.copyWith(fontWeight: FontWeight.normal);
  static final TextStyle muted = gfont.copyWith(fontWeight: FontWeight.normal, color: ColorConstants.secondaryColor);
  static final TextStyle headLines = gfont.copyWith(fontWeight: FontWeight.bold, fontSize: 20);
  static final TextStyle subLines = gfont.copyWith(fontSize: 18);

  // // AutoSizeText ================================
  // static AutoSizeTxt(String texts, {TextStyle? style, int? maxLines, TextAlign? textAlign}) {
  //   return Container(
  //     width: Get.width,
  //     child: AutoSizeText(texts,
  //         textAlign: textAlign ?? TextAlign.justify,
  //         maxLines: maxLines ?? 1,
  //         minFontSize: 10,
  //         maxFontSize: 16,
  //         style: style ??
  //             Gfont.fs14.copyWith(
  //               color: C.black,
  //             )),
  //   );
  // }
}
