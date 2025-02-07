import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oms_app/common_repo/common_api_repo.dart';
import 'package:oms_app/screens/customers/add_customers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/customer_list_model.dart';
import '../../resuources/api_urls.dart';
import '../../resuources/app_colors.dart';
import '../../resuources/custom_loader.dart';
import '../componant_screens/add_height_widtth.dart';
import 'customer_details.dart';
import 'edit_customer_details.dart';

class AllCustomersList extends StatefulWidget {
  const AllCustomersList({super.key});

  @override
  State<AllCustomersList> createState() => _AllCustomersListState();
}

class _AllCustomersListState extends State<AllCustomersList> {
  CustomerListModel? customerListModel;
  Repositories repositories = Repositories();

  getCustomerList() async {
    repositories.getApi(url: ApiUrls.customerList)
        .then((value) {
      customerListModel = CustomerListModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    getCustomerList();
  }
  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back,color: Colors.white,),
              addWidth(7),
              Expanded(child: Text("CUSTOMERS",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),)),
               GestureDetector(
                 onTap: (){
                   Get.to(()=>AddCustomer(update: () { getCustomerList(); },));
                 },
                 child: Container(
                     decoration: BoxDecoration(
                       color: AppTextColor.themeColor,
                       shape: BoxShape.circle,
                       border: Border.all(color: Colors.white)
                     ),
                     child: Icon(size: 18,Icons.add,color: Colors.white,)),
               ),

            ],
          ),
        ),

      ),
      body:
      customerListModel != null ? customerListModel!.success!.isNotEmpty?
      SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    addHeight(4),
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:customerListModel!.success!.length,
                        itemBuilder: (context, index) {
                          final listData = customerListModel!.success![index];
                          return
                            buildGestureDetector(listData, context);
                        }
                    ),

                  ]
              ),

            ],
          ),
        )
      ):const Center(child: Text("Customer is not Available"),):Center(child: threeArchedCircle(color: AppTextColor.themeColor, size: 30)),
    );
  }

  GestureDetector buildGestureDetector(Success listData, BuildContext context) {
    return GestureDetector(
                            onTap: (){
                              // Get.to(()=>EditCustomerDetails(customerId: listData.id.toString(),));
                              Get.to(()=>CustomerDetails(customerId: listData.id.toString(),));
                            },
                            child:
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: const LinearGradient(
                                  colors: [Colors.white, Colors.white],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child:
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppTextColor.greyColor),
                                      ),
                                      child:Image.asset("assets/images/user.png",height: 25,width: 25,color: AppTextColor.greyColor,) ,
                                    ),
                                    addWidth(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            "${listData.name.toString().capitalizeFirst}",
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontSize: 12,
                                                color: Colors.grey.shade700,fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                        children: [
                                          Expanded(child: Text("${ listData.city.toString().capitalizeFirst} ${ listData.state.toString().capitalizeFirst}, ${ listData.pincode.toString()}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey,fontSize: 11),)),
                                            // GestureDetector(
                                            //     onTap: (){
                                            //       makingPhoneCall("Tel: +91${listData.phone.toString()}");
                                            //     },
                                            //     child: const Icon(Icons.call,color: AppTextColor.themeColor,size: 16,))
                                        ],
                                      ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: (){
                                              makingPhoneCall("Tel: +91${listData.phone.toString()}");
                                            },
                                            child: const Icon(Icons.call,color: AppTextColor.themeColor,size: 16,))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
  }
}
