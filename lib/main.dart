import 'package:flutter/material.dart';
import 'package:urban_culture/screens/dashboard.dart';
import 'package:urban_culture/utils/urban_culture_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Culture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: UrbanCultureColors.primaryColor),
          useMaterial3: true,
          scaffoldBackgroundColor: UrbanCultureColors.scaffoldColor),
      home: const MyHomePage(title: 'Home'),
    );
  }
}
