import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oms_app/screens/componant_screens/add_height_widtth.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addHeight(5),

             GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 120,
                ),
              shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext ,index){
              return buildContainer(context);
            }, ),



          ],
        ),
      ),
    );
  }

  GestureDetector buildContainer(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context){
        //   return IssuedStockDetails();
        // }));
      },
      child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(.1, .1)
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Prodcuts",style: Theme.of(context).textTheme.titleMedium,),
                        ImageIcon(AssetImage("assets/images/order.png"),color: Colors.green,)
                         ],
                    ),
                    addHeight(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("6,677",style: Theme.of(context).textTheme.titleMedium,),
                        // Text("+15.45%",style: TextStyle(fontSize: 10,color: Colors.green),),
                         ],
                    ),
                  ],
                ),
              ),
    );
  }

}
