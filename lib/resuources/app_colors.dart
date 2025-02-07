import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/colors.dart';

class AppTextColor {
  static const Color  titleColor =  Color(0xff333333);
  static const Color primaryColor =  Color(0xff222220);
  static const Color menuColor =  Colors.white;
  static const Color greyColor =  Color(0xff888888);
  static const Color themeColor =  Color(0xffcf4a4a);
  // static const Color themeColor =  Color(0xff004ba9);
  static const LinearGradient themeGradient = LinearGradient(
    colors: [
      Color(0xffcc2b21), // Start color
      Color(0xffff5733), // Adjust this color for the gradient effect
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Color mainColor = Colors.green;

}