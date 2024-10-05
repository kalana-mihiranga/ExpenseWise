import 'package:expense_wise/screens/home/stats/chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transaction",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
            ,SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
             child: const Chart(),
             // color:Colors.red,
              //  child:BarChart(
               //   BarChartData(

              //    )
              //  )

            )
          ],
        ),

      ),
    );
  }
}
