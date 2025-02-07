import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../common_repo/common_api_repo.dart';
import '../../models/customer_list_model.dart';
import '../../repository/add_customer_repo.dart';
import '../../resuources/api_urls.dart';
import '../../resuources/app_colors.dart';
import '../../resuources/custom_loader.dart';
import '../../resuources/custom_snackbar.dart';
import '../componant_screens/add_height_widtth.dart';
import '../componant_screens/common_button.dart';
import '../componant_screens/common_textfields.dart';

class EditCustomerDetails extends StatefulWidget {
final String customerId;
final Function() update;
  const EditCustomerDetails({super.key, required this.customerId, required this.update,});

  @override
  State<EditCustomerDetails> createState() => _EditCustomerDetailsState();
}

class _EditCustomerDetailsState extends State<EditCustomerDetails> {

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
  CustomerListModel? customerListModel;
  Repositories repositories = Repositories();
 Future<void> getCustomerList() async {
    repositories.getApi(url: "${ApiUrls.customerDetails}/${widget.customerId}")
        .then((value) {
      customerListModel = CustomerListModel.fromJson(jsonDecode(value));
      fNameController.text = customerListModel!.success!.first.name.toString();
      address1Controller.text = customerListModel!.success!.first.address.toString();
      address2Controller.text = customerListModel!.success!.first.address2.toString();
      cityController.text = customerListModel!.success!.first.city.toString();
      pinCodeController.text = customerListModel!.success!.first.pincode.toString();
      stateController.text = customerListModel!.success!.first.state.toString();
      phone1Controller.text = customerListModel!.success!.first.phone.toString();
      phone2Controller.text = customerListModel!.success!.first.phone2.toString();
      email1Controller.text = customerListModel!.success!.first.email.toString();
      email2Controller.text = customerListModel!.success!.first.email2.toString();
      panNumberController.text = customerListModel!.success!.first.panno.toString();
      gstNumberController.text = customerListModel!.success!.first.gstno.toString();
      cPersonNameController.text = customerListModel!.success!.first.cpName.toString();
      cPersonPhoneController.text = customerListModel!.success!.first.cpPhone.toString();
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getCustomerList();

  }
  @override
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
              Text("EDIT CUSTOMER",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),
            ],
          ),
        ),

      ),
      body:
      customerListModel != null ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        child: SingleChildScrollView(
          child:
          Stack(
            children: [
              Column(
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
                                  child:
                                  CommonTextFieldWidget1(
                                    label: Text("State"),
                                    controller: stateController,
                                  ),

                                ),
                              ],
                            ),
                            addHeight(2),
                            CommonTextFieldWidget1(
                              length: 6,
                              label: Text("Pincode"),
                              controller: pinCodeController,
                              keyboardType: TextInputType.number,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Pincode is Required'),
                              ]),
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
                            CommonButtonBlue(title: "UPDATE",onPressed: ()async{
                              if(formKey.currentState!.validate()){
                                setState(() {
                                  isLoading = true;
                                });
                               await editCustomerRepo(
                                  customerId: widget.customerId.toString(),
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

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: height*.4,
                left: 0,
                right: 0,
                child:
                isLoading ? threeArchedCircle(color: AppTextColor.themeColor, size: 30): SizedBox(),

              )
            ],
          ),
        ),
      ):Center(child: CircularProgressIndicator(color: AppTextColor.themeColor,)),
    );
  }
}
