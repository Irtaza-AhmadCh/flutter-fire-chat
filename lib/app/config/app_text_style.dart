import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  AppTextStyles._();

  static TextStyle customText({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double fontSize = 12,
    double? height,
  }) {
    return GoogleFonts.dmSans(fontSize: fontSize.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static customInterTextStyle({double? fontSize, TextDecoration? decoration, Color? color, FontWeight? fontWeight, Color? decorationColor}) {
    return GoogleFonts.dmSans(
        decoration: decoration, decorationColor: decorationColor, color: color ?? AppColors.black, fontWeight: fontWeight ?? FontWeight.w500, fontSize: fontSize ?? 14.sp);
  }

  static TextStyle customText8({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.dmSans(fontSize: 8.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }static TextStyle customText10({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.dmSans(fontSize: 10.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static TextStyle customText12({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration? decoration,
    Color? decorationColor,
    double? height,
  }) {
    return GoogleFonts.dmSans(fontSize: 12.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height, decorationColor: decorationColor, decoration: decoration);
  }

  static TextStyle customText14({
    Color? color,
    double? height,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
  }) {
    return GoogleFonts.dmSans(
        fontSize: 14.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, decoration: decoration, height: height, decorationColor: decorationColor);
  }
  static TextStyle customTextLexend({
    Color? color,
    double? height,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? fontSize,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
  }) {
    return GoogleFonts.lexend( 
        fontSize: fontSize ?? 14.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, decoration: decoration, height: height, decorationColor: decorationColor);
  }

  static TextStyle customText16({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
  }) {
    return GoogleFonts.dmSans(
        height: height, fontSize: 16.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, decoration: decoration, decorationColor: decorationColor);
  }

  static TextStyle customText32({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
    double? height,
  }) {
    return GoogleFonts.dmSans(
      fontSize: 32.sp,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
      height: height,
    );
  }

  static TextStyle customText38({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    double? height,
  }) {
    return GoogleFonts.dmSans(
      fontSize: 38.sp,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle customText18({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static TextStyle customText20({
    Color? color,
    double? height,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.dmSans(height: height, fontSize: 20.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText22({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.dmSans(fontSize: 22.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static TextStyle customText24({
    double? height,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.dmSans(fontSize: 24.sp, height: height, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText26({
    Color? color,
    double? height,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.dmSans(fontSize: 26.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static TextStyle customText28({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.dmSans(fontSize: 28.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customTextPoppins({
    Color? color,
    double? fontSize,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(fontSize: fontSize , fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }
}
