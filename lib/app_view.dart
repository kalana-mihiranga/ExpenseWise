

import 'package:expense_wise/screens/home/views/AllExpenses.dart';
import 'package:expense_wise/screens/home/views/catogeryscreen.dart';
import 'package:expense_wise/screens/home/views/expenseScreen.dart';
import 'package:expense_wise/screens/home/views/home_screens.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title:"Expense Tracker",
      initialRoute: CategoryScreen.name,
      routes: {
        CategoryScreen.name: (_) => const CategoryScreen(),
        ExpenseScreen.name: (_) => const ExpenseScreen(),
        AllExpenses.name: (_) => const AllExpenses(),


      },

      //home:const HomeScreen(),
      home:const CategoryScreen(),




    );
  }
}
