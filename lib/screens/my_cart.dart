import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oms_app/common_repo/common_api_repo.dart';
import 'package:oms_app/resuources/api_urls.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/resuources/custom_snackbar.dart';
import 'package:oms_app/screens/componant_screens/common_button.dart';
import 'package:oms_app/screens/place_order_screen.dart';

import '../controllers/cart_local_data_controller.dart';
import '../models/customer_list_model.dart';
import '../resuources/common_style_Text.dart';
import 'category/component/plus_minus_component.dart';
import 'componant_screens/add_height_widtth.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.put(CartLocallyData());
  Map<String, int> productCounter = {};

  Widget cartDetails({required String title,required int amt}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: Theme.of(context).textTheme.titleMedium,),
        Text(currencySymbol+cartController.numberFormatData(amt: amt),style: TextStyle(fontSize: 14,color: Colors.black54),)
      ],
    );
  }
  String? dropdownValue;

  CustomerListModel? customerListModel;
  Repositories repositories = Repositories();

  getCustomerList() async {
    repositories.getApi(url: ApiUrls.customerList)
        .then((value) {
      customerListModel = CustomerListModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }


  @override
  void initState() {
    super.initState();
    getCustomerList();
    cartController.getCartDataLocally();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return
    Obx((){
      return Scaffold(
          backgroundColor: Colors.white,

          body:
          cartController.cartList.isNotEmpty  ?
          CustomScrollView(
            slivers: [


              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final cartLocalData = cartController.cartList[index];
                    var productUrl =
                        "https://oms.siddharthinfosys.com/public/products/";
                    final int price = int.parse(cartLocalData['price'].toString());
                    final int salePrice = cartLocalData['saleprice'] != null
                        ? int.tryParse(cartLocalData['saleprice'].toString()) ?? price
                        : price;
                    final int qty = int.parse(cartLocalData['qty'].toString());
                    final int calPrice = price * qty;
                    final int calSalePrice = salePrice * qty;
                    return

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey.shade200)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,

                          ),
                          child:

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: productUrl +
                                        cartLocalData['product_img'].toString(),
                                    fit: BoxFit.contain,
                                    height: height * .04,
                                    width: 55,
                                    alignment: Alignment.topLeft,
                                    errorWidget: (_, __, ___) =>
                                        Image.asset(
                                          "assets/images/dmeo.png",
                                          width: 55,
                                          fit: BoxFit.fitHeight,
                                          alignment: Alignment.topLeft,
                                        ),
                                    placeholder: (_, __) => Image.asset(
                                      "assets/images/dmeo.png",
                                      width: 90,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartLocalData['productname'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleSmall,
                                        ),
                                        addHeight(3),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  cartLocalData['sku'],
                                                  style: Theme.of(context).textTheme.bodySmall),
                                            ),
                                            if(cartLocalData['saleprice'] != null)
                                            Text(
                                              // currencySymbol+cartLocalData['price'],
                                              currencySymbol+cartController.numberFormatData(amt: int.parse(cartLocalData['price'].toString())),
                                              style: TextStyle(fontSize: 13,color: AppTextColor.greyColor,decoration: TextDecoration.lineThrough),
                                            ),
                                            addWidth(3),
                                            cartLocalData['saleprice'] != null ?
                                            Text(
                                            currencySymbol+cartController.numberFormatData(amt: int.tryParse(cartLocalData['saleprice']) ?? 0),
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13),
                                            ):
                                            Text(
                                              // currencySymbol+cartLocalData['price'],
                                            currencySymbol+cartController.numberFormatData(amt: int.parse(cartLocalData['price'].toString())),
                                              style: TextStyle(
                                                  color: AppTextColor
                                                      .titleColor,
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),

                                          ],
                                        ),
                                        addHeight(7),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              currencySymbol +
                                                  cartController.numberFormatData(
                                                    amt: cartLocalData['saleprice'] != null ? calSalePrice : calPrice,
                                                  ),
                                              style: TextStyle(
                                                  color: AppTextColor
                                                      .titleColor,
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            Text(
                                              "  *   ${cartLocalData['qty'].toString()} Qty",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                        addHeight(4),


                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RoundedIconBtn(
                                      icon: Icons.remove,
                                      press: () {
                                        int currentQty = int.tryParse(cartLocalData['qty'].toString()) ?? 0;

                                        if (currentQty > 1) {
                                          currentQty -= 1;

                                          var userAddToCartInformation = {
                                            "productname": cartLocalData['productname'].toString(),
                                            "price": cartLocalData['price'].toString(),
                                            "product_id": cartLocalData['product_id'].toString(),
                                            "product_img": cartLocalData['product_img'].toString(),
                                            "sku": cartLocalData['sku'].toString(),
                                            "qty": currentQty,
                                          };

                                          cartController.updateCartQuantityLocally(
                                            productId: cartLocalData['product_id'].toString(),
                                            newQty: currentQty,
                                            productDetails: userAddToCartInformation,
                                          );
                                          log("Updated Qty: $currentQty");
                                        } else if (currentQty == 1) {
                                          cartController.removeProductFromCartLocally(
                                            productId: cartLocalData['product_id'].toString(),
                                          );

                                          log("Product removed from cart: ${cartLocalData['product_id']}");
                                        }
                                        cartController.getCartDataLocally();

                                      }

                                  ),
                                  addWidth(12),
                                  Text(
                                    cartLocalData['qty'].toString(),style: Theme.of(context).textTheme.bodySmall,),
                                  addWidth(12),
                                  RoundedIconBtn(
                                    icon: Icons.add,
                                    press: () {

                                      int currentQty = int.tryParse(cartLocalData['qty'].toString()) ?? 0;
                                      currentQty += 1;

                                      log(("HELLLLLLL ${currentQty}"));
                                      var userAddToCartInformation = {
                                        "productname": cartLocalData['productname'].toString(),
                                        "price": cartLocalData['price'].toString(),
                                        // "saleprice": salePriceController.text,
                                        "product_id": cartLocalData['product_id'].toString(),
                                        "product_img": cartLocalData['product_img'].toString(),
                                        "sku": cartLocalData['sku'].toString(),
                                        "qty": currentQty,
                                      };
                                      cartController.updateCartQuantityLocally(
                                          productId: cartLocalData['product_id'].toString(),
                                          newQty: int.parse(currentQty.toString()),
                                          productDetails: userAddToCartInformation
                                      );
                                      cartController.getCartDataLocally();
                                    },
                                  ),
                                  addWidth(10),
                                  Text( cartLocalData['unit_id'] == "1" ? "KG" : cartLocalData['unit_id'] == "2" ? "Litter" : cartLocalData['unit_id'] == "3" ? "Gram" :
                                  cartLocalData['unit_id'] == "4" ? "inches" : cartLocalData['unit_id'] == "5" ? "centimeters": cartLocalData['unit_id'] == "6" ? "meter":"",
                                    style: Theme.of(context).textTheme.bodySmall,)

                                ],
                              ),
                            ],
                          )
                        ),
                      );
                  },
                  childCount: cartController.cartList.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addHeight(5),
                        cartDetails(title: 'SubTotal', amt: cartController.cartTotal.value.toInt() ),
                        addHeight(3),
                       Divider(
                         height: 2,
                       ),
                        addHeight(12),
                        Text("Select Customer",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 15)),
                        addHeight(6),
                        customerListModel != null ?
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<String>(
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.black,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: const BorderSide(color: Colors.black54),
                              ),
                            ),
                            value: dropdownValue,
                            hint: const Text(
                              "select customer",
                              style: TextStyle(fontSize: 14, color: AppTextColor.greyColor),
                            ),
                            isExpanded: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select customer.';
                              }
                              return null;
                            },
                            onChanged: (String? data) {
                              setState(() {
                                dropdownValue = data!;
                                log(dropdownValue.toString());
                              });
                            },
                            items: customerListModel!.success!.toList().map((value) {
                              return DropdownMenuItem(
                                value: value.id.toString(),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      value.name.toString(),
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),

                          ),
                        ):SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ):
          Center(child: Text(
            "Cart is Empty",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600,color: AppTextColor.titleColor),
          ),),
        bottomNavigationBar:
        cartController.cartList.isNotEmpty  ?
         BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonButtonBlue(title: "CONTINUE",
                  onPressed: () {
                  if(dropdownValue != null){
                    Get.to(()=> PlaceOrderScreen(customerId:dropdownValue.toString(),
                      cartList: cartController.cartList,));
                  }else{
                    showSnackBarView(context: context, message: "Please select the customer.", backGroundColor: Colors.red);
                  }

                  },)
              ],
            ),
          ),
        ):SizedBox()



      );
    });

  }
}
