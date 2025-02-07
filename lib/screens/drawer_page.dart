import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oms_app/controllers/main_controller.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
import 'package:oms_app/screens/login_flow/login_page.dart';
import 'package:oms_app/screens/orders/order_list.dart';
import 'package:oms_app/screens/products_screen.dart';
import 'package:oms_app/screens/revenue_card.dart';
import 'package:oms_app/screens/user_profile/profile_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_details_controller.dart';
import 'about_us_page.dart';
import 'analytics_page.dart';
import 'customers/add_customers.dart';
import 'customers/all_customers_list.dart';
import 'new_bottom_appbar.dart';


class UserDrawer extends StatefulWidget {
  final PersistentTabController navigationController;
  const UserDrawer({super.key, required this.navigationController});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {

  final controller = Get.put(MainController());
  final userDetailsController = Get.put(UserDetailsController());

  Widget _drawerTile(
      {required String title,
      required ImageIcon icon,
      required VoidCallback onTap,
     required int index
      }) {
    return ListTile(
      selectedTileColor: AppTextColor.primaryColor,
      leading: icon,
      minLeadingWidth: 30,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: AppTextColor.greyColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right_sharp,
          color: AppTextColor.greyColor),
      onTap: onTap,
    );
  }


  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // addHeight(60),

          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              color: AppTextColor.themeColor,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  addWidth(5),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(userDetailsController.userNameController.text, style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'system-ui;',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),),
                      addHeight(3),
                       Text(userDetailsController.userEmailController.text, style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'system-ui;',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),),
                    ],
                  )
                ],
              ),
            ),
          ),
          // addHeight(30),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                _drawerTile(
                    title: 'Dashboard',
                    icon: const ImageIcon(
                      AssetImage("assets/images/dashboard.png"),
                      size: 18,
                      color: AppTextColor.greyColor,
                    ),
                    onTap: () {

                      Navigator.pop(context);
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const MinimalExample(initialIndex: 0),
                      //   ),
                      // );d97676
                    }, index: 0,
                   ),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),
                _drawerTile(
                    title: 'Orders',
                    icon: const ImageIcon(AssetImage("assets/images/checklist.png"),
                      color: AppTextColor.greyColor,),
                  onTap: () {
                    Get.to(()=>OrderList());
                  }, index: 1,
                ),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),

                _drawerTile(
                  title: 'Category',
                  icon: const ImageIcon(AssetImage("assets/images/checklist.png"),
                    color: AppTextColor.greyColor,),
                  onTap: () {
                    widget.navigationController.jumpToTab(3);
                    Navigator.pop(context);
                  },
                  index: 3,
                ),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),
                _drawerTile(
                    title: 'Customers',
                    icon: const ImageIcon(AssetImage("assets/images/customer.png"),
                      color: AppTextColor.greyColor,),
                  onTap: () {
                    Get.to(()=>const AllCustomersList());
                    // Get.to(()=>const AddCustomer());
                  }, index: 3,),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),
                _drawerTile(
                  title: 'Profile',
                  icon: const ImageIcon(AssetImage("assets/images/user.png"),
                    color: AppTextColor.greyColor,),
                  onTap: () {
                    widget.navigationController.jumpToTab(4);
                    Navigator.pop(context);
                    // Get.to(()=>const ProfileScreen(showAppBar: true,));
                  }, index: 4,),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),
                _drawerTile(
                  title: 'About Us',
                  icon: const ImageIcon(AssetImage("assets/images/aboutUs.png"),
                    color: AppTextColor.greyColor,),
                  onTap: () {
                    Get.to(()=>const AboutUsPage());
                  }, index: 3,),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),

                _drawerTile(
                    title: 'Logout',
                    icon: const ImageIcon(AssetImage("assets/images/turn-off.png"),
                      color: AppTextColor.greyColor,),
                  onTap: () async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.clear();
                  Get.offAll(()=>LoginPage());

                  }, index: 5,),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
