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

  List<Widget> _pages = [CalendarScreen(), ToDoScreen(), SettingScreen()];
  @override
  Widget build(BuildContext context) {
    List<Widget> _navigationItems = [
      Icon(
        Icons.calendar_month,
        size: 30,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      Icon(
        Icons.work,
        size: 30,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      Icon(
        Icons.settings,
        size: 30,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ];
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _pages[_pagePosition],
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        index: _pagePosition,
        color: Theme.of(context).colorScheme.primary,
        animationDuration: Duration(milliseconds: 400),
        items: _navigationItems,
        onTap: (index) {
          setState(() {
            _pagePosition = index;
          });
        },
      ),
    );
  }
}
