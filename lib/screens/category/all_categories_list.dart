import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oms_app/common_repo/common_api_repo.dart';
import 'package:oms_app/resuources/api_urls.dart';
import 'package:oms_app/screens/category/sub_%20category_list.dart';
import '../../models/allcategory_model.dart';
import '../../resuources/app_colors.dart';
import '../../resuources/custom_loader.dart';
import '../../resuources/navigate_with_bottombar.dart';
import '../componant_screens/add_height_widtth.dart';
import 'category_product.dart';
import 'component/plus_minus_component.dart';

class AllCategoriesList extends StatefulWidget {
  const AllCategoriesList({super.key});

  @override
  State<AllCategoriesList> createState() => _AllCategoriesListState();
}

class _AllCategoriesListState extends State<AllCategoriesList> {
bool addButtonCliked = false;
var catImgUrl = "https://oms.siddharthinfosys.com/public/categories/";


  int counter = 1;
  increaseCounter() {
    counter++;
    setState(() {});
  }

  decreaseCounter() {
    if (counter > 1) {
      counter--;
    }else{
      addButtonCliked = false;
    }
    setState(() {});
  }

  Repositories repositories = Repositories();
    AllCategoryModel? allCategoryModel;
  
  getALlCatList() async{
    repositories.getApi(url: ApiUrls.allCategoryList).then((value){
        allCategoryModel = AllCategoryModel.fromJson(jsonDecode(value));
        setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getALlCatList();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: backAppBar1("Categories", context),
      body:
          allCategoryModel != null  ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  mainAxisExtent: 115,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final cateListData = allCategoryModel!.categories![index];
                    return GestureDetector(
                      onTap: () {
                        log("CATEGORY ID: ${cateListData.id.toString()}");
                        if(allCategoryModel!.products == null || allCategoryModel!.products!.isEmpty){
                          pushScreen(context, screen: SubCategoriesList(categoryId: cateListData.id.toString(), categoryName: cateListData.category.toString(),),withNavBar: true);

                          // Get.to(()=>SubCategoriesList(categoryId: cateListData.id.toString(), categoryName: cateListData.category.toString(),));
                        }else{
                          Get.to(()=>CategoryProducts(categoryId: cateListData.id.toString(), categoryName: cateListData.category.toString(),));

                        }
                      },
                      child: Container(
                        // margin: EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade100,
                        ),
                        child: Center(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              addHeight(10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                CachedNetworkImage(
                                  imageUrl: catImgUrl +
                                      cateListData.mobileimage.toString(),
                                  fit: BoxFit.contain,
                                  // height: height*.47,
                                  height: 80,
                                  width: 80,
                                  errorWidget: (_, __, ___) =>const SizedBox(),

                                  placeholder: (_, __) =>  Center(
                                      child: CircularProgressIndicator(color: Colors.black,)),
                                ),
                                // Image.asset("assets/images/demo.png", height: 80),
                              ),
                              addHeight(3),
                               Text(
                                 cateListData.category.toString(),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: allCategoryModel!.categories!.length,
                ),
              ),
            ),

          ],
        ),
      ):Center(child: threeArchedCircle(color: AppTextColor.themeColor, size: 30))
    );
  }
}
