import 'dart:io';
import 'package:flutter/material.dart';

void showSnackBarView(
    {required BuildContext context, required String message,  required Color backGroundColor}) {
  SnackBar snackBarContent = SnackBar(
    duration: Duration(seconds: 5),
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
    ),
    backgroundColor: backGroundColor,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin:  EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height*.06,
        right: 20,
        left: 20),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBarContent);
}