import 'package:flutter/material.dart';
import 'package:oms_app/resuources/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: false,
      fontFamily: "system-ui;",
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.black)),
      textTheme: TextTheme(
        bodyLarge: const TextStyle(color: Colors.black,fontSize: 18),
        bodyMedium: const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),
        bodySmall:  TextStyle(color: Colors.grey.shade600,fontSize: 12),
        titleSmall: const TextStyle(color: AppTextColor.titleColor,fontSize: 13,fontWeight: FontWeight.w500),
        titleMedium: const TextStyle(color: AppTextColor.titleColor,fontSize: 17,fontWeight: FontWeight.w500),
        headlineMedium: const TextStyle(color: Colors.black),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(28)),
  borderSide: BorderSide(color: Colors.black),
  gapPadding: 10,
);
