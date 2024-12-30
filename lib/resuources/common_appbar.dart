 import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oms_app/resuources/constants.dart';

import '../screens/my_cart.dart';

AppBar backAppBar(String title,BuildContext context){
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('EEEE, MMM d ').format(now);
  return AppBar(
    toolbarHeight: 70,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(formattedDate,style: Theme.of(context).textTheme.bodySmall,),
        Text(title,style: Theme.of(context).textTheme.titleSmall),
      ],
    ),
    actions:  [
      Padding(
        padding: EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return CartScreen();
            }));
          },
            child
            : const Icon(Icons.shopping_basket_rounded,color: Colors.black,)),
      ),
    ],
  );
 }

 AppBar backAppBar1(String title,BuildContext context){
   return AppBar(
     backgroundColor: AppTextColor.primaryColor,
     centerTitle: false,
     title: Text(title,style: Theme.of(context).textTheme.titleSmall),
   );
 }