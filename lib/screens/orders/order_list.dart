import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
import 'package:oms_app/screens/componant_screens/common_button.dart';
import 'package:oms_app/screens/componant_screens/common_textfields.dart';

import '../../common_repo/common_api_repo.dart';
import '../../controllers/main_controller.dart';
import '../../models/customer_list_model.dart';
import '../../models/order_list_model.dart';
import '../../resuources/api_urls.dart';
import '../../resuources/common_style_Text.dart';
import '../../resuources/custom_loader.dart';
import 'order_details_screen.dart';

class OrderList extends StatefulWidget {
  final bool showAppBar;

  const OrderList({super.key, this.showAppBar = true});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final controller = Get.put(MainController());
  Repositories repositories = Repositories();
  CustomerListModel? customerListModel;
  OrderListModel? orderListModel;
  String? dropdownValue;
  bool isLoading = false;
  getCustomerList() async {
    repositories.getApi(url: ApiUrls.customerList)
        .then((value) {
      customerListModel = CustomerListModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  getOrderList()async{
    setState(() {
      isLoading = true;
    });
    final customerId = dropdownValue ?? "";
    final fromDate = Uri.encodeQueryComponent(startDateController.text);
    final toDate = Uri.encodeQueryComponent(endDateController.text);
    repositories.getApi(url: "${ApiUrls.allOrderList}?customer_id=$customerId&fromdate=$fromDate&todate=$toDate").then((value) async {
      orderListModel = OrderListModel.fromJson(jsonDecode(value));
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> startDate(BuildContext context,) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),);
      if(pickedDate != null){
        final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        startDateController.text = formattedDate;
        print("START DATE ${startDateController.text}");
      }
      // builder: (context, child) {
      //   return Theme(
      //     data: ThemeData.light().copyWith(
      //       primaryColor: Colors.black, // Header background color
      //       hintColor: Colors.blueAccent, // Selected date highlight color
      //       colorScheme: const ColorScheme.highContrastLight(
      //         primary: Colors.blue,
      //         // Header text and selected date color
      //         onPrimary: Colors.white,
      //         // Text color on header
      //         onSurface: Colors.black, // Default text color
      //       ),
      //     ),
      //     child: child!,
      //   );
      // },

  }
  Future<void> endDate(BuildContext context,) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),);
    if(pickedDate != null){
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      endDateController.text = formattedDate;
      print("END DATE ${endDateController.text}");
    }
    // builder: (context, child) {
    //   return Theme(
    //     data: ThemeData.light().copyWith(
    //       primaryColor: Colors.black, // Header background color
    //       hintColor: Colors.blueAccent, // Selected date highlight color
    //       colorScheme: const ColorScheme.highContrastLight(
    //         primary: Colors.blue,
    //         // Header text and selected date color
    //         onPrimary: Colors.white,
    //         // Text color on header
    //         onSurface: Colors.black, // Default text color
    //       ),
    //     ),
    //     child: child!,
    //   );
    // },

  }

