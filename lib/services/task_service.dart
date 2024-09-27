import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/models/person.dart';
import 'package:daily_planner/models/task.dart';

class TaskService {
  static final TaskService _taskService = TaskService._internal();

  final CollectionReference tasks =
      FirebaseFirestore.instance.collection("tasks");

  factory TaskService() {
    return _taskService;
  }

  TaskService._internal();

  Future<bool> createTask(Task task) async {
    try {
      print(task.toMap());
      tasks.add(task.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getTaskByDateTime(DateTime dateTime, Person person) {
    final querySnapshot = tasks
        .where("dateTime", isEqualTo: dateTime.millisecondsSinceEpoch)
        .where("members", arrayContains: person.toMap())
        .snapshots();
    
    return querySnapshot;
  }
}
