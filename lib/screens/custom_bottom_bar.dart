import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../resuources/constants.dart';
import 'category/all_categories_list.dart';
import '../resuources/common_appbar.dart';
import 'dashboard_screen.dart';
import 'drawer_page.dart';
import 'manage_stocks/stocks_info_page.dart';

class CustomBar extends StatefulWidget {
  const CustomBar({super.key});

  @override
  State<CustomBar> createState() => _CustomBarState();
}

class _CustomBarState extends State<CustomBar> {
  final controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return
    Obx((){
      return
        Scaffold(
          drawer: const UserDrawer(),
          key: controller.scaffoldKey,
          appBar: controller.currentIndex.value == 0 ?
          backAppBar("Hey Demo Singh",context):controller.currentIndex.value == 3 ? backAppBar1("Category",context):backAppBar1("Manage Stock",context),
          bottomNavigationBar: Obx(() {
            return

              BottomAppBar(
                color: Colors.white,
                shape: const CircularNotchedRectangle(),
                clipBehavior: Clip.hardEdge,
                elevation: 0,
                child: Theme(
                    data: ThemeData(
                        splashColor: Colors.transparent,
                        bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                            backgroundColor: Colors.white,
                            elevation: 0)),
                    child: BottomNavigationBar(
                        unselectedLabelStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                        selectedLabelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.redAccent),
                        items: [
                          BottomNavigationBarItem(
                            icon: GestureDetector(
                              onTap: (){
                                controller.onItemTap(0);
                              },
                              child: Icon(Icons.dashboard, size: 24, color: controller.currentIndex == 0 ? AppTextColor.primaryColor:null,),
                            ),
                            label: 'DashBoard',
                          ),
                          BottomNavigationBarItem(
                              icon:
                              GestureDetector(
                                onTap: ()async{
                                  print(controller.currentIndex);
                                  controller.onItemTap(1);

                                },
                                child: ImageIcon(AssetImage("assets/images/checklist.png"),size: 24,),
                                // child: Icon(Icons.bookmark_border_sharp,size: 24,color: controller.currentIndex == 1 ? AppTextColor.primaryColor:null),
                              ),
                              label: 'Orders'),

                          BottomNavigationBarItem(
                              icon: GestureDetector(
                                onTap: () {},
                                child: GestureDetector(
                                  onTap: ()async{
                                    controller.onItemTap(2);

                                  }, child: Icon(Icons.report,size: 24,color: controller.currentIndex == 2 ? AppTextColor.primaryColor:null),
                                ),
                              ),
                              label: 'Reports'),
                          BottomNavigationBarItem(
                              icon: GestureDetector(
                                onTap: () async {
                                  controller.onItemTap(3);

                                },
                                child: Icon(Icons.category_sharp,size: 24,color: controller.currentIndex == 3 ? AppTextColor.primaryColor:null),
                              ),
                              label: 'Categories'),
                        ],
                        type: BottomNavigationBarType.fixed,
                        currentIndex: controller.currentIndex.value,
                        selectedItemColor: AppTextColor.primaryColor,
                        iconSize: 40,
                        onTap: controller.onItemTap,
                        elevation: 0)));
          }),
          body: Center(
            child: Obx(() {
              return IndexedStack(
                index: controller.currentIndex.value,
                children: const [
                  DashboardScreen(),
                  ManageStocksScreen(),
                  ManageStocksScreen(),
                  AllCategoriesList(),
                ],
              );
            }),
          ));
    });

  }
}
