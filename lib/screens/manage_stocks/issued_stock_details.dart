import 'package:flutter/material.dart';
import 'package:oms_app/resuources/constants.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';
import 'package:oms_app/screens/componant_screens/common_button.dart';
import 'package:oms_app/screens/componant_screens/common_textfields.dart';

class IssuedStockDetails extends StatefulWidget {
  const IssuedStockDetails({super.key});

  @override
  State<IssuedStockDetails> createState() => _IssuedStockDetailsState();
}

class _IssuedStockDetailsState extends State<IssuedStockDetails> {
 final formKey = GlobalKey<FormState>();
  String? dropdownValue;
  List<String> productList = [
    'Test1',
    'Test2',
    'Test3',
    'Test4'
  ];

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: AppTextColor.primaryColor,
        automaticallyImplyLeading: false,
        title:GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back,color: Colors.white,),
              addWidth(7),
              Text("Issued Stock Details",style: Theme.of(context).textTheme.titleSmall,),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        child: SingleChildScrollView(
          child: Card(
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: height*.01,),
                    // Text("Issued Stock Details",style: Theme.of(context).textTheme.titleMedium,),
                    SizedBox(height: height*.02,),
                    Text("Select Product",style: Theme.of(context).textTheme.bodyMedium,),
                    addHeight(5),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<String>(
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.black,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                        ),
                        value: dropdownValue,
                        hint: const Text(
                          "Select Product",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        isExpanded: true,
                        onChanged: (String? data) {
                          setState(() {
                            dropdownValue = data!;
                          });
                        },
                        items: productList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style:
                                const TextStyle(fontSize: 15, color: Colors.black54)),
                          );
                        }).toList(),
                      ),
                    ),
                    Text("Warehouse",style: Theme.of(context).textTheme.bodyMedium,),
                    addHeight(5),
                    const CommonTextFieldWidget1(),
                    addHeight(10),
                    Text("Quantity sent",style: Theme.of(context).textTheme.bodyMedium,),
                    addHeight(5),
                    const CommonTextFieldWidget1(
                      keyboardType: TextInputType.number,
                    ),
                    addHeight(10),
                    Text("Vehicle Number",style: Theme.of(context).textTheme.bodyMedium,),
                    addHeight(5),
                    const CommonTextFieldWidget1(),
                    addHeight(10),
                    Text("Additional Information",style: Theme.of(context).textTheme.bodyMedium,),
                    addHeight(5),
                    const CommonTextFieldWidget1(
                      minLines: 3,
                      maxLines: null,
                    ),
                    SizedBox(height: height*.03,),
                    CommonButtonBlue(title: "UPDATE STOCK",onPressed: (){
                    },),
                    SizedBox(height: height*.06,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
