import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UrbanCultureTextStyle {
  static TextStyle h1({Color? color}) => GoogleFonts.epilogue(
        fontSize: 80,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle h2({Color? color}) => GoogleFonts.epilogue(
        fontSize: 40,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle h3({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle h4({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle h5({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle h6({Color? color}) => GoogleFonts.epilogue(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle subtitle({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1,
        color: color,
      );
  static TextStyle subtitleW700({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1,
        color: color,
      );

  static TextStyle body({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 17,
        fontWeight: FontWeight.w500,
      );

  static TextStyle callout({Color? color}) => GoogleFonts.epilogue(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle subhead({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle footnote({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 13,
        height: 1,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle caption({Color? color}) => GoogleFonts.epilogue(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle lable({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle small({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.epilogue(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: color,
      );
}
