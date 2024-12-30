import 'package:flutter/material.dart';

import 'category/component/plus_minus_component.dart';
import 'componant_screens/add_height_widtth.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int counter = 1;
  increaseCounter() {
    counter++;
    setState(() {});
  }

  decreaseCounter() {
    if (counter > 1) {
      counter--;
    }else{

    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 0,
            elevation: 0,
            pinned: true,
            title:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade200)
                      ),
                      child: Icon(Icons.arrow_back,color: Colors.black,size: 18,)),
                ),
                 Text("MyCart",style: Theme.of(context).textTheme.titleMedium,),
                const Text(""),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5,color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70,
                      // boxShadow: [
                      //   BoxShadow(
                      //     offset: const Offset(1, 1),
                      //     spreadRadius: 1,
                      //     blurRadius: 2,
                      //     color: Colors.black.withOpacity(0.10),
                      //   )
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/dmeo.png",
                              width: 90,
                              fit: BoxFit.fitHeight,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Narjo collection of accessories..",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  addHeight(3),
                                  Text("ABC-12345-S-BL",
                                      style: Theme.of(context).textTheme.titleSmall),
                                  addHeight(4),

                                  addHeight(4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "₹888",
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          children: [

                                            RoundedIconBtn(
                                              icon: Icons.remove,
                                              press: () {
                                                decreaseCounter();
                                              },
                                            ),
                                            addWidth(12),
                                            Text(counter.toString(),style: Theme.of(context).textTheme.bodySmall,),
                                            addWidth(12),
                                            RoundedIconBtn(
                                              icon: Icons.add,
                                              press: () {
                                                setState(() {
                                                  increaseCounter();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Align(
                                      //   alignment: Alignment.centerRight,
                                      //   child: Row(
                                      //     mainAxisSize: MainAxisSize.min,
                                      //     children: [
                                      //       GestureDetector(
                                      //         onTap: () {
                                      //
                                      //         },
                                      //         child: Container(
                                      //           padding: const EdgeInsets.symmetric(
                                      //               horizontal: 6, vertical: 6),
                                      //           decoration: BoxDecoration(
                                      //             borderRadius:
                                      //             BorderRadius.circular(5),
                                      //             color: Colors.black,
                                      //             boxShadow: [
                                      //               BoxShadow(
                                      //                 offset: const Offset(1, 1),
                                      //                 spreadRadius: 1,
                                      //                 blurRadius: 2,
                                      //                 color:
                                      //                 Colors.black.withOpacity(
                                      //                     0.10),
                                      //               )
                                      //             ],
                                      //           ),
                                      //           child: const Text(
                                      //             "ADD TO ORDER",
                                      //             style: TextStyle(
                                      //                 fontSize: 10,
                                      //                 color: Colors.white),
                                      //           ),
                                      //         ),
                                      //       )
                                      //
                                      //
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 4,
            ),
          ),
        ],
      )
    );
  }
}
