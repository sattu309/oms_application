import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oms_app/models/common_model.dart';
import 'package:oms_app/resuources/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/add_customer_model.dart';
import '../models/user_info_model.dart';
import '../resuources/api_urls.dart';


Future<AddCustomerModel> addCustomerRepo(
    {
      required String name,
      required String lName,
      required String email,
      required String mobileNumber,
      required String address1,
      required String email2,
      required String mobileNumber2,
      required String address2,
      required String contactPersonName,
      required String contactPersonPhone,
      required String state,
      required String city,
      required String pincode,
      required String panNumber,
      required String gstNumber,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['name'] = name;
  map['lname'] = lName;
  map['email'] = email;
  map['phone'] = mobileNumber;
  map['address'] = address1;
  map['email2'] = email2;
  map['phone2'] = mobileNumber2;
  map['address2'] = address2;
  map['cp_name'] = contactPersonName;
  map['cp_phone'] = contactPersonPhone;
  map['state'] = state;
  map['city'] = city;
  map['pincode'] = pincode;
  map['panno'] = panNumber;
  map['gstno'] = gstNumber;
  log(map.toString());
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userInfo = preferences.getString("user_info");
  if (userInfo == null) {
    log("No user info found in local storage.");
    throw Exception("User info not found.");
  }
  UserInfoModel userInfoModel = UserInfoModel.fromJson(jsonDecode(userInfo));
  String? rememberToken = userInfoModel.rememberToken.toString();
  print('token ::$rememberToken');
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $rememberToken'
  };
  print('REQUEST ::${jsonEncode(map)}');
  print('Headers ::${headers}');
  http.Response response = await http.post(Uri.parse(ApiUrls.addCustomer),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    showSnackBarView(context: context, message: "Customer Added Successfully ", backGroundColor: Colors.green);
    return AddCustomerModel.fromJson(json.decode(response.body));
  } else {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    log("Exception:${errorData['error'].toString()}");
    // showSnackBarView(context: context, message: errorData['error'], backGroundColor: Colors.red);
    // Helpers.createSnackBar(context, response.body.toString());
    // Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<AddCustomerModel> editCustomerRepo(
    {
      required String customerId,
      required String name,
      required String lName,
      required String email,
      required String mobileNumber,
      required String address1,
      required String email2,
      required String mobileNumber2,
      required String address2,
      required String contactPersonName,
      required String contactPersonPhone,
      required String state,
      required String city,
      required String pincode,
      required String panNumber,
      required String gstNumber,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['name'] = name;
  map['lname'] = lName;
  map['email'] = email;
  map['phone'] = mobileNumber;
  map['address'] = address1;
  map['email2'] = email2;
  map['phone2'] = mobileNumber2;
  map['address2'] = address2;
  map['cp_name'] = contactPersonName;
  map['cp_phone'] = contactPersonPhone;
  map['state'] = state;
  map['city'] = city;
  map['pincode'] = pincode;
  map['panno'] = panNumber;
  map['gstno'] = gstNumber;
  log(map.toString());
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userInfo = preferences.getString("user_info");
  if (userInfo == null) {
    log("No user info found in local storage.");
    throw Exception("User info not found.");
  }
  UserInfoModel userInfoModel = UserInfoModel.fromJson(jsonDecode(userInfo));
  String? rememberToken = userInfoModel.rememberToken.toString();
  print('token ::$rememberToken');
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $rememberToken'
  };
  print('REQUEST ::${jsonEncode(map)}');
  print('Headers ::${headers}');
  http.Response response = await http.post(Uri.parse("${ApiUrls.editCustomer}/$customerId"),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    // showSnackBarView(context: context, message: "Update Successfully ", backGroundColor: Colors.green);
    return AddCustomerModel.fromJson(json.decode(response.body));
  } else {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    log("Exception:${errorData['error'].toString()}");
    // showSnackBarView(context: context, message: errorData['error'], backGroundColor: Colors.red);
    // Helpers.createSnackBar(context, response.body.toString());
    // Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<CommonModel> updateProfileRepo(
    {
      required String name,
      required String lName,
      required String email,
      required String mobileNumber,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['name'] = name;
  map['lname'] = lName;
  map['email'] = email;
  map['phone'] = mobileNumber;

  log(map.toString());
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userInfo = preferences.getString("user_info");
  if (userInfo == null) {
    throw Exception("User info not found.");
  }
  UserInfoModel userInfoModel = UserInfoModel.fromJson(jsonDecode(userInfo));
  String? rememberToken = userInfoModel.rememberToken.toString();
  print('token ::$rememberToken');
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $rememberToken'
  };
  print('REQUEST ::${jsonEncode(map)}');
  print('Headers ::${headers}');
  http.Response response = await http.post(Uri.parse("${ApiUrls.updateProfile}"),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return CommonModel.fromJson(json.decode(response.body));
  } else {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    log("Exception:${errorData['error'].toString()}");
     throw Exception(response.body);
  }
}