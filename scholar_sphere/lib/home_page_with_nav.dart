import 'package:flutter/material.dart';
import 'package:scholar_sphere/pages/chatbot.dart';
import 'package:scholar_sphere/pages/scholarships.dart';
import 'package:scholar_sphere/pages/to_do.dart';
import 'package:scholar_sphere/util/custom_nav_bar.dart';
import 'package:scholar_sphere/pages/home_page.dart';
import 'package:scholar_sphere/pages/social_page.dart';
import 'package:scholar_sphere/pages/settings_page.dart';

class HomePageWithNav extends StatefulWidget {
  @override
  _HomePageWithNavState createState() => _HomePageWithNavState();
}

// HomePageWithNav

class _HomePageWithNavState extends State<HomePageWithNav> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePage(),
    SocialPage(),
    ToDoList1(),
    ScholarshipFinder(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
