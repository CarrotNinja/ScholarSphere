import 'package:flutter/material.dart';
import 'package:scholar_sphere/pages/home_page.dart';
import 'package:scholar_sphere/pages/settings_page.dart';
import 'package:scholar_sphere/pages/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    );
  }
}