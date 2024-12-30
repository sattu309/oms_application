import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oms_app/resuources/constants.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
import 'package:oms_app/screens/componant_screens/common_button.dart';
import 'package:oms_app/screens/custom_bottom_bar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppTextColor.primaryColor,
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height*.1,),
          Image.asset("assets/images/oms_logo.png",height: height*.3,),
          const Text("OTP Verification",style: TextStyle(fontSize: 19,color: Colors.white),),
          addHeight(5),
          Text("Enter the code sent on this number\n                    7898899787",style: Theme.of(context).textTheme.titleSmall,),
          addHeight(20),
          PinCodeTextField(
            mainAxisAlignment: MainAxisAlignment.center,
            appContext: context,
            textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            controller: otpController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            pastedTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.isEmpty) {
                return "                                  OTP code Required";
              } else if (v.length != 4) {
                return "                         Enter complete OTP code";
              }
              return null;
            },
            length: 4,
            pinTheme: PinTheme(
              fieldOuterPadding:
              const EdgeInsets.symmetric(horizontal: 5),
              borderWidth: 1,
              inactiveBorderWidth: 1,
              activeBorderWidth: 1,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8),
              fieldWidth: 40,
              fieldHeight: 40,
              activeFillColor: Colors.white,
              inactiveColor: Colors.white,
              inactiveFillColor: Colors.black,
              selectedFillColor: Colors.white,
              selectedColor: Colors.white,
              activeColor: Colors.white,
            ),
            cursorColor: Colors.white,
            enablePinAutofill: true,
            keyboardType: TextInputType.number,
            onChanged: (v) {
              setState(() {
              });
            },
          ),
          SizedBox(height: height*.05,),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppTextColor.primaryColor
          ),
          child:
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                  return const CustomBar();
                }));

              },
              style: ElevatedButton.styleFrom(
                // minimumSize: 79,
                backgroundColor: Colors.white,
                // backgroundColor: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // <-- Radius
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Verify",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTextColor.primaryColor,
                          letterSpacing: .5,
                          fontSize: 15)),

                ],
              )),
        ),
        ],
      ),
    ),
    );
  }
}
