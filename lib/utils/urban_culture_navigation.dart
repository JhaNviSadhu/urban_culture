import 'package:flutter/material.dart';

class UrbanCultureNavigation {
  static push(context, {route}) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => route),
      );

  static pushAndRemoveUntil(context, {route}) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => route),
      (Route<dynamic> route) => false);

  static pushReplacement(context, {route}) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => route),
      );

  static pop(context, {result}) {
    Navigator.pop(context, result);
  }
}
