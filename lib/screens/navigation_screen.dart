import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:daily_planner/screens/add_task_screen.dart';
import 'package:daily_planner/screens/auth_screen.dart';
import 'package:daily_planner/screens/calendar_screen.dart';
import 'package:daily_planner/screens/setting_screen.dart';
import 'package:daily_planner/screens/to_do_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavigationScreen extends StatefulWidget {
  NavigationScreen({super.key, this.currentPagePosition = 1});

  int currentPagePosition;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late int? currentPagePosition;
  @override
  void initState() {
    super.initState();
    currentPagePosition = widget.currentPagePosition;
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return AuthScreen();
    }
    List<Widget> _pages = [CalendarScreen(), ToDoScreen(), SettingScreen()];
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
          _pages[currentPagePosition ?? 1],
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        index: currentPagePosition ?? 1,
        color: Theme.of(context).colorScheme.primary,
        animationDuration: Duration(milliseconds: 400),
        items: _navigationItems,
        onTap: (index) {
          setState(() {
            currentPagePosition = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => AddTaskScreen(),
            ),
          );
        },
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        splashColor: Theme.of(context).colorScheme.shadow,
      ),
    );
  }
}
