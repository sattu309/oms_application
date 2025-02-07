import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oms_app/resuources/app_colors.dart';
import '../common_repo/common_api_repo.dart';
import '../models/dashboard_model.dart';
import '../resuources/api_urls.dart';
import '../resuources/common_style_Text.dart';
import '../resuources/custom_loader.dart';
import 'componant_screens/add_height_widtth.dart';
import 'customers/all_customers_list.dart';
import 'dashboard_screen.dart';
import 'orders/order_list.dart';

class RevenueCard extends StatefulWidget {
  @override
  State<RevenueCard> createState() => _RevenueCardState();
}

class _RevenueCardState extends State<RevenueCard> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          dashBoardModel != null ?
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: RefreshIndicator(
            color: AppTextColor.themeColor,
            onRefresh: () async {
              return await getDashBoardData();
            },
            child: Column(
              children: [
                addHeight(5),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  // width: 300,
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Revenue",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: AppTextColor.titleColor),
                      ),
                      SizedBox(height: 4),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${currencySymbol}120,210",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTextColor.greyColor
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "7.56% ↑",
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Flexible(
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 30,
                            barGroups: _getBarGroups(),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 26:
                                        return Text("\$10k", style: TextStyle(fontSize: 12,color: AppTextColor.titleColor));
                                      case 20:
                                        return Text("\$20k", style: TextStyle(fontSize: 12));
                                      case 30:
                                        return Text("\$30k", style: TextStyle(fontSize: 12));
                                      default:
                                        return SizedBox.shrink();
                                    }
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    List<String> weeks = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                                    return Text(weeks[value.toInt()], style: TextStyle(fontSize: 10,color: AppTextColor.greyColor));
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: true, drawVerticalLine: false),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                addHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recent Orders",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: AppTextColor.titleColor),
                    ),
                    GestureDetector(
                        onTap: (){
                          Get.to(()=>OrderList());
                        },
                        child: Text("ViewAll",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTextColor.themeColor,fontWeight: FontWeight.bold),)),
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
                           margin: const EdgeInsets.symmetric(vertical: 3,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200),
                            gradient: const LinearGradient(
                              colors: [Colors.white, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.1),
                            //     blurRadius: 10,
                            //     offset: Offset(0, 5),
                            //   ),
                            // ],
                          ),
                          child: InkWell(
                            onTap: () {
                              // String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.parse(orderData.createdAt.toString()));
                              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              //   return OrderDetailsScreen(
                              //     orderId: orderData.id.toString(),
                              //     orderDate: formattedDate,
                              //   );
                              // }));
                            },
                            // cc2b21
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
                    Text("Recent Customers",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: AppTextColor.titleColor),
                    ),
                    GestureDetector(
                        onTap: (){
                          Get.to(()=>AllCustomersList());
                        },
                        child: Text("ViewAll",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTextColor.themeColor,fontWeight: FontWeight.bold),)),
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
      ):
          Center(child: threeArchedCircle(color: AppTextColor.themeColor, size: 30))
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    List<double> data = [25, 32, 18, 28, 22, 12,26]; // Revenue data

    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(

            toY: data[index],
            gradient: LinearGradient(
              colors: [
               Colors.blue.shade200,
                Colors.cyan
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            // color: Colors.blue,
            width: 10,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }
}


