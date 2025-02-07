import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/screens/componant_screens/common_button.dart';

import '../../common_repo/common_api_repo.dart';
import '../../models/order_details_model.dart';
import '../../resuources/api_urls.dart';
import '../../resuources/common_style_Text.dart';
import '../../resuources/custom_loader.dart';
import '../componant_screens/add_height_widtth.dart';
import '../new_bottom_appbar.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  final String orderDate;
  const OrderDetailsScreen({super.key, required this.orderId, required this.orderDate});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Repositories repositories = Repositories();
  OrderDetailsModel? orderDetailsModel;
  getCustomerList() async {
    repositories.getApi(url: "${ApiUrls.orderDetails}?order_id=${widget.orderId}")
        .then((value) {
      orderDetailsModel = OrderDetailsModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getCustomerList();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppTextColor.themeColor,
          automaticallyImplyLeading: false,
          leadingWidth: 0,
          elevation: 0,
          title:   Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                onTap:(){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,color: Colors.white,size: 18,),
              ),
              addWidth(7),
              Text("ORDER DETAILS",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
            ],
          ),
        ),
      body:
          orderDetailsModel != null ?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addHeight(15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // gradient: LinearGradient(
                    //   colors: [Colors.white, Colors.grey.shade200],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.1),
                    //     blurRadius: 10,
                    //     offset: Offset(0, 5),
                    //   ),
                    // ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align the whole column to the start
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align Row children to the start
                        crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order No".toUpperCase(),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(height: 3), // Space between label and value
                                Text(
                                  '${widget.orderId}',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "DATE",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(height: 3), // Space between label and value
                                Text(
                                    widget.orderDate,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "STATUS",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                orderDetailsModel!.status == 0 ? "PENDING" : "VERIFIED",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: orderDetailsModel!.status == 0 ? Colors.red : Colors.green,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                  addHeight(10),
                  Text("Order From".toUpperCase(), style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 13
                  ),),
              Card(
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${orderDetailsModel!.customer!.name.toString().capitalizeFirst}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTextColor.themeColor,fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${orderDetailsModel!.customer!.address.toString() } ",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${orderDetailsModel!.customer!.address2.toString()}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${orderDetailsModel!.customer!.city.toString().capitalizeFirst} ${orderDetailsModel!.customer!.state.toString()}, ${orderDetailsModel!.customer!.pincode.toString()}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${orderDetailsModel!.customer!.phone.toString() }/${orderDetailsModel!.customer!.phone2.toString()}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${orderDetailsModel!.customer!.email.toString() }/${orderDetailsModel!.customer!.email2.toString()}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderDetailsModel!.orderDetail!.length,
                    itemBuilder: (context, index) {
                       final orderDetailsData = orderDetailsModel!.orderDetail![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                    // CachedNetworkImage(
                                    //   imageUrl: productUrl +
                                    //       orderDetailsData.m,
                                    //   fit: BoxFit.contain,
                                    //   height: height * .04,
                                    //   width: 55,
                                    //   alignment: Alignment.topLeft,
                                    //   errorWidget: (_, __, ___) =>
                                    //       Image.asset(
                                    //         "assets/images/dmeo.png",
                                    //         width: 90,
                                    //         fit: BoxFit.fitHeight,
                                    //       ),
                                    //   placeholder: (_, __) => Image.asset(
                                    //     "assets/images/dmeo.png",
                                    //     width: 90,
                                    //     fit: BoxFit.fitHeight,
                                    //   ),
                                    // ),
                                    Image.asset("assets/images/dmeo.png",
                                    height: 50,
                                      width: 55,
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            orderDetailsData.productname.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                          addHeight(3),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  orderDetailsData.sku.toString(),
                                                  style: Theme.of(context).textTheme.bodySmall),
                                              Row(children: [
                                                orderDetailsData.saleprice != null ?
                                                Text(
                                                  "$currencySymbol${orderDetailsData.saleprice} / ",
                                                  style: TextStyle(
                                                    color: AppTextColor.titleColor,
                                                    fontSize: 12,
                                                  ),
                                                ):
                                                Text(
                                                  "$currencySymbol${orderDetailsData.price} / ",
                                                  style: TextStyle(
                                                    color:AppTextColor.titleColor,
                                                    fontSize: 12,
                                                  ),
                                                ),

                                                Text( orderDetailsData.unitId == "1" ? "KG" : orderDetailsData.unitId == "2" ? "Litter" : orderDetailsData.unitId == "3" ? "Gram" :
                                                orderDetailsData.unitId == "4" ? "inches" : orderDetailsData.unitId == "5" ? "centimeters": orderDetailsData.unitId == "6" ? "meter":"",
                                                  style: Theme.of(context).textTheme.bodySmall,),
                                              ],),
                                            ],
                                          ),
                                          addHeight(10),
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              if (orderDetailsData.saleprice != null)
                                                Text(
                                                  "$currencySymbol${orderDetailsData.price} ",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                              // addWidth(5),
                                              Text(
                                                orderDetailsData.saleprice != null
                                                    ? "$currencySymbol${orderDetailsData.saleprice}"
                                                    : "$currencySymbol${orderDetailsData.price}",
                                                style: const TextStyle(color:AppTextColor.titleColor,fontWeight: FontWeight.bold,fontSize: 13),
                                              ),
                                              Text(
                                                " * ${orderDetailsData.qty} Qty",
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            )
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFDADADA).withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(3, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          buildSummaryRow('Subtotal:', currencySymbol + orderDetailsModel!.subtotal.toString()),

                          buildSummaryRow('Discount:', currencySymbol + orderDetailsModel!.discount.toString()),
                          const Divider(color: Colors.grey),
                          buildSummaryRow('Total:', currencySymbol + orderDetailsModel!.totalamount.toString(),
                              isBold: true, fontSize: 14),
                        ],
                      ),
                    ),
                  ),
                  // addHeight(40),
                  // CommonButtonBlue(title: "Continue Shopping", onPressed: (){
                  //   Get.to(()=>const MinimalExample());
                  // })
                ],
              ),
            ),
          ):
          Center(child: threeArchedCircle(color: AppTextColor.themeColor, size: 30))
    );
  }
  Row buildSummaryRow(String title, String value, {bool isBold = false, double fontSize = 14}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: const Color(0xFF1A2E33),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            color: isBold ? AppTextColor.primaryColor : const Color(0xFF486769),
          ),
        ),
      ],
    );
  }
}
