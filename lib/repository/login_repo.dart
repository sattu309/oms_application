import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oms_app/resuources/custom_snackbar.dart';

import '../models/request_otp_model.dart';
import '../models/verify_otp_model.dart';
import '../resuources/api_urls.dart';


Future<RequestOtpModel> createLogin(
    {required String mobileNumber,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['phone'] = mobileNumber;
  log(map.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',

  };
  print('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.requestOtp),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return RequestOtpModel.fromJson(json.decode(response.body));
  } else {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    showSnackBarView(context: context, message: errorData['error'], backGroundColor: Colors.black);
    throw Exception(response.body);
  }
}


Future<VerifyOtpModel> otpVerifyRepo(
    {
      required String mobileNumber,
      required String otp,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['phone'] = mobileNumber;
  map['otp'] = otp;
  log(map.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  print('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.ValidateOtp),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    showSnackBarView(context: context, message: "Login Successful", backGroundColor: Colors.black);
    return VerifyOtpModel.fromJson(json.decode(response.body));

  } else {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    showSnackBarView(context: context, message: errorData['error'], backGroundColor: Colors.black);
    throw Exception(response.body);
  }
}


// // resend otp
// Future<BesterLoginModel> resendOtpRepo(
//     {
//       required String mobileNumber,
//       required BuildContext context}) async {
//   var map = <String, dynamic>{};
//   map['mobile'] = mobileNumber;
//   log(map.toString());
//
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//   };
//   print('REQUEST ::${jsonEncode(map)}');
//   // log(pref.getString('deviceId')!);
//   http.Response response = await http.post(Uri.parse(ApiUrls.loginApi),
//       body: jsonEncode(map), headers: headers);
//   log("response.body....      ${response.body}");
//   if (response.statusCode == 200 || response.statusCode == 400) {
//     // Helpers.hideLoader(loader);
//     return BesterLoginModel.fromJson(json.decode(response.body));
//   } else {
//     Helpers.createSnackBar(context, response.body.toString());
//     // Helpers.hideLoader(loader);
//     throw Exception(response.body);
//   }
// }