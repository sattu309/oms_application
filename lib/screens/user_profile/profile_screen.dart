import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oms_app/screens/componant_screens/common_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_repo/common_api_repo.dart';
import '../../controllers/user_details_controller.dart';
import '../../models/customer_list_model.dart';
import '../../repository/add_customer_repo.dart';
import '../../resuources/app_colors.dart';
import '../../resuources/custom_loader.dart';
import '../../resuources/custom_snackbar.dart';
import '../../resuources/helper.dart';
import '../componant_screens/add_height_widtth.dart';
import '../componant_screens/common_textfields.dart';

class ProfileScreen extends StatefulWidget {
  final bool showAppBar;
  const ProfileScreen({super.key, required this.showAppBar});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  final userDetailsController = Get.put(UserDetailsController());
  bool isLoading = false;
  CustomerListModel? customerListModel;
  Repositories repositories = Repositories();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTextColor.themeColor,
        automaticallyImplyLeading: false,
        title:
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Row(
            children: [
              widget.showAppBar == false ? SizedBox() :
              const Icon(Icons.arrow_back,color: Colors.white,),
              addWidth(7),
              Text("PROFILE",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),
            ],
          ),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*.04,),
                  Stack(
                    children: [
                      Obx((){
                        return  Center(
                          child: CircleAvatar(
                            radius: 50, // Customize the size if needed
                            backgroundImage: userDetailsController.image.value != null
                                ? FileImage(userDetailsController.image.value!)
                                : AssetImage("assets/images/pic.png") as ImageProvider,
                            backgroundColor: Colors.transparent, // Optional, for styling
                          ),
                        );
                      }),

                       Positioned(
                          right: 110,
                          top: 25,
                          child: IconButton(
                              onPressed: () {
                                showUploadWindow(context);
                              },
                           icon: Icon(Icons.camera_alt_rounded,color: AppTextColor.themeColor,),))
                    ],
                  ),
                  SizedBox(height: height*.06,),
                  Text("User Name",style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500,fontSize: 14),),
                  addHeight(5),
                  CommonTextFieldWidget1(
                    controller: userDetailsController.userNameController,
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Email is Required'),
                    ]).call,
                  ),
                  addHeight(5),
                  Text("User Email",style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500,fontSize: 14),),
                  addHeight(5),
                  CommonTextFieldWidget1(
                    controller: userDetailsController.userEmailController,
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Email is Required'),
                    ]).call,
                  ),
                  addHeight(5),
                  Text("User Phone",style: TextStyle(fontSize: 14,color: Colors.grey.shade600, fontWeight: FontWeight.w500),),
                  addHeight(5),
                  CommonTextFieldWidget1(
                    readOnly: true,
                    controller: userDetailsController.userPhoneController,
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Email is Required'),
                    ]).call,
                  ),
                  addHeight(30),
                  CommonButtonBlue(title: "UPDATE",
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        final value = await updateProfileRepo(
                          name: userDetailsController.userNameController.text,
                          lName: '',
                          email: userDetailsController.userEmailController.text,
                          mobileNumber: userDetailsController.userPhoneController.text,
                          context: context,
                        );

                        setState(() {
                          isLoading = false;
                        });

                        if (value.message == "Profile updated successfully") {
                          showSnackBarView(
                            context: context,
                            message: value.message.toString(),
                            backGroundColor: Colors.black,
                          );
                        }
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        showSnackBarView(
                          context: context,
                          message: "Error updating profile",
                          backGroundColor: Colors.red,
                        );
                      }
                    }
                    ,),

                ],
              ),
              Positioned(
                top: height*.3,
                  left: 0,
                  right: 0,
                  child:
                isLoading ? threeArchedCircle(color: AppTextColor.themeColor, size: 30): SizedBox(),
              // isLoading == true ?
              // Center(child: CircularProgressIndicator(color: AppTextColor.themeColor,)):SizedBox())

              ) ],
          ),
        ),
      ),

    );
  }
  showUploadWindow(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Text("Choose From Which",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppTextColor.titleColor
                        )),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: Text("Gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTextColor.themeColor,
                                  fontSize: 13)),
                          onPressed: () {
                            NewHelper().addFilePicker().then((value) async {
                              if (value != null) {
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString("save_img", value.path );
                                log("SAVE IMAGE PATH ${pref.getString("save_img")!}");
                                userDetailsController.image.value = value;  // No need for force unwrapping (!)
                                print("This is from camera: ${userDetailsController.image.value!.path}");  // Use null check (!)
                              } else {
                                print("No image selected");
                              }
                            });
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: Text("Camera",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTextColor.themeColor,
                                  fontSize: 13)),
                          onPressed: () {
                            NewHelper()
                                .addImagePicker(imageSource: ImageSource.camera)
                                .then((value) async {
                              if (value != null) {
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString("save_img", value.path );
                                log("SAVE IMAGE PATH ${pref.getString("save_img")!}");
                                userDetailsController.image.value = value;  // No need for force unwrapping (!)
                                print("This is from camera: ${userDetailsController.image.value!.path}");  // Use null check (!)
                              } else {
                                print("No image selected");
                              }
                            });
                            Get.back();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
