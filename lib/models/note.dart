// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:daily_planner/models/person.dart';

class Note {
  DateTime dateTime;
  String noteTitle;
  TimeOfDay timeStart;
  TimeOfDay timeEnd;
  String location;
  List<Person> members;
  String status;
  Note({
    required this.dateTime,
    required this.noteTitle,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.members,
    this.status = "Tạo mới",
  });

}
