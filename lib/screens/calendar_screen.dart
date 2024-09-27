import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/class/const_variable.dart';
import 'package:daily_planner/models/task.dart';
import 'package:daily_planner/screens/to_do_screen.dart';
import 'package:daily_planner/services/task_service.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:daily_planner/widgets/custom_table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: "Lịch",
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              CustomTableCalendar(
                onDaySelected: (selectedDate) {
                  setState(() {
                    _selectedDay = selectedDate;
                  });
                },
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  "Kế hoạch trong ngày " +
                      DateFormat('dd/MM/yyyy').format(_selectedDay),
                  style: PrimaryTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 4),
              StreamBuilder<QuerySnapshot>(
                stream: TaskService().getTaskByDateTime(
                    _selectedDay, FirebaseAuth.instance.currentUser!.email!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Hiển thị khi đang tải
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Có lỗi xảy ra: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text("Bạn không có hoạt động trong ngày này."));
                  } else {
                    List<Map<String, dynamic>> tasks = [];
                    //List docQuerySnapshot = snapshot.data!.docs;

                    snapshot.data!.docs.forEach(
                      (element) {
                        Map<String, dynamic> data =
                            element.data() as Map<String, dynamic>;
                        Task getTask = Task.fromMap(data);
                        tasks.add({element.id: getTask.toMap()});
                      },
                    );

                    // Sắp xếp tasks
                    tasks.sort((a, b) {
                      DateTime timeA = DateFormat("HH:mm")
                          .parse(a.values.first['timeStart']);
                      DateTime timeB = DateFormat("HH:mm")
                          .parse(b.values.first['timeStart']);
                      return timeA.compareTo(timeB);
                    });

                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        var idTask = tasks[index]
                            .keys
                            .toString()
                            .replaceAll('"', '')
                            .replaceAll('(', '')
                            .replaceAll(')', '');
                        Task currentTask =
                            Task.fromMap(tasks[index].values.first);
                        return TaskLabel(context, currentTask, idTask);
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   shape: CircleBorder(),
      //   child: Container(
      //     margin: EdgeInsets.only(bottom: 70),
      //     child: const Icon(Icons.navigation),
      //   ),
      // ),
    );
  }
}
