import 'package:expense_wise/screens/home/views/AllExpenses.dart';
import 'package:expense_wise/screens/home/views/catogeryscreen.dart';
import 'package:expense_wise/screens/home/views/expenseScreen.dart';

import 'package:flutter/material.dart';
import 'blocks/signUp.dart';
import 'blocks/signin.dart';
import 'screens/home/views/splash.dart';


class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.name, // Set the initial route to SplashScreen
      routes: {
        SplashScreen.name: (_) => const SplashScreen(),
        SignInScreen.name: (_) => const SignInScreen(),
        SignUpScreen.name: (_) => const SignUpScreen(),
        CategoryScreen.name: (_) => const CategoryScreen(),
        ExpenseScreen.name: (_) => const ExpenseScreen(),
        AllExpenses.name: (_) => const AllExpenses(),
      },
    );
  }
}
