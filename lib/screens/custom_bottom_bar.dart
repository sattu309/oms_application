// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart' hide Badge;
// import 'package:get/get.dart';
// import 'package:oms_app/screens/my_cart.dart';
//
// import '../controllers/cart_local_data_controller.dart';
// import '../controllers/main_controller.dart';
// import '../controllers/user_details_controller.dart';
// import '../resuources/app_colors.dart';
// import 'category/all_categories_list.dart';
// import '../resuources/common_appbar.dart';
// import 'customers/stocks_info_page.dart';
// import 'dashboard_screen.dart';
// import 'drawer_page.dart';
//
// class CustomBar extends StatefulWidget {
//   const CustomBar({super.key});
//
//   @override
//   State<CustomBar> createState() => _CustomBarState();
// }
//
// class _CustomBarState extends State<CustomBar> {
//   final controller = Get.put(MainController());
//   final userDetailsController = Get.put(UserDetailsController());
//   final cartController = Get.put(CartLocallyData());
//   @override
//   void initState() {
//     super.initState();
//     userDetailsController.getUserDetails();
//     cartController.getCartDataLocally();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return
//     Obx((){
//       return
//         Scaffold(
//           drawer: const UserDrawer(),
//           key: controller.scaffoldKey,
//           appBar: controller.currentIndex.value == 0 ?
//           backAppBar("Hey Demo Singh",context):controller.currentIndex.value == 2 ? backAppBar1("MyCart",context):controller.currentIndex.value == 3 ? backAppBar1("Category",context):backAppBar1("Manage Stock",context),
//           bottomNavigationBar: Obx(() {
//             return
//               BottomAppBar(
//                 color: Colors.white,
//                 shape: const CircularNotchedRectangle(),
//                 clipBehavior: Clip.hardEdge,
//                 elevation: 0,
//                 child: Theme(
//                     data: ThemeData(
//                         splashColor: Colors.transparent,
//                         bottomNavigationBarTheme:
//                         const BottomNavigationBarThemeData(
//                             backgroundColor: Colors.white,
//                             elevation: 0)),
//                     child: BottomNavigationBar(
//                         unselectedLabelStyle: const TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.w400),
//                         selectedLabelStyle: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.redAccent),
//                         items: [
//                           BottomNavigationBarItem(
//                             icon: GestureDetector(
//                               onTap: (){
//                                 controller.onItemTap(0);
//                               },
//                               child: Icon(Icons.dashboard, size: 24, color: controller.currentIndex == 0 ? AppTextColor.primaryColor:null,),
//                             ),
//                             label: 'DashBoard',
//                           ),
//                           BottomNavigationBarItem(
//                               icon:
//                               GestureDetector(
//                                 onTap: ()async{
//                                   print(controller.currentIndex);
//                                   controller.onItemTap(1);
//
//                                 },
//                                 child: ImageIcon(AssetImage("assets/images/checklist.png"),size: 24,),
//                                 // child: Icon(Icons.bookmark_border_sharp,size: 24,color: controller.currentIndex == 1 ? AppTextColor.primaryColor:null),
//                               ),
//                               label: 'Orders'),
//                            BottomNavigationBarItem(
//                             icon:   Badge(
//                                 badgeStyle: BadgeStyle(badgeColor: Colors.green),
//                                 badgeContent:
//                                     Obx((){
//                                       return Text(
//                                       cartController.cartItemCount.value.toString()
//                                     ,style: TextStyle(color: Colors.white),);
//                                     }),
//
//
//                                 child: Icon(Icons.shopping_cart_outlined,size: 24,)),
//                               label: 'Cart'),
//                           BottomNavigationBarItem(
//                               icon: GestureDetector(
//                                 onTap: () async {
//                                   controller.onItemTap(3);
//                                   cartController.getCartDataLocally();
//
//                                 },
//                                 child: Icon(Icons.category_sharp,size: 24,color: controller.currentIndex == 3 ? AppTextColor.primaryColor:null),
//                               ),
//                               label: 'Categories'),
//
//                           BottomNavigationBarItem(
//                               icon: GestureDetector(
//                                 onTap: () {},
//                                 child: GestureDetector(
//                                   onTap: ()async{
//                                     controller.onItemTap(4);
//
//                                   }, child: Icon(Icons.report,size: 24,color: controller.currentIndex == 2 ? AppTextColor.primaryColor:null),
//                                 ),
//                               ),
//                               label: 'Reports'),
//
//                         ],
//                         type: BottomNavigationBarType.fixed,
//                         currentIndex: controller.currentIndex.value,
//                         selectedItemColor: AppTextColor.primaryColor,
//                         iconSize: 40,
//                         onTap: controller.onItemTap,
//                         elevation: 0)));
//           }),
//           body: Center(
//             child: Obx(() {
//               return IndexedStack(
//                 index: controller.currentIndex.value,
//                 children: const [
//                   DashboardScreen(),
//                   ManageStocksScreen(),
//                   CartScreen(),
//                   AllCategoriesList(),
//                   ManageStocksScreen(),
//
//                 ],
//               );
//             }),
//           ));
//     });
//
//   }
// }
