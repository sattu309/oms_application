
import 'package:badges/badges.dart';
import 'package:flutter/material.dart'hide Badge;
import 'package:get/get.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/screens/dashboard_screen.dart';
import 'package:oms_app/screens/revenue_card.dart';
import 'package:oms_app/screens/user_profile/profile_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../controllers/cart_local_data_controller.dart';
import '../controllers/localtion_controller.dart';
import '../controllers/main_controller.dart';
import '../resuources/common_appbar.dart';
import 'category/all_categories_list.dart';
import 'drawer_page.dart';
import 'my_cart.dart';
import 'orders/order_list.dart';

class MinimalExample extends StatefulWidget {
  final int initialIndex;
  const MinimalExample({super.key,  required this.initialIndex});

  @override
  State<MinimalExample> createState() => _MinimalExampleState();
}

class _MinimalExampleState extends State<MinimalExample> {
  final controller = Get.put(MainController());
  final cartController = Get.put(CartLocallyData());
  final locationController = Get.put(LocationController());
  late PersistentTabController navigationController;
  final PersistentTabController persistentTabController =
  PersistentTabController(initialIndex: 0);
  DateTime? _lastBackPressed;
  Future<bool> onWillPop() async {
    final now = DateTime.now();
    const backPressDuration = Duration(seconds: 2);
    if (_lastBackPressed == null || now.difference(_lastBackPressed!) < backPressDuration) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: backPressDuration,
          backgroundColor: AppTextColor.themeColor,
        ),
      );
      return false;
    }
    return true;
  }
  List<PersistentTabConfig> tabs() => [
    PersistentTabConfig(
      screen: RevenueCard(),
      item: ItemConfig(
        icon: const Icon(Icons.home_filled),
        title: "Dashboard",
        activeForegroundColor: AppTextColor.themeColor,
      ),
    ),
    PersistentTabConfig(

      screen: const OrderList(showAppBar: false,),
      item: ItemConfig(
        icon:  const Icon(Icons.list_alt_rounded),
        title: "Orders",
        activeForegroundColor: AppTextColor.themeColor,
      ),
    ),
    PersistentTabConfig(
      screen: const CartScreen(),
      item: ItemConfig(
        icon:   Badge(
            badgeStyle: const BadgeStyle(badgeColor: AppTextColor.themeColor),
            badgeContent:
            Obx((){
              return Text(
                cartController.cartItemCount.value.toString()
                ,style: const TextStyle(color: Colors.white),);
            }),
            child: const Icon(Icons.shopping_cart_outlined,size: 24,)),
        title: "Cart",
        activeForegroundColor: AppTextColor.themeColor,
      ),
    ),
    PersistentTabConfig(
      screen: const AllCategoriesList(),
      item: ItemConfig(
        icon: const Icon(Icons.category_sharp),
        title: "Category",
        activeForegroundColor: AppTextColor.themeColor,
      ),
    ),
    PersistentTabConfig(
      screen: const ProfileScreen(showAppBar: false,),
      item: ItemConfig(
        icon:  Icon(Icons.person),
        title: "Profile",
        activeForegroundColor: AppTextColor.themeColor,
      ),
    ),
  ];


  @override
  void initState() {
    super.initState();
    locationController.checkGps(context);
    cartController.getCartDataLocally();
    navigationController = PersistentTabController(initialIndex: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return
        Obx((){
          return WillPopScope(
            onWillPop: () {
           return onWillPop();
            },
            child: Scaffold(
              drawer: controller.currentIndex.value == 0 ? UserDrawer(navigationController:persistentTabController,):null,
              key: controller.scaffoldKey,
              appBar:
              controller.currentIndex.value == 0 ?
              backAppBar("DASHBOARD",context):controller.currentIndex.value == 1 ?
              null:controller.currentIndex.value == 2 ? backAppBar1("MY CART",context):controller.currentIndex.value == 3 ? backAppBar1("CATEGORY",context):null,
              resizeToAvoidBottomInset: false,
              body:
              PersistentTabView(
                controller: persistentTabController,
                tabs: tabs(),
                // onTabChanged: (index) {
                //   controller.currentIndex.value = index;
                //   switch (index) {
                //     case 0:
                //       Navigator.popUntil(context, (route) => route.isFirst);
                //       controller.onItemTap(0);
                //       break;
                //     case 1:
                //       Navigator.of(context).popUntil((route) => route.isFirst);
                //       break;
                //     case 2:
                //       cartController.getCartDataLocally();
                //       Navigator.of(context).popUntil((route) => route.isFirst);
                //       break;
                //     case 3:
                //       cartController.getCartDataLocally();
                //       Navigator.of(context).popUntil((route) => route.isFirst);
                //       break;
                //     case 4:
                //       Navigator.of(context).popUntil((route) => route.isFirst);
                //       break;
                //   }
                // },
                onTabChanged: (index) {
                  controller.currentIndex.value = index;
                  print("INDEX: ${controller.currentIndex.value}");
                  },
                navBarBuilder: (navBarConfig) => Style1BottomNavBar(
                  navBarConfig: navBarConfig,
                  navBarDecoration: NavBarDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    padding: const EdgeInsets.all(8.0),

                  ),),
              popAllScreensOnTapOfSelectedTab: true,
                resizeToAvoidBottomInset: true,
              ),
            ),
          );
        });

  }
}
