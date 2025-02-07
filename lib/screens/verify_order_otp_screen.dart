// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:oms_app/resuources/app_colors.dart';
// import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
// import 'package:oms_app/screens/custom_bottom_bar.dart';
// import 'package:oms_app/screens/new_bottom_appbar.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../repository/login_repo.dart';
//
// class VerifyOrderOtpScreen extends StatefulWidget {
//   final String mobileNumber;
//   const VerifyOrderOtpScreen({super.key, required this.mobileNumber});
//
//   @override
//   State<VerifyOrderOtpScreen> createState() => _VerifyOrderOtpScreenState();
// }
//
// class _VerifyOrderOtpScreenState extends State<VerifyOrderOtpScreen> {
//   final otpController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   late Timer timer;
//   RxInt timerSeconds = 10.obs;
//   RxBool showTimer = false.obs;
//   bool isLoading = false;
//   setTimer() {
//     if (showTimer.value == false) {
//       showTimer.value = true;
//       timer = Timer.periodic(const Duration(seconds: 1), (value) {
//         if (timerSeconds.value > 1) {
//           timerSeconds.value--;
//         } else {
//           showTimer.value = false;
//           timer.cancel();
//           timerSeconds.value = 10;
//         }
//       });
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//     print(widget.mobileNumber);
//     setTimer();
//   }
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: AppTextColor.primaryColor,
//       body:
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 13,),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: height*.1,),
//                 Image.asset("assets/images/oms_new_logo.png",height: height*.3,),
//                 const Text("OTP Verification For Order",style: TextStyle(fontSize: 19,color: Colors.white),),
//                 addHeight(5),
//                 Text("Enter the code sent on this number\n                    7898899787",style: Theme.of(context).textTheme.titleSmall,),
//                 addHeight(20),
//                 PinCodeTextField(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   appContext: context,
//                   textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
//                   controller: otpController,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   pastedTextStyle: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.normal,
//                   ),
//                   animationType: AnimationType.fade,
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return "                                  OTP code Required";
//                     } else if (v.length != 4) {
//                       return "                         Enter complete OTP code";
//                     }
//                     return null;
//                   },
//                   length: 4,
//                   pinTheme: PinTheme(
//                     fieldOuterPadding:
//                     const EdgeInsets.symmetric(horizontal: 5),
//                     borderWidth: 1,
//                     inactiveBorderWidth: 1,
//                     activeBorderWidth: 1,
//                     shape: PinCodeFieldShape.box,
//                     borderRadius: BorderRadius.circular(8),
//                     fieldWidth: 40,
//                     fieldHeight: 40,
//                     activeFillColor: Colors.white,
//                     inactiveColor: Colors.white,
//                     inactiveFillColor: Colors.black,
//                     selectedFillColor: Colors.white,
//                     selectedColor: Colors.white,
//                     activeColor: Colors.white,
//                   ),
//                   cursorColor: Colors.white,
//                   enablePinAutofill: true,
//                   keyboardType: TextInputType.number,
//                   onChanged: (v) {
//                     setState(() {
//                     });
//                   },
//                 ),
//
//                 GestureDetector(
//                     onTap: () {
//                       // if (showTimer.value == false) {
//                       //   resendOtpRepo(
//                       //       mobileNumber: widget.mobileNumber,
//                       //       context: context)
//                       //       .then((value) {
//                       //     if (value.success != null) {
//                       //       Helpers.showToast(
//                       //           value.success.toString());
//                       //       setTimer();
//                       //     } else {
//                       //       Helpers.showToast(value.error.toString());
//                       //     }
//                       //     return;
//                       //   });
//                       // }
//                     },
//                     child:
//                     Obx((){
//                       return  Text(
//                           !showTimer.value
//                               ? "Resend OTP"
//                               : "Resend OTP in 00:${timerSeconds.value > 9 ?
//                           timerSeconds.value : "0${timerSeconds.value}"}",
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                               decoration: TextDecoration.underline,
//                               fontSize: 15,
//                               color: Colors.red,
//                               fontWeight: FontWeight.w400));
//                     })
//
//                 ),
//                 SizedBox(height: height*.05,),
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: AppTextColor.primaryColor
//                   ),
//                   child:
//                   ElevatedButton(
//                       onPressed: () {
//                         if (formKey.currentState!.validate()) {
//                           setState(() {
//                             isLoading = true;
//                           });
//                           otpVerifyRepo(
//                             mobileNumber: widget.mobileNumber,
//                             otp: otpController.text,
//                             context: context,
//                           ).then((value) async {
//                             if (value.success != null) {
//                               SharedPreferences pref = await SharedPreferences.getInstance();
//                               log("hell 10001 ${value.success!.rememberToken.toString()}");
//                               String userInfo = jsonEncode({
//                                 "remember_token": value.success!.rememberToken,
//                                 "id": value.success!.id,
//                                 "name": value.success!.name,
//                                 "lname": value.success!.lname,
//                                 "phone": value.success!.phone,
//                                 "email": value.success!.email,
//                                 "userrole": value.success!.userrole,
//                               });
//
//                               await pref.setString("user_info", userInfo);
//                               log("USER CREDENTIAL $userInfo");
//                               Get.offAll(() => const MinimalExample());
//                             } else {
//                               log(value.error.toString());
//                             }
//                           }).catchError((e) {
//                             // Handle unexpected exceptions
//                             setState(() {
//                               isLoading = false; // Stop the loader
//                             });
//                             log('Unexpected Error: $e');
//                           });
//                         }
//                       },
//
//                       style: ElevatedButton.styleFrom(
//                         // minimumSize: 79,
//                         backgroundColor: Colors.white,
//                         // backgroundColor: Colors.red,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50), // <-- Radius
//                         ),
//                       ),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Verify Order",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   color: AppTextColor.primaryColor,
//                                   letterSpacing: .5,
//                                   fontSize: 15)),
//
//                         ],
//                       )),
//                 ),
//                 isLoading == true ?
//                 const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.red,
//                   ),
//                 ):const SizedBox()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
