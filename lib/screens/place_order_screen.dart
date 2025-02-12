import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oms_app/resuources/custom_snackbar.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
import 'package:oms_app/screens/thank_you_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_repo/common_api_repo.dart';
import '../controllers/cart_local_data_controller.dart';
import '../controllers/localtion_controller.dart';
import '../controllers/user_details_controller.dart';
import '../models/customer_list_model.dart';
import '../repository/order_verify_otp_repo.dart';
import '../repository/place_order_repo.dart';
import '../resuources/api_urls.dart';
import '../resuources/app_colors.dart';
import '../resuources/common_style_Text.dart';
import 'componant_screens/common_button.dart';

class PlaceOrderScreen extends StatefulWidget {
  final String customerId;
  final List<dynamic> cartList;
  const PlaceOrderScreen({super.key, required this.customerId, required this.cartList});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  CustomerListModel? customerListModel;
  final cartController = Get.put(CartLocallyData());
  final locationController = Get.put(LocationController());
  final userController = Get.put(UserDetailsController());
  Repositories repositories = Repositories();
  final discountController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  late Timer timer;
  RxInt timerSeconds = 10.obs;
  RxBool showTimer = false.obs;
  bool isLoading = false;
  setTimer() {
    if (showTimer.value == false) {
      showTimer.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (value) {
        if (timerSeconds.value > 1) {
          timerSeconds.value--;
        } else {
          showTimer.value = false;
          timer.cancel();
          timerSeconds.value = 10;
        }
      });
    }
  }
  getCustomerList() async {
    repositories.getApi(url: ApiUrls.customerList)
        .then((value) {
      customerListModel = CustomerListModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  Widget cartDetails({required String title,required int amt}){
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: Theme.of(context).textTheme.titleMedium,),
          Text(currencySymbol+cartController.numberFormatData(amt: amt),style: TextStyle(fontSize: 14,color: Colors.black54),)
        ],
      ),
    );
  }
  calDiscount({required double subtotal, required double discountPercentage}){
    double discountAmount = subtotal * discountPercentage / 100;
    double totalAmount = subtotal - discountAmount;
    cartController.discountAmt.value = discountAmount;
    cartController.calculateTotal.value = totalAmount;
    // cartController.cartTotal.value = totalAmount;
    log(totalAmount.toString());
    return totalAmount;
  }

  @override
  void initState() {
    super.initState();
    print(widget.customerId);
    print(widget.cartList.length);
    getCustomerList();
    setTimer();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    List<Success>? filterdata = customerListModel?.success
        ?.where((item) => item.id.toString() == widget.customerId)
        .toList();

    return
      Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: AppTextColor.themeColor,
            automaticallyImplyLeading: false,
            leadingWidth: 0,
            elevation: 0,
            title:   Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                    cartController.calculateTotal = 0.0.obs;
                    cartController.discountAmt = 0.0.obs;
                  },
                  child: Icon(Icons.arrow_back,color: Colors.white,size: 18,),
                ),
                addWidth(7),
                Text("ORDER SUMMARY",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),

              ],
            ),
          ),
          body:
          customerListModel != null ?
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 3),
                  Text(
                    "Order To".toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:AppTextColor.titleColor,fontWeight: FontWeight.bold,fontSize: 14),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    height: height * .16,
                    child: ListView.builder(
                      itemCount: filterdata!.length,
                      itemBuilder: (BuildContext context, index) {
                        final data = filterdata[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.name.toString() } ${ data.lname.toString()}",
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold,color: AppTextColor.titleColor,fontSize: 14),
                              ),
                              addHeight(2),
                              Text(
                                "${data.address.toString() }",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 12),
                              ),
                              addHeight(2),
                              Text(
                                "${ data.address2.toString() } ",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 12),
                              ),
                              addHeight(2),
                              Text("${ data.city.toString()} ${ data.state.toString()}, ${ data.pincode.toString()}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey,fontSize: 12),
                              ),
                              addHeight(2),
                              Text(
                               "${data.phone.toString()}/ ${data.phone2.toString()}",
                               style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey,fontSize: 12),
                                                              ),
                              addHeight(2),
                              Text(
                                "${data.email.toString()}/ ${data.email2.toString()}",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey,fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    "Cart Items",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:AppTextColor.titleColor,fontWeight: FontWeight.bold),
                  ),
                  addHeight(6),
                  ...List.generate(widget.cartList.length, (index){
                    final data = widget.cartList[index];
                    var productUrl =
                        "https://oms.siddharthinfosys.com/public/products/";

                    return
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                        decoration: const BoxDecoration(
                          color: Colors.white
                        ),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: productUrl +
                                  data['product_img'].toString(),
                              fit: BoxFit.contain,
                              height: height * .04,
                              width: 55,
                              alignment: Alignment.topLeft,
                              errorWidget: (_, __, ___) =>
                                  Image.asset(
                                    "assets/images/dmeo.png",
                                    width: 55,
                                    fit: BoxFit.fitHeight,
                                    alignment: Alignment.topLeft,
                                  ),
                              placeholder: (_, __) => Image.asset(
                                "assets/images/dmeo.png",
                                width: 55,
                                fit: BoxFit.fitHeight,

                              ),
                            ),
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['qty'].toString()} * ${data['productname'].toString()}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              addHeight(3),
                              Row(
                                children: [
                                  Text(
                                    "${currencySymbol+cartController.numberFormatData(amt: int.parse(data['price'].toString()))} / " ,
                                    style: TextStyle(fontSize: 13,color: AppTextColor.greyColor,),
                                  ),
                                  Text( data['unit_id'] == "1" ? "KG" : data['unit_id'] == "2" ? "Litter" : data['unit_id'] == "3" ? "Gram" :
                                  data['unit_id'] == "4" ? "inches" : data['unit_id'] == "5" ? "centimeters": data['unit_id'] == "6" ? "meter":"",
                                    style: Theme.of(context).textTheme.bodySmall,),
                                ],
                              )
                            ],
                                              ),
                          ],
                        ),
                      );
                  }),
                  const SizedBox(height: 20),
                  cartDetails(title: 'Order Subtotal', amt: cartController.cartTotal.toInt()),
                  const SizedBox(height: 3),
                  Divider(thickness: 1, color: Colors.grey.shade300),
                  const SizedBox(height: 7),
                  Text(
                    "Discount Percentage",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 7),
                  cartController.discountAmt.value > 0
                      ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ImageIcon(AssetImage("assets/images/discount.png"), color: Colors.green),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Discount ${discountController.text} % applied",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.green),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              cartController.calculateTotal = 0.0.obs;
                              cartController.discountAmt = 0.0.obs;
                            });
                          },
                          child: const Text("Remove", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ) : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              controller: discountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter Discount Code...",
                                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              calDiscount(
                                subtotal: double.parse(cartController.cartTotal.toString()),
                                discountPercentage: double.parse(discountController.text),
                              );
                            });
                          },
                          child: Text(
                            "APPLY",
                            style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 1, color: Colors.grey.shade300),
                  const SizedBox(height: 10),
                  if (cartController.discountAmt > 0)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount Savings',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "-$currencySymbol${cartController.discountAmt.toInt()}.00",
                            style: const TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  cartDetails(
                    title: 'Order Total',
                    amt: cartController.calculateTotal.value.toInt() == 0.0
                        ? cartController.cartTotal.toInt()
                        : cartController.calculateTotal.value.toInt(),
                  ),
                  isLoading == true ?
                      const Center(child: CircularProgressIndicator(color: AppTextColor.themeColor,),):SizedBox()
                ],
              ),
            ),
          )

              :const Center(child: CircularProgressIndicator(color: Colors.black87,)),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [


                  CommonButtonBlue(title: "Place Order",
                    onPressed: () async {
                    final totalData =  cartController.calculateTotal.value.toInt() == 0.0
                        ? cartController.cartTotal.toInt()
                        : cartController.calculateTotal.value.toInt();
                      setState(() {
                        isLoading = true;
                      });
                      if(locationController.lat.value != "" && locationController.long.value != "" ) {
                        try {
                        final value = await placeOrderRepo(
                          customerId: widget.customerId,
                          totalAmount: totalData.toString(),
                          subtotal: cartController.cartTotal.value.toString(),
                          discount: cartController.discountAmt.value.toString(),
                          status: '0',
                          lat: locationController.lat.value,
                          long: locationController.long.value,
                          cartData: widget.cartList,
                          context: context,
                        );
                        if (value.orderId != null) {
                          isLoading = false;
                          buildShowDialog(context, oId: value.orderId.toString());
                        }
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        log('Unexpected Error: $e');
                      }
                      }
                        else{
                          showLocationDialog(context);
                          setState(() {
                            isLoading = false;
                          });
                      }
                    },
                  )
                ],
              ),
            ),
          )
      );

  }
  void showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
        title: Text("Location Required",style: Theme.of(context).textTheme.titleMedium,),
        content: Text(
          "To place your order, we need access to your location to ensure accurate delivery. "
              "Please enable location services in your device settings.",style: Theme.of(context).textTheme.bodySmall,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
              if (locationController.servicestatus.value) {
                locationController.permission = await Geolocator.checkPermission();
                if (locationController.permission == LocationPermission.denied) {
                  locationController.permission = await Geolocator.requestPermission();
                  if (locationController.permission == LocationPermission.deniedForever) {
                    log("Location permission denied forever. Opening app settings...");
                    await Geolocator.openAppSettings();
                    locationController.getLocation();
                  } else if (locationController.permission == LocationPermission.denied) {
                    log("Location permission denied");
                  } else {
                    locationController.haspermission.value = true;
                  }
                } else if (locationController.permission == LocationPermission.deniedForever) {
                  log("Location permission denied forever. Opening app settings...");
                  await Geolocator.openAppSettings();
                  locationController.getLocation();
                } else {
                  locationController.haspermission.value = true;
                }
                if (locationController.haspermission.value) {
                  locationController.getLocation();
                }
              }
            },
            child: Text("Enable Location"),
          ),
        ],
      ),
    );
  }
  Future<dynamic> buildShowDialog(BuildContext context,{required String oId}) {
    var height = MediaQuery.of(context).size.height;
    bool isLoading1 = false;
    final otpController = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13,),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30,right: 30,top: 30,bottom: 20),
                          child: Image.asset("assets/images/oms_new_logo.png",width: 140,color:AppTextColor.themeColor,),
                        ),
                        const Text("OTP Verification For Order",style: TextStyle(fontSize: 19,color: AppTextColor.titleColor),),
                        addHeight(10),
                        PinCodeTextField(
                          mainAxisAlignment: MainAxisAlignment.center,
                          appContext: context,
                          textStyle: const TextStyle(color: AppTextColor.titleColor, fontWeight: FontWeight.w400),
                          controller: otpController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          pastedTextStyle: TextStyle(
                            color: AppTextColor.titleColor,
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
                            fieldWidth: 30,
                            fieldHeight: 30,
                            activeFillColor: AppTextColor.titleColor,
                            inactiveColor: AppTextColor.titleColor,
                            inactiveFillColor: Colors.black,
                            selectedFillColor: AppTextColor.titleColor,
                            selectedColor: AppTextColor.titleColor,
                            activeColor: AppTextColor.titleColor,
                          ),
                          cursorColor: AppTextColor.titleColor,
                          enablePinAutofill: true,
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            setState(() {
                            });
                          },
                        ),

                        GestureDetector(
                            onTap: () {

                              if (showTimer.value == false) {
                                resendOtpVerifyForOrderConfirmationRepo(
                                  orderId: oId,
                                    context: context, )
                                    .then((value) {
                                  if (value.message != null) {
                                    showSnackBarView(context: context, message: value.message.toString(), backGroundColor: Colors.red);
                                    setTimer();
                                  } else {
                                    showSnackBarView(context: context, message: value.message.toString(), backGroundColor: Colors.red);
                                  }
                                  return;
                                });
                              }

                            },
                            child:
                            Obx((){
                              return  Text(
                                  !showTimer.value
                                      ? "Resend OTP"
                                      : "Resend OTP in 00:${timerSeconds.value > 9 ?
                                  timerSeconds.value : "0${timerSeconds.value}"}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400));
                            })

                        ),
                        SizedBox(height: height*.04,),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppTextColor.primaryColor
                          ),
                          child:
                          ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading1 = true;  // Show loader
                                  });

                                  try {
                                    final value = await otpVerifyForOrderConfirmationRepo(
                                      orderId: oId,
                                      otp: otpController.text,
                                      context: context,
                                    );

                                    if (value.order != null) {
                                      setState(() {
                                        isLoading1 = false;  // Hide loader
                                      });

                                      String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(
                                        DateTime.parse(value.order!.createdAt.toString()),
                                      );

                                      SharedPreferences pref = await SharedPreferences.getInstance();
                                      pref.remove("cartData");

                                      FocusScope.of(context).unfocus();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ThankyouScreen(
                                            orderId: value.order!.orderno.toString(),
                                            orderDate: formattedDate,
                                            orderTotal: value.order!.totalamount.toString(),
                                          ),
                                        ),
                                            (route) => false,
                                      );
                                    } else {
                                      setState(() {
                                        isLoading1 = false;
                                      });
                                      showSnackBarView(
                                        context: context,
                                        message: value.message.toString(),
                                        backGroundColor: Colors.red,
                                      );
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isLoading1 = false;
                                    });
                                    print(e);
                                  }
                                }
                              },

                              style: ElevatedButton.styleFrom(

                                // minimumSize: 79,
                                backgroundColor: AppTextColor.themeColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50), // <-- Radius
                                ),
                              ),
                              child:
                              isLoading1  ? const CircularProgressIndicator(color: Colors.white,):
                              Text("Verify Order",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      letterSpacing: .5,
                                      fontSize: 15)),
                        ),
                        ),
                        SizedBox(height: height*.05,),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
