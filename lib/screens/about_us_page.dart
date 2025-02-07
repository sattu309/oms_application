import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import '../common_repo/common_api_repo.dart';
import '../models/about_us_model.dart';
import '../resuources/api_urls.dart';
import '../resuources/app_colors.dart';
import 'componant_screens/add_height_widtth.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  Repositories repositories = Repositories();
  AboutUsModel? aboutUsModel;
  getAboutUsData() async {
    repositories.getApi(url: ApiUrls.aboutUs)
        .then((value) {
      aboutUsModel = AboutUsModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getAboutUsData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
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
              Text("ABOUT US",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),

            ],
          ),
        ),

      ),
      body:
          aboutUsModel != null ?
      SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 6),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset("assets/images/banner.jpg")),
          aboutUsModel?.success != null && aboutUsModel!.success!.isNotEmpty
              ? Html(data: aboutUsModel!.success.toString())
              : Text("No content available.")
            ],
          ),
        ),
      ):Center(child: CircularProgressIndicator(color: AppTextColor.themeColor,),),
    );
  }
}
