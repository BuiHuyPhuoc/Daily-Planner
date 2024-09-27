// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:daily_planner/models/person.dart';

class TaskStatus {
  String? id;
  DateTime dateTime;
  String status;
  Person? person;
  TaskStatus({
    required this.dateTime,
    required this.status,
    this.person,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'status': status,
      'person': person?.toMap(),
    };
  }

  factory TaskStatus.fromMap(Map<String, dynamic> map) {
    return TaskStatus(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      status: map['status'] as String,
      person: map['person'] != null ? Person.fromMap(map['person'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskStatus.fromJson(String source) => TaskStatus.fromMap(json.decode(source) as Map<String, dynamic>);
}
