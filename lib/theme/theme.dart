import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF1A4D2E),
  onPrimary: Color(0xFFE8DFCA),
  secondary: Color(0xFF4F6F52),
  onSecondary: Color(0xFFF5EFE6),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFF5EFE6),
  onSurface: Color(0xFF1A4D2E),
  shadow: Color(0xFF000000),
  outline: Color(0xFF1A4D2E),
  outlineVariant: Color(0xFF4F6F52),
  primaryContainer: Color(0xFF1A4D2E),
  onPrimaryContainer: Color(0xFFE8DFCA),
  secondaryContainer: Color(0xFF4F6F52),
  onSecondaryContainer: Color(0xFFF5EFE6),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF222831),
  onPrimary: Color(0xFFEEEEEE),
  secondary: Color(0xFF31363F),
  onSecondary: Color(0xFFEEEEEE),
  error: Color.fromARGB(255, 255, 0, 0),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFF31363F),
  onSurface: Color(0xFFEEEEEE),
  shadow: Color(0xFFEEEEEE),
  outline: Color(0xFFEEEEEE),
  outlineVariant: Color(0xFF76ABAE),
  primaryContainer: Color(0xFF222831),
  onPrimaryContainer: Color(0xFFEEEEEE),
  secondaryContainer: Color(0xFF31363F),
  onSecondaryContainer: Color(0xFFEEEEEE),
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        lightColorScheme.primary, // Slightly darker shade for the button
      ),
      foregroundColor:
          WidgetStateProperty.all<Color>(Colors.white), // text color
      elevation: WidgetStateProperty.all<double>(5.0), // shadow
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust as needed
        ),
      ),
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  primaryTextTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
);