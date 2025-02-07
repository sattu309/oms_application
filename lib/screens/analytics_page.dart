import 'package:flutter/material.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/resuources/common_appbar.dart';

import 'componant_screens/add_height_widtth.dart';
import 'customers/add_customers.dart';
import 'customers/all_customers_list.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextColor.themeColor,
        automaticallyImplyLeading: false,
        title:GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back,color: Colors.white,),
              addWidth(7),
              Text("CUSTOMER DETAILS",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),
            ],
          ),
        ),
      ),
      body:
      Column(
        children: [
          // const SizedBox(height: 5,),
          Stack(
            children: [
              Positioned.fill(
                  bottom: 0,
                  child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1.0),
                        ),
                      ))),
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: AppTextColor.primaryColor,
                physics: const BouncingScrollPhysics(),
                labelStyle: const TextStyle(color: AppTextColor.primaryColor, fontSize: 16, fontWeight: FontWeight.w500),
                controller: tabController,
                unselectedLabelColor: const Color(0xFF9B9B9B),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.0,
                    color: AppTextColor.primaryColor,
                  ),
                ),
                tabs: const [
                  Tab(
                    text: '  CUSTOMER   ',
                  ),
                  Tab(
                    text: 'ADD ',
                  ),
                ],
              ),
            ],
          ),
          // addHeight(16),
          Expanded(
            child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                children: const [
                  AllCustomersList(),
                  // AddCustomer(),
                ]),
          ),
        ],
      ),
    );
  }
}
