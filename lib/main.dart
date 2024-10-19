
import 'package:expense_wise/databasehelper/Databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'app_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
