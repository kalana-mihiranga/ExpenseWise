import 'package:expense_wise/screens/home/views/splash.dart';
import 'package:flutter/material.dart';
import 'screens/home/views/catogeryscreen.dart';
import 'screens/home/views/AllExpenses.dart';
import 'screens/home/views/expenseScreen.dart';


class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.name, // Set the initial route to SplashScreen
      routes: {
        SplashScreen.name: (_) => const SplashScreen(), // Add the splash screen route
        CategoryScreen.name: (_) => const CategoryScreen(),
        ExpenseScreen.name: (_) => const ExpenseScreen(),
        AllExpenses.name: (_) => const AllExpenses(),
      },
      home: const SplashScreen(), // Set the home to SplashScreen
    );
  }
}
