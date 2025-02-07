import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:oms_app/controllers/user_details_controller.dart';
import 'package:oms_app/resuources/custom_snackbar.dart';

import '../models/common_model.dart';
import '../models/otp_verify_fororder_confirmation_model.dart';
import '../resuources/api_urls.dart';


Future<OtpVerifyForOrderConfirmationModel> otpVerifyForOrderConfirmationRepo({
  required String orderId,
  required String otp,
  required BuildContext context,
}) async {
  final userDetailsController = Get.put(UserDetailsController());
  var map = <String, dynamic>{};
  map['order_id'] = orderId;
  map['otp'] = otp;
  log(map.toString());

  final token = userDetailsController.userToken.value;
  if (token.isEmpty) {
    throw Exception('User token is null or empty');
  }

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };
  print('REQUEST ::${jsonEncode(map)}');

  http.Response response = await http.post(
    Uri.parse(ApiUrls.otpVerifyForOrderConfirmation),
    body: jsonEncode(map),
    headers: headers,
  );

  if (response.statusCode == 200 || response.statusCode == 400) {
    log("response.body.... ${response.body}");
    return OtpVerifyForOrderConfirmationModel.fromJson(
      json.decode(response.body),
    );
  } else {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    final errorMessage = errorData['error'] ?? 'Unknown error occurred';
    showSnackBarView(
      context: context,
      message: errorMessage,
      backGroundColor: Colors.red,
    );
    throw Exception(response.body);
  }
}


Future<CommonModel> resendOtpVerifyForOrderConfirmationRepo(
    {
      required String orderId,
      required BuildContext context}) async {
  final userDetailsController = Get.put(UserDetailsController());
  var map = <String, dynamic>{};
  map['order_id'] = orderId;
  log(map.toString());
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${userDetailsController.userToken.value.toString()}'
  };
  print('REQUEST ::${jsonEncode(map)}');
  // log(pref.getString('deviceId')!);
  http.Response response = await http.post(Uri.parse(ApiUrls.resendOtpVerifyForOrderConfirmation),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200 || response.statusCode == 400) {
    log("response.body....      ${response.body}");
    // Helpers.hideLoader(loader);
    return CommonModel.fromJson(json.decode(response.body));
  } else {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    showSnackBarView(context: context, message: errorData['error'], backGroundColor: Colors.red);
    // Helpers.createSnackBar(context, response.body.toString());
    // Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}


