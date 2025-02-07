import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
import '../../repository/login_repo.dart';
import '../componant_screens/common_button.dart';
import '../componant_screens/common_textfields.dart';
import 'otp_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final phoneController= TextEditingController();
  RxString errorText = "".obs;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
      Scaffold(
      backgroundColor: AppTextColor.themeColor,
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment. center,
          children: [
            // Top Section
            Container(
              height: height * .42,
              width: width*.7,
              decoration: const BoxDecoration(
                color: AppTextColor.themeColor,
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
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTextColor.themeColor),
                        ),
                        Text(
                          "Please login to your account",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTextColor.greyColor),
                        ),
                        addHeight(20),
                        CommonTextFieldWidget(
                          keyboardType: TextInputType.number,
                          length: 10,
                          controller: phoneController,
                          hint: "Mobile number",
                          prefix: Icon(
                            Icons.phone_android,
                            color: AppTextColor.greyColor,
                          ),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Mobile Number is Required'),
                          ]),

                        ),
                      addHeight(40),
                         CommonButtonBlue(
                           title: 'Sign In',
                           onPressed: () {
                             if (formKey.currentState!.validate()) {
                               setState(() {
                                 isLoading = true;
                               });

                               createLogin(mobileNumber: phoneController.text, context: context).then((value) {
                                 setState(() {
                                   isLoading = false; // Stop the loader
                                 });

                                 if (value.success != null) {
                                   Get.off(() => OtpScreen(mobileNumber: phoneController.text));
                                 } else {
                                   errorText.value = value.error ?? 'An unexpected error occurred';
                                   log('Error Message: ${errorText.value}');
                                 }
                               }).catchError((e) {
                                 // Handle unexpected exceptions
                                 setState(() {
                                   isLoading = false; // Stop the loader
                                 });
                                 log('Unexpected Error: $e');
                               });
                             }
                           }
                           ,),
                        addHeight(20),

                        isLoading == true ?
                          const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          ):const SizedBox()
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
