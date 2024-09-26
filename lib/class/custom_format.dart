import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class CustomFormat {
  static String formatTimeOfDay(TimeOfDay timer) {
    final String hour = timer.hour.toString().padLeft(2, '0');
    final String minute = timer.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
        .hasMatch(this);
  }
}

class StringFormat {
  static String toSha256String(String string) {
    return sha256.convert(utf8.encode(string)).toString();
  }
}
