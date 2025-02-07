import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
import 'package:oms_app/screens/revenue_card.dart';

import '../common_repo/common_api_repo.dart';
import '../models/dashboard_model.dart';
import '../resuources/api_urls.dart';
import '../resuources/common_style_Text.dart';
import 'customers/all_customers_list.dart';
import 'customers/customer_details.dart';
import 'orders/order_details_screen.dart';
import 'orders/order_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  DashBoardModel? dashBoardModel;
  Repositories repositories = Repositories();
  getDashBoardData() async {
    repositories.getApi(url: ApiUrls.dashBoardUrl)
        .then((value) {
      dashBoardModel = DashBoardModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getDashBoardData();

  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addHeight(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100),
                      color: Colors.orange.shade200,
                      borderRadius: BorderRadius.circular(5)
                      // boxShadow: [
                      //   BoxShadow(
                      //       offset: const Offset(4, 4),
                      //       spreadRadius: 2,
                      //       blurRadius: 5,
                      //       color: Colors.black.withOpacity(0.10)
                      //   )
                      // ],

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageIcon(AssetImage("assets/images/customer.png"),color: AppTextColor.themeColor,),
                        Text("Products",style: Theme.of(context).textTheme.titleSmall,),
                        Text(dashBoardModel!.totalProducts.toString(),style: Theme.of(context).textTheme.titleSmall,)
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade100),
                      // gradient: const LinearGradient(
                      //   colors: [AppTextColor.greyColor,Colors.cyan],
                      //   begin: Alignment.bottomCenter,
                      //   end: Alignment.topCenter,
                      // ),
                      color: Colors.lightBlue.shade200,

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageIcon(AssetImage("assets/images/customer.png"),color: AppTextColor.themeColor,),
                        Text("Inventory",style: Theme.of(context).textTheme.titleSmall,),
                        Text(dashBoardModel!.totalInventory.toString(),style: Theme.of(context).textTheme.titleSmall,)

                      ],
                    ),
                  ),
                ],
              ),

              // GridView.builder(
              //   padding: EdgeInsets.zero,
              //     gridDelegate:
              //     const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       childAspectRatio: 0.6,
              //       mainAxisSpacing: 0,
              //       crossAxisSpacing: 10,
              //       mainAxisExtent: 120,
              //     ),
              //   shrinkWrap: true,
              //     itemCount: 2,
              //     itemBuilder: (BuildContext ,index){
              //   return buildContainer(context);
              // }, ),
              addHeight(10),
              // RevenueCard(),
              // Container(
              //   height: height*.2,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey.shade200),
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              //   child: BarChart(
              //     BarChartData(
              //       barGroups: _getBarGroups(),
              //       titlesData: FlTitlesData(
              //         leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true)),
              //         bottomTitles: AxisTitles(
              //           sideTitles: SideTitles(
              //             showTitles: true,
              //             getTitlesWidget: (value, meta) {
              //               switch (value.toInt()) {
              //                 case 0:
              //                   return Text('Mon',style: Theme.of(context).textTheme.bodySmall,);
              //                 case 1:
              //                   return Text('Tue',style: Theme.of(context).textTheme.bodySmall,);
              //                 case 2:
              //                   return Text('Wed',style: Theme.of(context).textTheme.bodySmall,);
              //                 case 3:
              //                   return Text('Thu',style: Theme.of(context).textTheme.bodySmall,);
              //                 case 4:
              //                   return Text('Fri',style: Theme.of(context).textTheme.bodySmall,);
              //                 case 5:
              //                   return Text('Sat',style: Theme.of(context).textTheme.bodySmall,);
              //                 case 6:
              //                   return Text('Sun',style: Theme.of(context).textTheme.bodySmall,);
              //                 default:
              //                   return Text('');
              //               }
              //             },
              //           ),
              //         ),
              //       ),
              //       borderData: FlBorderData(show: false),
              //       backgroundColor: Colors.white,
              //       gridData: const FlGridData(
              //           show: false),
              //     ),
              //   ),
              // ),
              addHeight(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recent Orders".toUpperCase(),style: Theme.of(context).textTheme.titleSmall,),
                  GestureDetector(
                      onTap: (){
                        Get.to(()=>OrderList());
                      },
                      child: Text("ViewAll",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTextColor.themeColor),)),
                ],
              ),
              addHeight(5),
              ListView.builder(
                  itemCount: dashBoardModel!.recentOrder!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final orderData = dashBoardModel!.recentOrder![index];
                    return
                      Container(
                        // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade200),
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.white],
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

                                ],
                              ),

                            ),
                          ),
                        ),
                      );
                  }),
              addHeight(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recent Customers".toUpperCase(),style: Theme.of(context).textTheme.titleSmall,),
                  GestureDetector(
                      onTap: (){
                        Get.to(()=>AllCustomersList());
                      },
                      child: Text("ViewAll",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTextColor.themeColor),)),
                ],
              ),
              addHeight(5),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:dashBoardModel!.recentCustomer!.length,
                  itemBuilder: (context, index) {
                    final listData = dashBoardModel!.recentCustomer![index];
                    return
                      buildGestureDetector(listData, context);
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
  List<BarChartGroupData> _getBarGroups() {

    // List<Color> barColors = [
    //   Colors.blue,
    //   Colors.green,
    //   Colors.orange,
    //   Colors.purple,
    //   Colors.red,
    //   Colors.teal,
    //   Colors.amber
    // ];
    return List.generate(7, (index) {
      return
        BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (index + 2) * 2.0, // Bar height
            gradient: const LinearGradient(
              colors: [AppTextColor.greyColor,Colors.cyan],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            width: 18, // Adjust bar width
            borderRadius: BorderRadius.circular(0), // Rounded bars
          ),
        ],
      );
    });
  }
}
GestureDetector buildGestureDetector(RecentCustomer listData, BuildContext context) {
  return GestureDetector(
    onTap: (){
      // Get.to(()=>EditCustomerDetails(customerId: listData.id.toString(),));
      // Get.to(()=>CustomerDetails(customerId: listData.id.toString(),));
    },
    child:
    Container(
      margin: const EdgeInsets.symmetric(vertical: 3,),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade200),
        gradient: const LinearGradient(
          colors: [Colors.white, Colors.white],
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
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child:
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTextColor.greyColor),
              ),
              child:Image.asset("assets/images/user.png",height: 25,width: 25,color: AppTextColor.greyColor,) ,
            ),
            addWidth(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "${listData.name.toString().capitalizeFirst}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: Colors.grey.shade700,fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(child: Text("${ listData.city.toString().capitalizeFirst} ${ listData.state.toString().capitalizeFirst}, ${ listData.pincode.toString()}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey,fontSize: 11),)),
                      // GestureDetector(
                      //     onTap: (){
                      //       // makingPhoneCall("Tel: +91${listData.phone.toString()}");
                      //     },
                      //     child: const Icon(Icons.call,color: AppTextColor.themeColor,size: 16,))
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: (){
                  // makingPhoneCall("Tel: +91${listData.phone.toString()}");
                },
                child: const Icon(Icons.call,color: AppTextColor.themeColor,size: 16,))
          ],
        ),
      ),
    ),
  );
}



