import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController{
  RxInt currentIndex = 0.obs;
  RxBool internetConnection = true.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  onItemTap(int value) {
    currentIndex.value = value;
  }
}