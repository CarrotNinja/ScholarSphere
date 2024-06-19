import 'package:scholar_sphere/backend/auth.dart';
import 'package:scholar_sphere/pages/home_page.dart';
import 'package:scholar_sphere/pages/register_screen.dart';
import 'package:scholar_sphere/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:scholar_sphere/pages/welcome_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return HomePage();
        }else{
          return const WelcomeScreen();
        }
      }
      );
  }
}