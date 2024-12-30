import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:oms_app/routes.dart';
import 'package:oms_app/screens/splash.dart';
import 'package:oms_app/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OMS',
      theme: AppTheme.lightTheme(context),
      initialRoute: Splash.splash,
     routes: routes,
    );
  }
}

