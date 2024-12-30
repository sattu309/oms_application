import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oms_app/resuources/constants.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';

import '../../resuources/custom_loader.dart';
import '../componant_screens/common_button.dart';
import '../componant_screens/common_textfields.dart';
import '../custom_bottom_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController= TextEditingController();
  final passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
      Scaffold(
      backgroundColor: AppTextColor.primaryColor,
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment. center,
          children: [
            // Top Section
            Container(
              height: height * .42,
              width: width*.7,
              decoration: BoxDecoration(
                color: AppTextColor.primaryColor,
                image: DecorationImage(
                  image: AssetImage("assets/images/oms_new_logo.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            // addHeight(10),

            Container(
              width: width,
              constraints: BoxConstraints(
                minHeight: height * 0.58, // Take up remaining space
              ),
              // height: height,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), // Curved corners
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addHeight(15),
                        Text(
                          "Welcome",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "Please login to your account",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        addHeight(20),
                        CommonTextFieldWidget(
                          controller: emailController,
                          hint: "Username",
                          prefix: Icon(
                            Icons.person,
                            color: AppTextColor.greyColor,
                          ),
                        ),
                        addHeight(15),
                        CommonTextFieldWidget(
                          controller: passwordController,
                          hint: "Password",
                          prefix: Icon(
                            Icons.lock,
                            color: AppTextColor.greyColor,
                          ),
                          suffix: Icon(
                            Icons.visibility,
                            color: AppTextColor.greyColor,
                          ),
                        ),
                        addHeight(40),
                         CommonButtonBlue( title: 'Sign In',onPressed: (){
                           // Navigator.push(
                           //   context,
                           //   MaterialPageRoute(builder: (context) => const AppLoader()),
                           // );
                           // threeArchedCircle(color: Colors.black, size: 80,);
                           Get.off(()=> CustomBar());

                        },),
                        addHeight(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            addWidth(7),
                            const Text(
                              "Contact Your Manager",
                              style: TextStyle(color: AppTextColor.primaryColor,fontSize: 15,fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
