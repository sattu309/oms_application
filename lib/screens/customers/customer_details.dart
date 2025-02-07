import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../common_repo/common_api_repo.dart';
import '../../models/customer_list_model.dart';
import '../../resuources/api_urls.dart';
import '../../resuources/app_colors.dart';
import '../../resuources/custom_loader.dart';
import '../componant_screens/add_height_widtth.dart';
import 'edit_customer_details.dart';

class CustomerDetails extends StatefulWidget {
  final String customerId;
  const CustomerDetails({super.key, required this.customerId});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {

  CustomerListModel? customerListModel;
  Repositories repositories = Repositories();
  Future<void> getCustomerList() async {
    repositories.getApi(url: "${ApiUrls.customerDetails}/${widget.customerId}")
        .then((value) {
      customerListModel = CustomerListModel.fromJson(jsonDecode(value));
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
    return Scaffold(
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
              Text("CUSTOMERS DETAILS",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),

            ],
          ),
        ),

      ),
      body:
          customerListModel != null ?
      Column(
        children: [
          ListView.builder(
              itemCount: customerListModel!.success!.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 80),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final customerData = customerListModel!.success![index];
                return
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        },
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(left: 20,top: 6,bottom: 6),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align the whole column to the start
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                                crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "COMPANY NAME".toUpperCase(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(height: 3), // Space between label and value
                                        Text(
                                          '${customerData.name.toString().capitalizeFirst}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: GestureDetector(
                                        onTap: (){
                                          Get.to(()=>EditCustomerDetails(customerId: customerData.id.toString(), update: () { getCustomerList(); },));
                                        },
                                        child: Icon(Icons.edit,size: 20,color: AppTextColor.themeColor,)),
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                                crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ADDRESS".toUpperCase(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(height: 3), // Space between label and value
                                        Text(
                                          '${customerData.address.toString()}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                                crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ADDRESS 2".toUpperCase(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(height: 3), // Space between label and value
                                        Text(
                                          '${customerData.address2.toString()}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                                crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "PHONE".toUpperCase(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(height: 3), // Space between label and value
                                        Text(
                                          '${customerData.phone.toString()} / ${customerData.phone2.toString()}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                                crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "EMAIL".toUpperCase(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(height: 3), // Space between label and value
                                        Text(
                                          '${customerData.email.toString()} / ${customerData.email2.toString()}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                                crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "GST NUMBER".toUpperCase(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(height: 3), // Space between label and value
                                        Text(
                                          '${customerData.gstno.toString()}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "PAN NUMBER".toUpperCase(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(height: 3), // Space between label and value
                                        Text(
                                          '${customerData.panno.toString()}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                                crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "CONTACT PERSON".toUpperCase(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(height: 3), // Space between label and value
                                        Text(
                                          '${customerData.cpName.toString()}}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                                crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "CONTACT PERSON PHONE".toUpperCase(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(height: 3), // Space between label and value
                                        Text(
                                          '${customerData.cpPhone.toString()}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),



                            ],
                          ),

                        ),
                      ),
                    ),
                  );
              })
        ],
      ):Center(child: threeArchedCircle(color: AppTextColor.themeColor, size: 30)),
    );
  }
}
