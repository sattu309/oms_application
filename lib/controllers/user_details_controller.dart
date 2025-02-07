import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_info_model.dart';

class UserDetailsController extends GetxController{
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPhoneController = TextEditingController();
  var userId = "".obs;
  var userToken = "".obs;
  getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("user_info");
    log("LOCAL USER DATA ${userInfo}");

    if (userInfo == null) {
      log("No user info found in local storage.");
      throw Exception("User info not found.");
    }
    UserInfoModel userInfoModel = UserInfoModel.fromJson(jsonDecode(userInfo));
    userId.value = userInfoModel.id.toString();
    userNameController.text = userInfoModel.name.toString();
    userEmailController.text = userInfoModel.email.toString();
    userPhoneController.text = userInfoModel.phone.toString();
    userToken.value = userInfoModel.rememberToken.toString();
    log("USER ID ${userId.value.toString()}");
    log("userToken ID ${userToken.value.toString()}");
  }

  var image = Rx<File?>(null); // Nullable Rx<File?>

  void loadImageFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedImagePath = prefs.getString("save_img");

    if (savedImagePath != null && savedImagePath.isNotEmpty) {
      File file = File(savedImagePath);

      if (await file.exists()) {
        image.value = file;
      } else {
        log("File does not exist at path: $savedImagePath");
      }
    }
  }
@override
  void onInit() {
    super.onInit();
    getUserDetails();
    loadImageFromLocalStorage();
  }
}