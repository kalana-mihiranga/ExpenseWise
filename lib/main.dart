import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'databasehelper/Databasehelper.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseProvider()), // Wrap the provider
      ],
      child: const MyApp(),
    ),
  );
}
