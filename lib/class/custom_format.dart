import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

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

  static TimeOfDay toTimeOfDay(String timeString) {
    List<String> splitString = timeString.split(":");
    return TimeOfDay(
        hour: int.parse(splitString[0]), minute: int.parse(splitString[1]));
  }
}
