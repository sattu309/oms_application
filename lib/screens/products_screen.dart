import 'package:flutter/material.dart';
import 'package:oms_app/resuources/common_appbar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar1("Products", context),
      body:  Column(
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:Text("Products is not Available",style: Theme.of(context).textTheme.titleMedium,),
          )
        ],
      ),
    );
  }
}
