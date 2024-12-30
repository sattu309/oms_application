import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oms_app/controllers/main_controller.dart';
import 'package:oms_app/resuources/constants.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';

import '../resuources/custom_snackbar.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  final controller = Get.put(MainController());
  int index = -1;

  Widget _drawerTile(
      {required String title,
      required ImageIcon icon,
      required VoidCallback onTap,
      required bool isSelected
      }) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade500 : Colors.transparent),
      child: ListTile(
        selectedTileColor: AppTextColor.primaryColor,
        leading: icon,
        minLeadingWidth: 30,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: AppTextColor.menuColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right_sharp,
            color: AppTextColor.menuColor),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff222220),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          addHeight(50),
           Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,),
                addWidth(10),
                const Text("Settings & Members", style: TextStyle(
                  fontFamily: 'system-ui;',
                  fontSize: 15,
                  color: AppTextColor.menuColor,
                  fontWeight: FontWeight.w400,
                ),)
              ],
            ),
          ),
          addHeight(30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTextColor.greyColor)),
                  child: const Icon(
                    Icons.person,
                    color: AppTextColor.menuColor,
                  ),
                ),
                addWidth(10),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Test User Singh", style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'system-ui;',
                      color: AppTextColor.menuColor,
                      fontWeight: FontWeight.w400,
                    ),),
                    addHeight(3),
                    const Text("test@gmail.com", style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'system-ui;',
                      color: AppTextColor.greyColor,
                      fontWeight: FontWeight.w400,
                    ),),
                  ],
                )
              ],
            ),
          ),
          addHeight(30),
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
                      color: AppTextColor.menuColor,
                    ),
                   isSelected: index == 1,
                    onTap: () {
                      setState(() {
                        index = 1 ;
                      });
                      controller.onItemTap(0);
                      Get.back();
                    },
                   ),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),
                _drawerTile(
                    title: 'Orders',
                    icon: const ImageIcon(AssetImage("assets/images/checklist.png"),
                        color: AppTextColor.menuColor),
                  isSelected: index == 2,
                  onTap: () {
                    setState(() {
                      index =2 ;
                    });
                    controller.onItemTap(1);
                    Get.back();
                  },
                ),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),
                _drawerTile(
                    title: 'Customers',
                    icon: const ImageIcon(AssetImage("assets/images/customer.png"),
                        color: AppTextColor.menuColor),
                  isSelected: index == 3,
                  onTap: () {
                    setState(() {
                      index =3 ;
                    });
                    showSnackBarView(context: context, message: 'Heyy', backGroundColor: Colors.green);
                    // controller.onItemTap(1);
                    // Get.back();
                  },),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),
                _drawerTile(
                    title: 'Profile',
                    icon: const ImageIcon(AssetImage("assets/images/user.png"),
                        color: AppTextColor.menuColor),
                  isSelected: index == 4,
                  onTap: () {
                    setState(() {
                      index =4 ;
                    });
                    // controller.onItemTap(1);
                    // Get.back();
                  },),
                const Divider(
                  height: 0,
                  color: AppTextColor.greyColor,
                ),
                _drawerTile(
                    title: 'Logout',
                    icon: const ImageIcon(AssetImage("assets/images/turn-off.png"),
                        color: AppTextColor.menuColor),
                  isSelected: index == 5,
                  onTap: () {
                    setState(() {
                      index =5 ;
                    });

                  },),
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
