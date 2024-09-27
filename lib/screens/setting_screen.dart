import 'package:daily_planner/services/auth_service.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(context: context, title: "Daily Planner"),
      body: TextButton(
        onPressed: () {
          AuthService().signOut();
        },
        child: Center(
          child: Text("sign out"),
        ),
      ),
    );
  }
}
