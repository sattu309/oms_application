import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oms_app/resuources/app_colors.dart';
import 'package:oms_app/screens/Homepage.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          backgroundColor: AppTextColor.primaryColor,
          title: Text("Help & Support",style: Theme.of(context).textTheme.titleSmall),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0.1, 0.1),
                    color: Colors.white70,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                        decoration: BoxDecoration(
                          color: AppTextColor.themeColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.mail_rounded,color: Colors.white,size: 20,),
                      ),
                      addHeight(5),
                      Text("Email",style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                        decoration: BoxDecoration(
                          color: AppTextColor.themeColor,
                          shape: BoxShape.circle,

                        ),
                        child: Icon(Icons.call,color: Colors.white,size: 20,),
                      ),
                      addHeight(5),
                      Text("Call Us",style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>ChatScreen(receiverEmail: ""));
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),

                          decoration: BoxDecoration(
                            color: AppTextColor.themeColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.chat_bubble,color: Colors.white,size: 20,),
                        ),
                        addHeight(5),
                        Text("Chat",style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            addHeight(10),
            ListView.builder(
              shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, index){
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0.1, 0.1),
                      color: Colors.white,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      decoration: BoxDecoration(
                        color: AppTextColor.themeColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.article,color: Colors.white,size: 20,),
                    ),
                    addWidth(10),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Demo & Sample PDF",style: Theme.of(context).textTheme.titleMedium),
                        addHeight(4),
                        Text("See Sample PDF Work Order",style: Theme.of(context).textTheme.bodySmall),
                      ],
                    )
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
