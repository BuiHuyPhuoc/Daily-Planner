import 'package:flutter/material.dart';

class CustomFormat {
  static String formatTimeOfDay(TimeOfDay timer) {
    final String hour = timer.hour.toString().padLeft(2, '0');
    final String minute = timer.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
