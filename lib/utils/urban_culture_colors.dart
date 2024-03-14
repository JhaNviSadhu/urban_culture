import 'package:flutter/material.dart';

class UrbanCultureColors {
  static UrbanCulturTextColors urbanCulturTextColors = UrbanCulturTextColors();

  static MaterialColor get primaryColor => const MaterialColor(
        0xFF964F66,
        <int, Color>{
          50: Color(0xFF964F66),
          100: Color(0xFF964F66),
          200: Color(0xFF964F66),
          300: Color(0xFF964F66),
          400: Color(0xFF964F66),
          500: Color(0xFF964F66),
          600: Color(0xFF964F66),
          700: Color(0xFF964F66),
          800: Color(0xFF964F66),
          900: Color(0xFF964F66),
        },
      );

  // static Color get alertRed => Colors.red;
  static Color get scaffoldColor => const Color(0xffFCF7FA);
  static Color get greenColor => const Color(0xff088759);
  static Color get containerColor => const Color(0xffF2E8EB);
}

class UrbanCulturTextColors {
  Color get white => const Color(0xffFFFFFF);
  Color get black => const Color(0xff000000);
  Color get textTitleColor => const Color(0xff1C0D12);
}
