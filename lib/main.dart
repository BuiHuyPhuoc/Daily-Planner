// ignore_for_file: unused_import

import 'package:daily_planner/class/local_notifications.dart';
import 'package:daily_planner/firebase_options.dart';
import 'package:daily_planner/screens/add_task_screen.dart';
import 'package:daily_planner/screens/auth_screen.dart';
import 'package:daily_planner/screens/calendar_screen.dart';
import 'package:daily_planner/screens/navigation_screen.dart';
import 'package:daily_planner/screens/setting_screen.dart';
import 'package:daily_planner/screens/sign_in_screen.dart';
import 'package:daily_planner/screens/sign_up_screen.dart';
import 'package:daily_planner/screens/task_detail_sreen.dart';
import 'package:daily_planner/screens/test_screen.dart';
import 'package:daily_planner/screens/to_do_screen.dart';
import 'package:daily_planner/screens/welcome_screen.dart';
import 'package:daily_planner/theme/theme.dart';
import 'package:daily_planner/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotifications.init();
  tz.initializeTimeZones();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, ThemeProvider, child) {
        return MaterialApp(
          builder: (context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!),
          home: NavigationScreen(),
          theme: ThemeProvider.themeData,
        );
      },
    );
  }
}
