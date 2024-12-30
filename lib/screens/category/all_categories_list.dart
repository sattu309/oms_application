import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../componant_screens/add_height_widtth.dart';
import 'component/plus_minus_component.dart';

class AllCategoriesList extends StatefulWidget {
  const AllCategoriesList({super.key});

  @override
  State<AllCategoriesList> createState() => _AllCategoriesListState();
}

class _AllCategoriesListState extends State<AllCategoriesList> {
bool addButtonCliked = false;

  int counter = 1;
  increaseCounter() {
    counter++;
    setState(() {});
  }

  decreaseCounter() {
    if (counter > 1) {
      counter--;
    }else{
      addButtonCliked = false;
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: backAppBar1("Categories", context),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: CustomScrollView(
          slivers: [
          
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 0.0,
                  mainAxisExtent: 115,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Center(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              addHeight(10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("assets/images/demo.png", height: 80),
                              ),
                              addHeight(3),
                              const Text(
                                "Cat 1",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 6,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addHeight(14),
                  Text("Products", style: Theme.of(context).textTheme.titleMedium),
                  addHeight(5),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, 1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.10),
                        )
                      ],
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
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  addHeight(3),
                                  Text("ABC-12345-S-BL",
                                      style: Theme.of(context).textTheme.bodySmall),
                                  addHeight(4),
                                  Text(
                                    "₹888",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  addHeight(4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                  Row(
                                  children: [
                                  RoundedIconBtn(
                                  icon: Icons.remove,
                                    press: () {
                                      decreaseCounter();
                                    },
                                  ),
                                  addWidth(8),
                                  Text(counter.toString()),
                                    addWidth(8),
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
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    addButtonCliked = true;
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 6, vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    color: Colors.black,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: const Offset(1, 1),
                                                        spreadRadius: 1,
                                                        blurRadius: 2,
                                                        color:
                                                        Colors.black.withOpacity(
                                                            0.10),
                                                      )
                                                    ],
                                                  ),
                                                  child: const Text(
                                                    "ADD TO ORDER",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )


                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                childCount: 30,
              ),
            ),
          ],
        ),
      )
    );
  }
}
