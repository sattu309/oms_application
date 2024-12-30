import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> userLogin(
    {required String email,
  required String password})async {
  var map ={};
  map['email'] = email;
  map['paswrod'] = password;
  final headers ={
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  http.Response response = await http.post(Uri.parse("hhhjjj/lsjsd"),body: map,headers: headers);
      if(response.statusCode == 200 || response.statusCode == 400 ){
        print(response.body);
      }
  }
// Future<BesterLoginModel> createLogin(
//     {required String mobileNumber,
//       required BuildContext context}) async {
//   var map = <String, dynamic>{};
//   map['mobile'] = mobileNumber;
//   // map['device_id'] =pref.getString('deviceId');
//   log(map.toString());
//
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//
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