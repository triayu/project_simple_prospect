import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
// import 'package:riverpod_example/app/constants/color_constants.dart';

TextStyle gfont =
    GoogleFonts.getFont("Poppins", fontSize: 16, color: ColorConstants.textPrimaryColor, letterSpacing: 1);

TextStyle gfontBold =
    GoogleFonts.getFont("Poppins", fontSize: 15.5, color: ColorConstants.textPrimaryColor, fontWeight: FontWeight.bold);

class Gfont {
// Auto Size Text ================================
  static autoSizeText(BuildContext context, double size,
      {Color? color, TextOverflow? overflow, FontWeight? fontWeight, FontStyle? fontStyle}) {
    final double scaleFactor = MediaQuery.of(context).size.shortestSide / 1000;
    final double fontSize = size * scaleFactor;
    return gfont.copyWith(
        fontSize: fontSize,
        letterSpacing: 1,
        wordSpacing: 0.5,
        fontStyle: fontStyle,
        fontWeight: fontWeight ?? FontWeight.normal,
        overflow: overflow ?? TextOverflow.ellipsis,
        decoration: TextDecoration.none,
        color: color ?? ColorConstants.textPrimaryColor);
  }

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

class FontSizeManager {
  static double getHeadlineFontSize() {
    return 55;
  }

  static double getSublineFontSize() {
    return 47;
  }

  static double getTittleFontSize() {
    return 42;
  }

  static double getBodyFontSize() {
    return 38;
  }

  static double getCaptionFontSize() {
    return 30;
  }
}
