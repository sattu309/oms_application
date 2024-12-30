import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oms_app/resuources/constants.dart';

import 'Homepage.dart';
import 'chat_uaer.dart';
import 'custom_bottom_bar.dart';
import 'login_flow/login_page.dart';
import 'manage_stocks/stocks_info_page.dart';

class Splash extends StatefulWidget {
  static var splash = "/splash";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3 ), ()async{
      // Get.off(()=> UserSelectionScreen());
      Get.off(()=>   LoginPage());
      // Get.off(()=> CustomBar());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTextColor.primaryColor ,
      body: Center(child: Image.asset("assets/images/oms_new_logo.png")),
    );
  }
}
