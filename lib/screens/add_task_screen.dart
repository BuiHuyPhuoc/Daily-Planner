import 'package:daily_planner/class/const_variable.dart';
import 'package:daily_planner/models/person.dart';
import 'package:daily_planner/models/task.dart';
import 'package:daily_planner/models/task_status.dart';
import 'package:daily_planner/screens/task_detail_sreen.dart';
import 'package:daily_planner/services/person_service.dart';
import 'package:daily_planner/services/task_service.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:daily_planner/widgets/custom_table_calendar.dart';
import 'package:daily_planner/widgets/custom_text_field.dart';
import 'package:daily_planner/widgets/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TimeOfDay? _timeStart;
  TimeOfDay? _timeEnd;
  // DateTime _focusedDay =
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _selectedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  late TextEditingController _dateController;
  late TextEditingController _taskTitleController;
  late TextEditingController _taskDecriptionController;
  late TextEditingController _taskLocationController;

  @override
  void initState() {
    _dateController = new TextEditingController();
    _taskTitleController = new TextEditingController();
    _taskDecriptionController = new TextEditingController();
    _taskLocationController = new TextEditingController();
    _dateController.text =
        DateFormat("dd/MM/yyyy").format(_selectedDay).toString();
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _taskTitleController.dispose();
    _taskDecriptionController.dispose();
    _taskLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: "THÊM NHIỆM VỤ",
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTableCalendar(
                  onDaySelected: (selectedDate) {
                    setState(() {
                      _selectedDay = selectedDate;
                      _dateController.text = DateFormat("dd/MM/yyyy")
                          .format(_selectedDay)
                          .toString();
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Ngày đã chọn",
                  style: PrimaryTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 5),
                CustomTextField(
                    controller: _dateController,
                    context: context,
                    readOnly: true),
                SizedBox(height: 20),
                Text(
                  "Thời gian",
                  style: PrimaryTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    //TimePickerLabel(true),
                    TimePickerButton(
                      context: context,
                      title: "Giờ bắt đầu",
                      onTap: (timeOfDay) {
                        if (timeOfDay != null) {
                          setState(() {
                            _timeStart = timeOfDay;
                          });
                        }
                      },
                      time: _timeStart,
                    ),
                    SizedBox(width: 10),
                    TimePickerButton(
                      context: context,
                      title: "Giờ kết thúc",
                      onTap: (timeOfDay) {
                        if (timeOfDay != null) {
                          setState(() {
                            _timeEnd = timeOfDay;
                          });
                        }
                      },
                      time: _timeEnd,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Tên nhiệm vụ",
                  style: PrimaryTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 5),
                CustomTextField(
                  controller: _taskTitleController,
                  context: context,
                  hintText: "Tên nhiệm vụ ...",
                ),
                SizedBox(height: 20),
                Text(
                  "Địa điểm",
                  style: PrimaryTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 5),
                CustomTextField(
                  controller: _taskLocationController,
                  context: context,
                  hintText: "Địa điểm diễn ra...",
                ),
                SizedBox(height: 20),
                Text(
                  "Nội dung nhiệm vụ",
                  style: PrimaryTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 5),
                CustomTextField(
                    controller: _taskDecriptionController,
                    maxLines: 4,
                    context: context,
                    hintText: "Nội dung ..."),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    ValidateAndAddTask();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "TẠO NHIỆM VỤ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget TimePickerLabel(bool isStart) {
    String title = (isStart) ? "Giờ bắt đầu" : "Giờ kết thúc";
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((value) {
            if (value != null) {
              setState(() {
                (isStart) ? _timeStart = value : _timeEnd = value;
              });
            }
          });
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.access_time_rounded,
                color: Theme.of(context).colorScheme.onSurface,
                size: 30,
              ),
              SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: PrimaryTextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  if (isStart)
                    if (_timeStart != null)
                      Text(
                        _timeStart!.format(context).toString(),
                        style: PrimaryTextStyle(fontSize: 16),
                      )
                    else
                      Container()
                  else if (_timeEnd != null)
                    Text(
                      _timeEnd!.format(context).toString(),
                      style: PrimaryTextStyle(fontSize: 16),
                    )
                  else
                    Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void ValidateAndAddTask() async {
    // Get data from text field
    String taskTitle = _taskTitleController.text.toString().trim();
    String taskDescription = _taskDecriptionController.text.toString().trim();
    String location = _taskLocationController.text.toString().trim();
    if (taskTitle.isEmpty || taskTitle.length == 0) {
      WarningToast(
        context: context,
        message: "Nhập tên nhiệm vụ",
      ).ShowToast();
      return;
    }
    if (location.isEmpty || location.length == 0) {
      WarningToast(
        context: context,
        message: "Nhập địa điểm",
      ).ShowToast();
      return;
    }
    if (taskDescription.isEmpty || taskDescription.length == 0) {
      WarningToast(
        context: context,
        message: "Nhập nội dung",
      ).ShowToast();
      return;
    }
    if (_timeStart == null || _timeStart == null) {
      WarningToast(
        context: context,
        message: "Chọn thời gian bắt đầu và kết thúc",
      ).ShowToast();
      return;
    }
    if ((_timeStart!.hour + _timeStart!.minute / 60) >
        (_timeEnd!.hour + _timeEnd!.minute / 60)) {
      WarningToast(
        context: context,
        message: "Thời gian kết thúc lớn hơn thời gian bắt đầu.",
      ).ShowToast();
      return;
    }
    // Get logged in user
    final User? getCurrentUser = FirebaseAuth.instance.currentUser;
    // Get user as Person
    Person? getCurrentPerson = await PersonService().getPersonByEmail(
      getCurrentUser!.email.toString(),
    );
    TaskStatus firstStatus = new TaskStatus(
      dateTime: DateTime.now(),
      status: "Khởi tạo",
      person: getCurrentPerson!,
    );
    List<TaskStatus> listStatus = [];
    listStatus.add(firstStatus);
    Task newTask = new Task(
        dateTime: _selectedDay,
        taskTitle: taskTitle,
        taskDescription: taskDescription,
        timeStart: _timeStart!.format(context).toString(),
        timeEnd: _timeEnd!.format(context).toString(),
        location: location,
        members: [getCurrentPerson],
        emailMembers: [getCurrentPerson.email],
        taskHistory: listStatus);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          child: Center(
            child: new CircularProgressIndicator(),
          ),
        );
      },
    );
    bool result = await TaskService().createTask(newTask);
    Navigator.pop(context);
    if (result) {
      SuccessToast(
        context: context,
        message: "Thêm nhiệm vụ thành công",
      ).ShowToast();
      Navigator.pop(context);
    } else {
      WarningToast(
        context: context,
        message: "Có lỗi xảy ra khi thêm nhiệm vụ",
      ).ShowToast();
      return;
    }
  }
}
