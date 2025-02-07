import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_flow/login_page.dart';
import 'new_bottom_appbar.dart';

class Splash extends StatefulWidget {
  static var splash = "/splash";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
   var data = pref.getString("user_info");
   log("USER DETAILS ${data.toString()}");
   if(data != null){
     Timer(const Duration(seconds: 3 ), ()async{
       // Get.offAll(()=> const CustomBar());
       Get.offAll(()=> const MinimalExample(initialIndex: 0,));
     });
   }else{
     Get.offAll(()=>   LoginPage());
   }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTextColor.themeColor ,
      body: Center(child: Image.asset("assets/images/oms_new_logo.png")),
    );
  }
}
