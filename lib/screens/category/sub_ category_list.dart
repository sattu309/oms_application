import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:oms_app/common_repo/common_api_repo.dart';
import 'package:oms_app/resuources/api_urls.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/cart_local_data_controller.dart';
import '../../models/sub_category_model.dart';
import '../../resuources/app_colors.dart';
import '../../resuources/common_style_Text.dart';
import '../../resuources/custom_snackbar.dart';
import '../componant_screens/add_height_widtth.dart';
import 'category_product.dart';
import 'component/plus_minus_component.dart';

class SubCategoriesList extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  const SubCategoriesList({super.key, required this.categoryId, required this.categoryName});

  @override
  State<SubCategoriesList> createState() => _SubCategoriesListState();
}

class _SubCategoriesListState extends State<SubCategoriesList> {
  final salePriceController = TextEditingController();

  final cartController = Get.put(CartLocallyData());
  Map<String, dynamic> updatedPrices = {};
  Map<String, TextEditingController> productUpdatedPriceController = {};
  bool addButtonCliked = false;
  final catImgUrl = "https://oms.siddharthinfosys.com/public/categories/";

  Map<String, int> productCounters = {};

  int counter = 1;
  increaseCounter() {
    counter++;
    setState(() {});
  }

  decreaseCounter() {
    if (counter > 1) {
      counter--;
    }else{
      addButtonCliked = false;
    }
    setState(() {});
  }

  Repositories repositories = Repositories();
  SubCategoryModel? subCategoryModel;

  getALlSubCatList() async{
    repositories.getApi(url: "${ApiUrls.allCategoryList}/${widget.categoryId}").then((value){
      subCategoryModel = SubCategoryModel.fromJson(jsonDecode(value));
      for(var product in subCategoryModel!.products!){
        productCounters[product.id.toString()] = 0;
      }
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
    return Scaffold(
       // appBar: AppBar(
       //   title: Text(widget.categoryName.toUpperCase(),style: Theme.of(context).textTheme.titleMedium,),
       // ),
        body:
        subCategoryModel != null ?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addHeight(14),
                    Text(widget.categoryName.toUpperCase(), style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 10),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    mainAxisExtent: 115,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final subCateListData = subCategoryModel!.categories![index];
                      // final catImgUrl = "https://oms.siddharthinfosys.com/public/categories/";
                      return GestureDetector(
                        onTap: () {
                          pushScreen(context,
                              screen: CategoryProducts(categoryId: subCateListData.id.toString(),
                                categoryName: subCateListData.category.toString(),),
                              withNavBar: true);
                          // Get.to(()=>CategoryProducts(categoryId: subCateListData.id.toString(), categoryName: subCateListData.category.toString(),));
                        },
                        child: Container(
                          // margin: EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade100,
                          ),
                          child: Center(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                addHeight(10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                  CachedNetworkImage(
                                    imageUrl: catImgUrl +
                                        subCateListData.mobileimage.toString(),
                                    fit: BoxFit.contain,
                                    height: 80,
                                    width: 80,
                                    // height: height*.47,
                                    errorWidget: (_, __, ___) =>const SizedBox(),

                                    placeholder: (_, __) =>  Center(
                                        child: CircularProgressIndicator(color: Colors.black,)),
                                  ),
                                  // Image.asset("assets/images/demo.png", height: 80),
                                ),
                                addHeight(3),
                                Text(
                                  subCateListData.category.toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: subCategoryModel!.categories!.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addHeight(14),
                    subCategoryModel!.products!.isNotEmpty ?
                    Text("PRODUCTS", style: Theme.of(context).textTheme.titleMedium):SizedBox(),
                    addHeight(5),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 70),
                sliver: SliverList(
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
                            // boxShadow: [
                            //   BoxShadow(
                            //     offset: const Offset(1, 1),
                            //     spreadRadius: 1,
                            //     blurRadius: 2,
                            //     color: Colors.black.withOpacity(0.10),
                            //   )
                            // ],
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
                                                                                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13),
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
              ),

            ],
          ),
        ): const Center(child: CircularProgressIndicator(color: Colors.black,),)
    );
  }
  Future<dynamic> buildShowDialog(BuildContext context, {required String pId, required String pPrice}) {
    final fKey = GlobalKey<FormState>();
    if (!productUpdatedPriceController.containsKey(pId)) {
      productUpdatedPriceController[pId] = TextEditingController(text: updatedPrices[pId] ?? "",);
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
            child: Form(
              key: fKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: TextFormField(
                      controller: productUpdatedPriceController[pId],
                      keyboardType: TextInputType.number,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'Enter the Amount to update'),
                      ]).call,
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
                       if(fKey.currentState!.validate()){
                        setState(() {
                          updatedPrices[pId] = productUpdatedPriceController[pId]?.text ?? '';
                        });
                        print("Updated Price for $pId: ${updatedPrices[pId]}");
                        Get.back();
                       }else{
                         print("Helloo");
                       }


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
          ),
        );
      },
    );
  }
}
