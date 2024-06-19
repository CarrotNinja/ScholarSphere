import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_sphere/backend/widget_tree.dart';
import 'package:scholar_sphere/pages/home_page.dart';
import 'package:scholar_sphere/pages/settings_page.dart';
import 'package:scholar_sphere/pages/to_do.dart';
import 'package:scholar_sphere/pages/welcome_screen.dart';
import 'package:scholar_sphere/backend/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: WidgetTree(),
    );
  }
}