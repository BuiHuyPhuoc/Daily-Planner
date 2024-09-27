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
  List<String> emailMembers; //Lưu email những người tham gia
  List<Person> members; // Những người tham gia thực hiện task
  List<TaskStatus> taskHistory; // Lịch sử trạng thái của task
  Task({
    required this.dateTime,
    required this.taskTitle,
    required this.taskDescription,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.emailMembers,
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
      'emailMembers': emailMembers,
      'members': members.map((x) => x.toMap()).toList(),
      'taskHistory': taskHistory.map((x) => x.toMap()).toList()
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
      emailMembers: List<String>.from(
        ((map['emailMembers'] != null)
            ? map['emailMembers'] as List<dynamic>
            : []),
      ),
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

  TaskStatus getLastStatus() {
  // Tạo một bản sao của taskHistory để tránh mất dữ liệu
  List<TaskStatus> removeUnusedStatus = List.from(taskHistory);
  
  // Loại bỏ các TaskStatus có status là "Chỉnh sửa"
  removeUnusedStatus.removeWhere((item) => item.status == "Chỉnh sửa");
  
  // Lấy TaskStatus có ngày lớn nhất
  TaskStatus lastestStatus = removeUnusedStatus
      .reduce((a, b) => a.dateTime.isAfter(b.dateTime) ? a : b);
  
  return lastestStatus;
}

}
