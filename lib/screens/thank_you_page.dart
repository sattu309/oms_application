import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
import 'package:oms_app/screens/componant_screens/common_button.dart';
import 'package:oms_app/screens/custom_bottom_bar.dart';
import 'package:oms_app/screens/new_bottom_appbar.dart';

import '../resuources/common_style_Text.dart';
import 'orders/order_details_screen.dart';

class ThankyouScreen extends StatefulWidget {
  final String orderId;
  final String orderDate;
  final String orderTotal;
  const ThankyouScreen({super.key, required this.orderId, required this.orderDate, required this.orderTotal});

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200], // Background color for the screen
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Checkmark Icon and Success Message
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green.withOpacity(0.2),
                child: Icon(Icons.check, color: Colors.green, size: 40),
              ),
              SizedBox(height: 16),
              Text(
                'Order Placed Successfully!',
                style: TextStyle(
                  fontSize: 18,
                  color: AppTextColor.titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              // Dashed Divider
              Row(
                children: List.generate(50, (index) {
                  return Expanded(
                    child: Container(
                      height: 1,
                      color: index.isOdd ? Colors.transparent : Colors.grey,
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              // Payment Details
              _buildDetailRow('Order ID',widget.orderId),
              SizedBox(height: 8),
              _buildDetailRow('Date', widget.orderDate),
              SizedBox(height: 16),

              // Dashed Divider
              Row(
                children: List.generate(50, (index) {
                  return Expanded(
                    child: Container(
                      height: 1,
                      color: index.isOdd ? Colors.transparent : Colors.grey,
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),

              // Amount
              _buildDetailRow('Amount', "$currencySymbol${widget.orderTotal}.00", isBold: true),
              SizedBox(height: 23),
              CommonButtonBlue(title: "View Details", onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return OrderDetailsScreen(orderId: widget.orderId, orderDate: widget.orderDate,);
                }));
              }),
              const SizedBox(height: 16),
              CommonButtonBlue(title: "Back To Home", onPressed: (){
                Get.to(()=>const MinimalExample(initialIndex: 0,));
              }),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildDetailRow(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: AppTextColor.titleColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

