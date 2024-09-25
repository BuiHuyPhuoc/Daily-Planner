import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:daily_planner/screens/calendar_screen.dart';
import 'package:daily_planner/screens/setting_screen.dart';
import 'package:daily_planner/screens/to_do_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _pagePosition = 1;
  List<Widget> _navigationItems = [
    Icon(
      Icons.calendar_month,
      size: 30,
      color: Color(0xffE8DFCA),
    ),
    Icon(
      Icons.work,
      size: 30,
      color: Color(0xffE8DFCA),
    ),
    Icon(
      Icons.settings,
      size: 30,
      color: Color(0xffE8DFCA),
    ),
  ];
  List<Widget> _pages = [CalendarScreen(), ToDoScreen(), SettingScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _pages[_pagePosition],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Color(0xff4F6F52),
              index: _pagePosition,
              color: Color(0xff4F6F52),
              animationDuration: Duration(milliseconds: 400),
              items: _navigationItems,
              onTap: (index) {
                setState(() {
                  _pagePosition = index;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
