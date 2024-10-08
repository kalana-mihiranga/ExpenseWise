import 'package:expense_wise/process/addTransaction.dart';
import 'package:expense_wise/screens/home/views/home_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Expense Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade100,
          onBackground:Colors.black,
          primary:Color(0xFF00B2E7) ,
          secondary:Color(0XFFE064F7),
          tertiary: Color(0XFFFF8D6C)

        )
      ),

      home:HomeScreen(),



    );
  }
}
