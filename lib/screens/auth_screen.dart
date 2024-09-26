import 'package:daily_planner/screens/navigation_screen.dart';
import 'package:daily_planner/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("LỖI"),
              );
            } else {
              if (snapshot.data == null) {
                return const WelcomeScreen();
              } else {
                return const NavigationScreen();
              }
            }
          },
        ),
      ),
    );
  }
}
