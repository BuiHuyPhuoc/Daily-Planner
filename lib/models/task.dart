// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:daily_planner/models/person.dart';
import 'package:daily_planner/models/task_status.dart';

class Task {
  DateTime dateTime; // Ngày thêm task
  String taskTitle; // Title của task
  String taskDescription; // Nội dung của task
  String timeStart; // Giờ bắt đầu
  String timeEnd; // Giờ kết thúc
  String location; // Địa điểm
  List<Person> members; // Những người tham gia thực hiện task
  List<TaskStatus>? taskHistory; // Lịch sử trạng thái của task
  Task({
    required this.dateTime,
    required this.taskTitle,
    required this.taskDescription,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.members,
    required this.taskHistory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
      'location': location,
      'members': members.map((x) => x.toMap()).toList(),
      'taskHistory': taskHistory != null
          ? taskHistory!.map((x) => x.toMap()).toList()
          : [],
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      taskTitle: map['taskTitle'] as String,
      taskDescription: map['taskDescription'] as String,
      timeStart: map['timeStart'] as String,
      timeEnd: map['timeEnd'] as String,
      location: map['location'] as String,
      members: List<Person>.from(
        (map['members'] as List<dynamic>).map<Person>(
          (x) => Person.fromMap(x as Map<String, dynamic>),
        ),
      ),
      taskHistory: List<TaskStatus>.from(
        (map['taskHistory'] as List<dynamic>).map<TaskStatus?>(
          (x) => TaskStatus.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);
}
