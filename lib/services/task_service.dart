import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      tasks.add(task.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getTask(String email) {
    final querySnapshot =
        tasks.where("emailMembers", arrayContains: email).snapshots();
    return querySnapshot;
  }

  Stream<QuerySnapshot> getTaskByDateTime(DateTime dateTime, String email) {
    final querySnapshot = tasks
        .where("dateTime", isEqualTo: dateTime.millisecondsSinceEpoch)
        .where("emailMembers", arrayContains: email)
        .snapshots();

    return querySnapshot;
  }

  Future<Task?> getTaskById(String id) async {
    try {
      final DocumentSnapshot documentSnapshot = await tasks.doc(id).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        Task task = Task.fromMap(data);
        return task;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Some thing went wrong");
    }
  }

  Future<void> updateTask(Task task, String idTask) {
    try {
      return tasks.doc(idTask).update(task.toMap());
    } catch (error) {
      throw Exception("Something went wrong");
    }
  }
}
