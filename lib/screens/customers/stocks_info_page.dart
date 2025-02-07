import 'package:flutter/material.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/screens/dashboard_screen.dart';

import '../login_flow/otp_screen.dart';
import 'add_customers.dart';

class ManageStocksScreen extends StatelessWidget {
  const ManageStocksScreen({super.key});

  Widget buildStockOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      // margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: ListTile(
          leading: Icon(icon, color: AppTextColor.themeColor),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(description),
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 4,vertical: 3),
              decoration: BoxDecoration(
                color: AppTextColor.themeColor,
                shape: BoxShape.circle
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.white,size: 17,)),
          onTap: onTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
       // appBar: AppBar(
       //   backgroundColor: Colors.transparent,
       //   title: Text("Mange Stocks",style: Theme.of(context).textTheme.titleLarge,),
       // ),
        body:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text("Mange Stocks",style: Theme.of(context).textTheme.titleLarge,),
              Expanded(
                child: ListView(
                  children: [
                    buildStockOption(
                      icon: Icons.input,
                      title: "Record Stock Receipt",
                      description: "Create records for stock received at the warehouse",
                      onTap: () {
                        // Navigate to Record Stock Receipt Screen
                      },
                    ),
                    buildStockOption(
                      icon: Icons.outbox,
                      title: "Record Stock Issued",
                      description: "Create records for stock sent out from the warehouse",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                          return AddCustomer(update: () {  },);
                        }));
                      },
                    ),
                    buildStockOption(
                      icon: Icons.restart_alt,
                      title: "Stock Returned",
                      description: "Create records for the stock returned to the warehouse",
                      onTap: () {

                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                        //   return const OtpScreen();
                        // }));
                      },
                    ),
                    buildStockOption(
                      icon: Icons.warning_amber_rounded,
                      title: "Stock Damaged",
                      description: "Record the list of resources damaged during campaign operations",
                      onTap: () {
                        // Navigate to Stock Damaged Screen
                      },
                    ),
                    buildStockOption(
                      icon: Icons.storefront,
                      title: "Stock Loss",
                      description: "Record the list of resources lost during campaign operations",
                      onTap: () {
                        // Navigate to Stock Loss Screen
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}