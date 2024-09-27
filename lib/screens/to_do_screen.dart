// ignore_for_file: unused_import

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/class/const_variable.dart';
import 'package:daily_planner/models/person.dart';
import 'package:daily_planner/models/task.dart';
import 'package:daily_planner/screens/auth_screen.dart';
import 'package:daily_planner/services/person_service.dart';
import 'package:daily_planner/services/task_service.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  int _choiceChipValue = 0;
  DateTime _selectedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final List<String> _choices = [
    "Tất cả",
    "Mới tạo",
    "Đang thực hiện",
    "Thành công",
    "Kết thúc",
  ];
  late DateTime firstDayOfWeek;
  late List<Widget> dateLabels;
  _ToDoScreenState() {
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    this.firstDayOfWeek = now.add(Duration(days: -(now.weekday - 1)));
  }

  void SetupData() async {
    setState(() {});
  }

  void CreateDateLabel() {
    dateLabels = [];
    for (int i = 0; i <= 6; i++) {
      dateLabels.add(DateLabel(this.firstDayOfWeek.add(Duration(days: i))));
    }
  }

  @override
  void initState() {
    SetupData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CreateDateLabel();
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: "Công việc trong tuần",
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: dateLabels,
                ),
              ),
              Container(
                height: 90,
                width: double.infinity,
                child: Center(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: _choices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChoiceChip(
                        showCheckmark: false,
                        label: Text(
                          _choices[index],
                          style: PrimaryTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: (_choiceChipValue == index)
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        selectedColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.outline)),
                        selected: _choiceChipValue == index,
                        onSelected: (bool selected) {
                          setState(
                            () {
                              _choiceChipValue = index;
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              TaskArea(context),
              Container(
                height: 65,
                color: Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget DateLabel(DateTime dateTime) {
    bool _isSameDay = isSameDay(dateTime, _selectedDay);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = dateTime;
          SetupData();
        });
        print(dateTime.millisecondsSinceEpoch);
        print(dateTime.toString());
      },
      child: Container(
        width: 50,
        padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
        decoration: BoxDecoration(
          color: (_isSameDay)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: (!_isSameDay)
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  (dateTime.weekday != 7)
                      ? "Thứ " + (dateTime.weekday + 1).toString()
                      : "CN",
                  style: TextStyle(
                    fontSize: 13,
                    color: (!_isSameDay)
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: (!_isSameDay)
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    dateTime.day.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: (!_isSameDay)
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//   Future<Widget> TaskArea() async {
//     Person? getCurrentPerson = await PersonService().getCurrentPerson();
//     if (getCurrentPerson == null) {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (builder) => AuthScreen()),
//           (Route<dynamic> route) => false);
//     }

//     // Sử dụng FutureBuilder để chờ dữ liệu người dùng
//     return FutureBuilder<List<Task>>(
//       future: _getTasksByDateTime(
//           _selectedDay, getCurrentPerson!), // Tạo hàm mới để lấy tasks
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child: CircularProgressIndicator()); // Hiển thị khi đang tải
//         } else if (snapshot.hasError) {
//           return Center(child: Text("Có lỗi xảy ra: ${snapshot.error}"));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text("Bạn không có hoạt động trong ngày này."));
//         } else {
//           List<Task> tasks = snapshot.data!;
//           // Sắp xếp tasks
//           tasks.sort((a, b) {
//             DateTime timeA = DateFormat("HH:mm").parse(a.timeStart);
//             DateTime timeB = DateFormat("HH:mm").parse(b.timeStart);
//             return timeA.compareTo(timeB);
//           });

//           return ListView.separated(
//             separatorBuilder: (context, index) => SizedBox(height: 10),
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return TaskLabel(context, tasks[index]);
//             },
//           );
//         }
//       },
//     );
//   }

// // Tạo hàm mới để lấy tasks
//   Future<List<Task>> _getTasksByDateTime(
//       DateTime selectedDay, Person currentPerson) async {
//     List<Task> tasks = [];
//     final querySnapshot =
//         await TaskService().getTaskByDateTime(selectedDay, currentPerson);
//     querySnapshot.forEach((doc) {
//       for (var doc in doc.docs) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         Task getTask = Task.fromMap(data);
//         tasks.add(getTask);
//       }
//     });
//     return tasks; // Trả về danh sách tasks
//   }
  Widget TaskArea(BuildContext context) {
    // Lấy thông tin người dùng
    return FutureBuilder<Person?>(
      future: PersonService().getCurrentPerson(),
      builder: (context, personSnapshot) {
        if (personSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Hiển thị khi đang tải
        } else if (personSnapshot.hasError || personSnapshot.data == null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => AuthScreen()),
              (Route<dynamic> route) => false);
          return Container(); // Đảm bảo trả về một widget
        }

        Person currentPerson = personSnapshot.data!;

        // Sử dụng StreamBuilder để theo dõi sự thay đổi
        return StreamBuilder<QuerySnapshot>(
          stream: TaskService().getTaskByDateTime(_selectedDay, currentPerson),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator()); // Hiển thị khi đang tải
            } else if (snapshot.hasError) {
              return Center(child: Text("Có lỗi xảy ra: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text("Bạn không có hoạt động trong ngày này."));
            } else {
              List<Task> tasks = [];
              List docQuerySnapshot = snapshot.data!.docs;

              for (var doc in docQuerySnapshot) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                Task getTask = Task.fromMap(data);
                tasks.add(getTask);
              }

              // Sắp xếp tasks
              tasks.sort((a, b) {
                DateTime timeA = DateFormat("HH:mm").parse(a.timeStart);
                DateTime timeB = DateFormat("HH:mm").parse(b.timeStart);
                return timeA.compareTo(timeB);
              });

              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskLabel(context, tasks[index]);
                },
              );
            }
          },
        );
      },
    );
  }

  Widget TaskLabel(BuildContext context, Task task) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            width: 1, color: Theme.of(context).colorScheme.secondary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  task.taskTitle,
                  style: PrimaryTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Icon(Icons.edit)
            ],
          ),
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            task.taskDescription,
            style: PrimaryTextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.timer,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Container(
                  child: Text(
                    task.timeStart + " - " + task.timeEnd,
                    style: PrimaryTextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                child: Text(
                  "DONE",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
