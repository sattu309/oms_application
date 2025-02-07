import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_controller.dart';

class CartLocallyData extends GetxController{
  var cartList = [].obs;
  var cartTotal = 0.0.obs;
  var cartSubTotal = 0.0.obs;
  var calculateTotal = 0.0.obs;
  var discountAmt = 0.0.obs;
  final RxBool showAppBar = true.obs;
  Map<String, int> productCounters = {};

  RxInt cartItemCount = 0.obs;
  RxMap<String, int> productCounter = <String, int>{}.obs;
  Future<void> getCartDataLocally() async {
    SharedPreferences cartLocalData = await SharedPreferences.getInstance();
    String? rawCartDataString = cartLocalData.getString('cartData');

    if (rawCartDataString != null) {
      print("HELLO $rawCartDataString"); // Print the raw data to verify its structure

      try {
        final dynamic cartDataJson = jsonDecode(rawCartDataString);
        cartList.value = cartDataJson;
        cartItemCount.value =  cartDataJson.length;
        print("CART LOCAL DATA ${cartList}");

        cartTotal = 0.0.obs;
        for (var cartItem in cartDataJson) {
          double price = double.tryParse(cartItem['price']?.toString() ?? '0') ?? 0.0;
          double salePrice = double.tryParse(cartItem['saleprice']?.toString() ?? '') ?? price;
          double quantity = double.tryParse(cartItem['qty']?.toString() ?? '0') ?? 0.0;
          cartTotal.value += salePrice * quantity;
          String? productId = cartItem['product_id']?.toString();
          if (productId != null) {
            productCounters[productId] = quantity.toInt();

          }
          log("product qty  ${productCounters[productId].toString()}");
        }

        log("TOTAL CART AMT ${cartTotal.value.toString()}");
      } catch (e) {
        print("Error decoding cart data: $e");
      }
    } else {
      print("Cart data is null or empty");
    }
  }



  Future<void> updateCartQuantityLocally({
    required String productId,
    required int newQty,
    required Map<String, dynamic> productDetails,
  }) async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    String? cartDataString = pref.getString("cartData");
    List<Map<String, dynamic>> cartUpdatedData = [];

    if (cartDataString != null) {
      try {
        cartUpdatedData = List<Map<String, dynamic>>.from(jsonDecode(cartDataString));
      } catch (e) {
        log("Error parsing cart data: $e");
        cartUpdatedData = [];
      }
    }
    for(var cartData in cartUpdatedData){
      if(cartData['product_id'] == productId ){
        cartData['qty'] = newQty;
        break;
      }
    }


    bool isSaved = await pref.setString("cartData", jsonEncode(cartUpdatedData));

    if (isSaved) {
      log("CART DATA UPDATED SUCCESSFULLY: ${jsonEncode(cartUpdatedData)}");
    } else {
      log("FAILED TO UPDATE CART DATA");
    }
  }

  Future<void> removeProductFromCartLocally({required String productId}) async {
    SharedPreferences cartLocalData = await SharedPreferences.getInstance();
    String? rawCartDataString = cartLocalData.getString('cartData');

    if (rawCartDataString != null) {
      try {
        final List<dynamic> cartDataJson = jsonDecode(rawCartDataString);

        cartDataJson.removeWhere((item) => item['product_id'] == productId);

        String updatedCartDataString = jsonEncode(cartDataJson);
        await cartLocalData.setString('cartData', updatedCartDataString);

        cartList.value = cartDataJson;

        log("Product removed successfully: $productId");
      } catch (e) {
        log("Error removing product from cart: $e");
      }
    } else {
      log("Cart data is empty, nothing to remove.");
    }
  }


  numberFormatData({required amt}){
    int amount = amt;
    String formattedAmount = amount.toDouble().toStringAsFixed(2);
    return formattedAmount;
  }

  addCartSection() {
    final mainController = Get.put(MainController());
    return BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    mainController.onItemTap(2);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1 Items",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "₹8687",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "View Cart",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.arrow_right,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
  );
  }

  @override
  void onInit() {
    super.onInit();
    getCartDataLocally();
  }
}