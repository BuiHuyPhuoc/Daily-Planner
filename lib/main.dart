// ignore_for_file: unused_import

import 'package:daily_planner/firebase_options.dart';
import 'package:daily_planner/screens/add_task_screen.dart';
import 'package:daily_planner/screens/auth_screen.dart';
import 'package:daily_planner/screens/calendar_screen.dart';
import 'package:daily_planner/screens/navigation_screen.dart';
import 'package:daily_planner/screens/sign_in_screen.dart';
import 'package:daily_planner/screens/sign_up_screen.dart';
import 'package:daily_planner/screens/to_do_screen.dart';
import 'package:daily_planner/screens/welcome_screen.dart';
import 'package:daily_planner/theme/theme.dart';
import 'package:daily_planner/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeProvider, child) {
        return MaterialApp(
          builder: (context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!),
          home: AuthScreen(),
          theme: lightMode,
        );
      },
    );
  }
}