  @override
  void initState() {
    super.initState();
    getCustomerList();
    getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: AppTextColor.themeColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title:  
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.showAppBar == false ? SizedBox() :
                GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: Colors.white,size: 18,),
                ),
                addWidth(7),
                Text("ORDERS",style: Theme.of(context).textTheme.bodyMedium),

              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                  onTap: (){
                    buildShowDialog(context);
                  },
                  child: const Icon(Icons.filter_alt_rounded,color: Colors.white,)),
            )
          ],
        ),
        backgroundColor: Colors.grey.shade100,
        body:
        isLoading ? Center(child: threeArchedCircle(color: AppTextColor.themeColor, size: 30)):

        (orderListModel != null && orderListModel!.orders!.isNotEmpty) ?
        SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:RefreshIndicator(
              color: AppTextColor.themeColor,
              onRefresh: () async {
                return await getOrderList();

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child:
                    Column(
                    children: [
                      addHeight(6),
                      ListView.builder(
                          itemCount: orderListModel!.orders!.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 80),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final orderData = orderListModel!.orders![index];
                            return
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(
                                    colors: [Colors.white, Colors.grey.shade200],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.parse(orderData.createdAt.toString()));
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                      return OrderDetailsScreen(
                                        orderId: orderData.id.toString(),
                                        orderDate: formattedDate,
                                      );
                                    }));
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 20,top: 6,bottom: 6),
                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // Align the whole column to the start
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
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
                                                      '${orderData.id.toString()}',
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
                                                      DateFormat('MMM d, yyyy').format(DateTime.parse(orderData.createdAt.toString())),
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
                                                      "STATUS",
                                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                    SizedBox(height: 3), // Space between label and value
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          orderData.status == 0 ? Icons.timelapse : Icons.check_circle,
                                                          color: orderData.status == 0 ? Colors.red : Colors.green,
                                                          size: 15,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          orderData.status == 0 ? "PENDING" : "VERIFIED",
                                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                            fontWeight: FontWeight.bold,
                                                            color: orderData.status == 0 ? Colors.red : Colors.green,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                flex: 2, // Give some weight so it doesn't shrink too much
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "CUSTOMER",
                                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            "${orderData.customerName.toString().capitalizeFirst}, ",
                                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          orderData.city.toString().capitalizeFirst.toString(),
                                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black87,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Flexible(
                                                flex: 0,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "",
                                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                    SizedBox(height: 3),
                                                    Text(
                                                      '',
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
                                                      "AMOUNT",
                                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                    SizedBox(height: 3),
                                                    Text(
                                                      '$currencySymbol${orderData.totalamount.toString()}',
                                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                                          //   crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                                          //   children: [
                                          //     Expanded(
                                          //       child: Column(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         children: [
                                          //           Text(
                                          //             "CUSTOMER",
                                          //             style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          //               color: Colors.grey,
                                          //               fontWeight: FontWeight.w500,
                                          //               fontSize: 11,
                                          //             ),
                                          //           ),
                                          //           const SizedBox(height: 3), // Space between label and value
                                          //           IntrinsicWidth(
                                          //             child: Row(
                                          //               mainAxisSize: MainAxisSize.min,
                                          //               children: [
                                          //                 Text(
                                          //                   "${orderData.customerName.toString().capitalizeFirst},",
                                          //                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          //                     fontWeight: FontWeight.bold,
                                          //                     color: Colors.black87,
                                          //                     fontSize: 13,
                                          //                   ),
                                          //                 ),
                                          //                 Text(
                                          //                   "${orderData.city.toString().capitalizeFirst}",
                                          //                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          //                     fontWeight: FontWeight.bold,
                                          //                     color: Colors.black87,
                                          //                     fontSize: 13,
                                          //                   ),
                                          //                 ),
                                          //               ],
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       child: Column(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         children: [
                                          //           Text(
                                          //             "",
                                          //             style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          //               color: Colors.grey,
                                          //               fontWeight: FontWeight.w500,
                                          //               fontSize: 11,
                                          //             ),
                                          //           ),
                                          //           SizedBox(height: 3), // Space between label and value
                                          //           Text(
                                          //             '',
                                          //             style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          //               fontWeight: FontWeight.bold,
                                          //               color: Colors.black87,
                                          //               fontSize: 13,
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       child: Column(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         children: [
                                          //           Text(
                                          //             "AMOUNT",
                                          //             style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          //               color: Colors.grey,
                                          //               fontWeight: FontWeight.w500,
                                          //               fontSize: 11,
                                          //             ),
                                          //           ),
                                          //           SizedBox(height: 3), // Space between label and value
                                          //           Text(
                                          //             '$currencySymbol${orderData.totalamount.toString()}',
                                          //             style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          //               fontWeight: FontWeight.bold,
                                          //               color: Colors.black87,
                                          //               fontSize: 13,
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //
                                          //
                                          //   ],
                                          // ),
                                        ],
                                      ),

                                    ),
                                  ),
                                ),
                              );
                          })
                    ],
                                    )

              ),
            )):
            Align(
              alignment: Alignment.center,
              child:
              Text(
                "Order is not Available",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600,color: AppTextColor.titleColor),
              ),
            )   );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context){
                              return  Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                                  child:
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Find Orders".toUpperCase(),style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTextColor.themeColor,)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Select Customer",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),),
                                            addHeight(2),
                                            SizedBox(
                                              height: 48,
                                              width: MediaQuery.of(context).size.width,
                                              child: DropdownButtonFormField<String>(
                                                iconEnabledColor: Colors.black,
                                                iconDisabledColor: Colors.black,
                                                // icon: const Icon(Icons.keyboard_arrow_down_rounded),
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
                                                  "Select customer",style: TextStyle(fontSize: 14,color: AppTextColor.greyColor),
                                                ),
                                                isExpanded: false,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please select a user type.';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (String? data) {
                                                  dropdownValue = data!;
                                                  // getOrderList();
                                                  log(dropdownValue.toString());
                                                  setState(() {

                                                  });
                                                },
                                                items: customerListModel?.success!.toList().map((value) {
                                                  return DropdownMenuItem(
                                                    value: value.id.toString(),
                                                    child: Row(
                                                      //mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          value.name.toString(),
                                                          style: const TextStyle(
                                                              color: Colors.black45,
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),

                                              ),
                                            ),
                                            addHeight(10),
                                             Text("Choose Date",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey,)),
                                            addHeight(2),
                                            Row(
                                              children: [
                                                 Expanded(child:
                                                 CommonTextFieldWidget1(
                                                   readOnly: true,
                                                   onTap: (){
                                                     startDate(context);
                                                   },
                                                  controller: startDateController,
                                                  hint: "From date",
                                                 )),
                                                addWidth(5),
                                                Expanded(child: CommonTextFieldWidget1(
                                                  readOnly: true,
                                                  onTap: (){
                                                    endDate(context);
                                                  },
                                                  controller: endDateController,
                                                  hint: "To date",
                                                )),
                                              ],
                                            ),
                                            // Image.asset("assets/images/DEMO.jpeg"),
                                            addHeight(15),
                                            CommonButtonBlue(title: "Get Order", onPressed: (){
                                              setState(()  {
                                          getOrderList();
                                              });
                                              Get.back();
                                              startDateController.clear();
                                              endDateController.clear();

                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
  }
}
