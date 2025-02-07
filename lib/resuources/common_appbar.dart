 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oms_app/controllers/main_controller.dart';
import 'package:oms_app/resuources/app_colors.dart';

import '../controllers/user_details_controller.dart';


AppBar backAppBar(String title,BuildContext context){
  final userDetailsController = Get.put(UserDetailsController());
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('EEEE, MMM d ').format(now);
  return AppBar(
    toolbarHeight: 70,
    backgroundColor: AppTextColor.themeColor,
    centerTitle: true,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text(formattedDate,style:TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),),
        Text(title,style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
    actions:  [
      Obx((){
        return  Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 35,
                  width: 38,
              child: CircleAvatar(
                radius: 50, // Customize the size if needed
                backgroundImage: userDetailsController.image.value != null
                    ? FileImage(userDetailsController.image.value!)
                    : AssetImage("assets/images/pic.png") as ImageProvider,
                backgroundColor: Colors.transparent, // Optional, for styling
              ),
            ),
          ),
        );
      }),
    ],
  );
 }

 AppBar backAppBar1(String title,BuildContext context){
   return AppBar(
     elevation: 0,
     backgroundColor: AppTextColor.themeColor,
     centerTitle: false,
     title: Text(title,style: Theme.of(context).textTheme.bodyMedium),
   );
 }