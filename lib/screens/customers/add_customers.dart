import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/resuources/custom_snackbar.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
import 'package:oms_app/screens/componant_screens/common_button.dart';
import 'package:oms_app/screens/componant_screens/common_textfields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/add_customer_repo.dart';

class AddCustomer extends StatefulWidget {
  final Function() update;
  const AddCustomer({super.key, required this.update});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
 final formKey = GlobalKey<FormState>();
 final fNameController = TextEditingController();
 final lNameController = TextEditingController();
 final email1Controller = TextEditingController();
 final email2Controller = TextEditingController();
 final phone1Controller = TextEditingController();
 final phone2Controller = TextEditingController();
 final address1Controller = TextEditingController();
 final address2Controller = TextEditingController();
 final cityController = TextEditingController();
 final pinCodeController = TextEditingController();
 final stateController = TextEditingController();
 final cPersonNameController = TextEditingController();
 final cPersonPhoneController = TextEditingController();
 final panNumberController = TextEditingController();
 final gstNumberController = TextEditingController();

 bool isLoading = false;
  String? dropdownValue;
  List<String> productList = [
    'Test1',
    'Test2',
    'Test3',
    'Test4'
  ];
  @override
  void initState() {
    super.initState();

  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTextColor.themeColor,
        automaticallyImplyLeading: false,
        title:GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back,color: Colors.white,),
              addWidth(7),
              Text("ADD CUSTOMER DETAILS",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),
            ],
          ),
        ),
      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height*.01,),
              Card(
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*.02,),
                        CommonTextFieldWidget1(
                          label: Text("Company Name"),
                          // hint: "Company Name",
                          controller: fNameController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Name is Required'),
                          ]).call,
                        ),

                        addHeight(2),
                        CommonTextFieldWidget1(
                          label: Text("Address1"),
                          controller: address1Controller,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Address is Required'),
                          ]).call,
                        ),
                        addHeight(2),
                        CommonTextFieldWidget1(
                          label: Text("Address2"),
                          controller: address2Controller,
                        ),
                        addHeight(2),
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextFieldWidget1(
                                label: Text("City"),
                                controller: cityController,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'City is Required'),
                                ]),
                              ),
                            ),
                            addWidth(5),
                            Expanded(
                              child: CommonTextFieldWidget1(
                                length: 6,
                                label: Text("Pincode"),
                                controller: pinCodeController,
                                keyboardType: TextInputType.number,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Pincode is Required'),
                                ]),
                              ),
                            ),
                          ],
                        ),
                        addHeight(2),
                        CommonTextFieldWidget1(
                          label: Text("State"),
                          controller: stateController,
                        ),
                        addHeight(2),
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextFieldWidget1(
                                length: 10,
                                keyboardType: TextInputType.number,
                                label: Text("Phone1"),
                                controller: phone1Controller,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Phone is Required'),
                                ]).call,
                              ),
                            ),
                            addWidth(5),
                            Expanded(
                              child: CommonTextFieldWidget1(
                                length: 10,
                                keyboardType: TextInputType.number,
                                label: Text("Phone2"),
                                controller: phone2Controller,

                              ),
                            ),
                          ],
                        ),
                        addHeight(2),
                        CommonTextFieldWidget1(
                          label: Text("Email"),
                          controller: email1Controller,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Email is Required'),
                          ]).call,
                        ),
                        addHeight(2),
                        CommonTextFieldWidget1(
                          label: Text("Email2"),
                          controller: email2Controller,
                        ),
                        addHeight(2),
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextFieldWidget1(
                                label: Text("PAN"),
                                controller: panNumberController,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Pan is Required'),
                                ]),
                              ),
                            ),
                            addWidth(5),
                            Expanded(
                              child: CommonTextFieldWidget1(
                                length: 6,
                                label: Text("GST"),
                                controller: gstNumberController,
                                keyboardType: TextInputType.number,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'GST is Required'),
                                ]),
                              ),
                            ),
                          ],
                        ),
                        addHeight(2),
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextFieldWidget1(
                                label: Text("Contact Person"),
                                controller: cPersonNameController,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Name is Required'),
                                ]),
                              ),
                            ),
                            addWidth(5),
                            Expanded(
                              child: CommonTextFieldWidget1(
                                length: 10,
                                label: Text("Person Phone"),
                                controller: cPersonPhoneController,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Phone is Required'),
                                ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height*.03,),
                        CommonButtonBlue(title: "ADD",onPressed: (){
                          if(formKey.currentState!.validate()){
                            setState(() {
                              isLoading = true;
                            });
                            addCustomerRepo(
                                name: fNameController.text,
                                lName: lNameController.text,
                                email: email1Controller.text,
                                mobileNumber: phone1Controller.text,
                                address1: address1Controller.text,
                                email2: email1Controller.text,
                              mobileNumber2: phone1Controller.text,
                              address2: address2Controller.text,
                              contactPersonName: cPersonNameController.text,
                              contactPersonPhone: cPersonPhoneController.text,
                              state: stateController.text,
                              city: cityController.text,
                              pincode: pinCodeController.text,
                              gstNumber: gstNumberController.text,
                              panNumber: panNumberController.text,
                              context: context, ).then((value) async {
                                  if(value.success != null){
                                   showSnackBarView(context: context, message: value.success.toString(), backGroundColor: Colors.green);
                                   widget.update();
                                   Get.back();
                                  }
                            }).catchError((e) {

                              setState(() {
                                isLoading = false; // Stop the loader
                              });
                              log('Unexpected Error: $e');
                            });
                          }
                        },),
                        SizedBox(height: height*.06,),
                        isLoading == true ?
                        const Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ):const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
