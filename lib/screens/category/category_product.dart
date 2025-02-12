import 'dart:convert';
import 'dart:developer';
import 'package:badges/badges.dart';
import "package:flutter/material.dart"hide Badge;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oms_app/common_repo/common_api_repo.dart';
import 'package:oms_app/resuources/api_urls.dart';
import 'package:oms_app/resuources/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/cart_local_data_controller.dart';
import '../../models/sub_category_model.dart';
import '../../resuources/app_colors.dart';
import '../../resuources/common_style_Text.dart';
import '../componant_screens/add_height_widtth.dart';
import '../my_cart.dart';
import 'component/plus_minus_component.dart';

class CategoryProducts extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  const CategoryProducts(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  final salePriceController = TextEditingController();
  final cartController = Get.put(CartLocallyData());
  // Map<String, int> productCounters = {};
  Map<String, dynamic> updatedPrices = {};
  Map<String, TextEditingController> productUpdatedPriceController = {};

  Repositories repositories = Repositories();
  SubCategoryModel? subCategoryModel;

  getALlSubCatList() async {
    repositories
        .getApi(url: "${ApiUrls.allCategoryList}/${widget.categoryId}")
        .then((value) {
      subCategoryModel = SubCategoryModel.fromJson(jsonDecode(value));
      // for (var product in subCategoryModel!.products!) {
      //   // cartController.productCounters[product.id.toString()] = 0;
      //   log("PREFILE ${cartController.productCounters[product.id.toString()].toString()}");
      // }
      cartController.getCartDataLocally();
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getALlSubCatList();

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return
      Scaffold(
          body: subCategoryModel != null
              ? subCategoryModel!.products!.isNotEmpty
              ?
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addHeight(14),
                      Text("Products",
                          style:
                          Theme.of(context).textTheme.titleMedium),
                      addHeight(5),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {

                      final productList =
                      subCategoryModel!.products![index];

                      if(!productUpdatedPriceController.containsKey(productList.id.toString())){
                        productUpdatedPriceController[productList.id.toString()] = TextEditingController();
                      }
                      var productUrl =
                          "https://oms.siddharthinfosys.com/public/products/";

                      return
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            border:Border(bottom: BorderSide(color: Colors.grey.shade200)),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: productUrl +
                                        productList.mobileimage
                                            .toString(),
                                    fit: BoxFit.contain,
                                    height: height * .04,
                                    width: 55,
                                    alignment: Alignment.topLeft,
                                    errorWidget: (_, __, ___) =>
                                        Image.asset(
                                          "assets/images/dmeo.png",
                                          width: 90,
                                          fit: BoxFit.fitHeight,
                                          alignment: Alignment.topLeft,
                                        ),
                                    placeholder: (_, __) => Image.asset(
                                      "assets/images/dmeo.png",
                                      width: 80,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productList.title.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        addHeight(3),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: productList.stockCode.toString(),
                                                      style: Theme.of(context).textTheme.bodySmall, // Use body style
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),

                                        addHeight(4),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                currencySymbol +
                                                    cartController.numberFormatData(amt: int.parse(productList.price.toString()),),

                                                style: TextStyle(
                                                    decoration:
                                                    productUpdatedPriceController[productList.id.toString()]!.text
                                                        .isNotEmpty
                                                        ? TextDecoration
                                                        .lineThrough
                                                        : TextDecoration
                                                        .none,
                                                    color: productUpdatedPriceController[productList.id.toString()]!.text
                                                        .isNotEmpty
                                                        ?  AppTextColor
                                                        .greyColor:AppTextColor.titleColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              addWidth(5),
                                              updatedPrices[productList.id.toString()] != null &&
                                                  updatedPrices[productList.id.toString()]!.isNotEmpty
                                                  ? Expanded(
                                                child: Text(
                                                  currencySymbol +
                                                      cartController.numberFormatData(
                                                        amt: int.tryParse(updatedPrices[productList.id.toString()]!) ?? 0,
                                                      ),
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                ),
                                              )
                                                  : SizedBox(),
                                              addWidth(5),
                                              GestureDetector(
                                                onTap: () {
                                                  buildShowDialog(
                                                      context, pId: productList.id.toString(), pPrice: productList.price.toString());
                                                },
                                                child: Text("Edit Price",
                                                    style:
                                                    Theme.of(context)
                                                        .textTheme
                                                        .bodySmall?.copyWith(color: Colors.blue,fontWeight: FontWeight.w500)),
                                              ),


                                            ],
                                          ),
                                        ),
                                        addHeight(7),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      RoundedIconBtn(
                                        icon: Icons.remove,
                                        press: () {
                                          setState(() {
                                            cartController.productCounters[
                                            productList
                                                .id
                                                .toString()] =
                                                (cartController.productCounters[productList
                                                    .id
                                                    .toString()] ??
                                                    0) -
                                                    1;
                                          });
                                          log(cartController.productCounters[
                                          productList.id
                                              .toString()]
                                              .toString());
                                        },
                                      ),
                                      addWidth(12),
                                      Text(
                                        cartController.productCounters[productList.id.toString()] != null && cartController.productCounters[productList.id.toString()] != 0 ?
                                        cartController.productCounters[productList.id.toString()].toString():'0',style: Theme.of(context).textTheme.bodySmall,),
                                      addWidth(12),
                                      RoundedIconBtn(
                                        icon: Icons.add,
                                        press: () {
                                          log(productList.unit.toString());
                                          setState(() {
                                            cartController.productCounters[
                                            productList
                                                .id
                                                .toString()] =
                                                (cartController.productCounters[productList
                                                    .id
                                                    .toString()] ??
                                                    0) +
                                                    1;
                                          });

                                          log(cartController.productCounters[
                                          productList.id
                                              .toString()]
                                              .toString());
                                        },
                                      ),
                                      addWidth(10),
                                      Text( productList.unit == 1 ? "KG" : productList.unit == 2 ? "Litter" : productList.unit == 3 ? "Gram" :
                                      productList.unit == 4 ? "inches" : productList.unit == 5 ? "centimeters": productList.unit == 6 ? "meter":"",
                                        style: Theme.of(context).textTheme.bodySmall,)
                                    ],
                                  ),
                                  Align(
                                    alignment:
                                    Alignment.centerRight,
                                    child: Row(
                                      mainAxisSize:
                                      MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
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

                                            int? currentQty = cartController.productCounters[productList.id.toString()];

                                            if (currentQty != null && currentQty > 0) {
                                              var userAddToCartInformation = {
                                                "productname": productList.title.toString(),
                                                "price": productList.price.toString(),
                                                "saleprice": updatedPrices[productList.id.toString()],
                                                "product_id": productList.id.toString(),
                                                "product_img": productList.mobileimage.toString(),
                                                "unit_id": productList.unit.toString(),
                                                "sku": productList.stockCode.toString(),
                                                "qty": currentQty.toString(),
                                              };

                                              int existingProductIndex = cartUpdatedData.indexWhere(
                                                    (item) => item["product_id"] == userAddToCartInformation["product_id"],
                                              );

                                              if (existingProductIndex != -1) {
                                                cartUpdatedData[existingProductIndex]["qty"] = currentQty.toString();
                                              } else {
                                                cartUpdatedData.add(userAddToCartInformation);
                                              }

                                              bool isSaved = await pref.setString("cartData", jsonEncode(cartUpdatedData));

                                              if (isSaved) {
                                                cartController.getCartDataLocally();
                                                log("ADD TO CART LOCAL DATA SAVED SUCCESSFULLY: ${jsonEncode(cartUpdatedData)}");
                                                showSnackBarView(
                                                  context: context,
                                                  message: "Cart updated",
                                                  backGroundColor: Colors.black,
                                                );
                                              } else {
                                                log("FAILED TO SAVE ADD TO CART LOCAL DATA");
                                              }
                                            } else {
                                              showSnackBarView(
                                                context: context,
                                                message: "Quantity must be greater than 0",
                                                backGroundColor: Colors.black,
                                              );
                                            }
                                          },

                                          child: Container(
                                            padding:
                                            const EdgeInsets
                                                .symmetric(
                                                horizontal:
                                                10,
                                                vertical:
                                                8),
                                            decoration:
                                            BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  5),
                                              color:
                                              Colors.black,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset:
                                                  const Offset(
                                                      1, 1),
                                                  spreadRadius:
                                                  1,
                                                  blurRadius: 2,
                                                  color: Colors
                                                      .black
                                                      .withOpacity(
                                                      0.10),
                                                )
                                              ],
                                            ),
                                            child: const Text(
                                              "ADD TO ORDER",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors
                                                      .white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                    },
                    childCount: subCategoryModel!.products!.length,
                  ),
                ),

              ],
            ),
          )
              :
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(4, 4),
                      spreadRadius: 2,
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.10))
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                    AssetImage("assets/images/no-order.png"),
                    color: Colors.green,
                  ),
                  Text(
                    "Products Is not Available",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
              : const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ));

  }

  Future<dynamic> buildShowDialog(BuildContext context, {required String pId,required String pPrice}) {
    if (!productUpdatedPriceController.containsKey(pId)) {
      productUpdatedPriceController[pId] = TextEditingController(
        text: updatedPrices[pId] ?? "", // Use existing price or empty string
      );
    }else{
      productUpdatedPriceController[pId] = TextEditingController(text: pPrice,);

    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: TextFormField(
                    controller: productUpdatedPriceController[pId],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter Updated Price",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 3.0),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      updatedPrices[pId] = productUpdatedPriceController[pId]?.text ?? '';
                    });
                    print("Updated Price for $pId: ${updatedPrices[pId]}");
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "UPDATE",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
