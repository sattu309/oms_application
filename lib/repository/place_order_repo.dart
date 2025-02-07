import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controllers/user_details_controller.dart';
import '../models/createOrder_model.dart';
import '../resuources/api_urls.dart';


Future<createOrderModel> placeOrderRepo({
  required String customerId,
  required String totalAmount,
  required String subtotal,
  required String discount,
  required String status,
  required String lat,
  required String long,
  required List<dynamic> cartData,
  required BuildContext context,
}) async {
  final userController = Get.put(UserDetailsController());
  var map = <String, dynamic>{
    'customer_id': customerId,
    'totalamount': totalAmount,
    'subtotal': subtotal,
    'discount': discount,
    'status': status,
    'latitude': lat,
    'longitude': long,
    'orderdetails': cartData,
  };

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${userController.userToken.value}',
  };
  print('HEADERS ::${headers}');
  print('REQUEST ::${jsonEncode(map)}');


  try {
    http.Response response = await http.post(
      Uri.parse(ApiUrls.orderPlaceUrl),
      body: jsonEncode(map),
      headers: headers,
    );

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // if (responseData.containsKey('error') && responseData['error'] != null) {
      //   print('api error  ::${responseData['error']}');
      //   throw Exception(responseData['error']);
      // }
      print('api response ::${response.body}');

      return createOrderModel.fromJson(responseData);
    } else {
      print('Unexpected status code: ${response.statusCode}');
      throw Exception('Failed to place order. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Unexpected error: $e');
    throw Exception("An unexpected error occurred: $e");
  }
}

