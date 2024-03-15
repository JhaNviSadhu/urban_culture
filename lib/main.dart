import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:urban_culture/screens/dashboard.dart';
import 'package:urban_culture/utils/urban_culture_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInAnonymously();
  var user = await FirebaseAuth.instance.currentUser;
  var uid = user?.uid;
  await FirebaseFirestore.instance.collection('user').doc(user?.uid).set({});
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
