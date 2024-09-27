import 'package:daily_planner/class/const_variable.dart';
import 'package:daily_planner/class/custom_format.dart';
import 'package:daily_planner/models/task.dart';
import 'package:daily_planner/services/task_service.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:daily_planner/widgets/custom_text_field.dart';
import 'package:daily_planner/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TaskDetailSreen extends StatefulWidget {
  TaskDetailSreen({super.key, required this.idTask});

  String idTask;

  @override
  State<TaskDetailSreen> createState() => _TaskDetailSreenState();
}

class _TaskDetailSreenState extends State<TaskDetailSreen> {
  TimeOfDay? _timeStart;
  TimeOfDay? _timeEnd;
  DateTime? _selectedDay;
  bool _isEdittingMode = false;

  late TextEditingController _dateController;
  late TextEditingController _taskTitleController;
  late TextEditingController _taskDecriptionController;
  late TextEditingController _taskLocationController;

  late Future<Task?> task;
  late Task _task;

  @override
  void initState() {
    super.initState();
    _dateController = new TextEditingController();
    _taskTitleController = new TextEditingController();
    _taskDecriptionController = new TextEditingController();
    _taskLocationController = new TextEditingController();
    // _dateController.text =
    //     DateFormat("dd/MM/yyyy").format(_selectedDay).toString();
    task = TaskService().getTaskById(widget.idTask);
  }

  void GetDataToScreen() {
    _dateController.text =
        DateFormat("dd/MM/yyyy").format(_task.dateTime).toString();
    _taskTitleController.text = _task.taskTitle.toString();
    _taskDecriptionController.text = _task.taskDescription;
    _taskLocationController.text = _task.location;
    _timeStart = StringFormat.toTimeOfDay(_task.timeStart);
    _timeEnd = StringFormat.toTimeOfDay(_task.timeEnd);
  }

  // bool compareNewData() {
    
  // }

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
          title: "THÔNG TIN NHIỆM VỤ",
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isEdittingMode = !_isEdittingMode;
                });
                NotifyToast(
                  context: context,
                  message:
                      (_isEdittingMode) ? "Bật chỉnh sửa" : "Tắt chỉnh sửa",
                ).ShowToast();
              },
              icon: Icon(Icons.edit),
            )
          ],
        ),
        body: FutureBuilder(
          future: task,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("LỖI"),
              );
            } else {
              if (snapshot.data == null) {
                return Center(
                  child: Text("LỖI KHÔNG TÌM THẤY CÔNG VIỆC"),
                );
              } else {
                _task = snapshot.data!;
                GetDataToScreen();
                return ShowScreen();
              }
            }
          },
        ),
      ),
    );
  }

  Widget ShowScreen() {
    _dateController.text =
        DateFormat("dd/MM/yyyy").format(_task.dateTime).toString();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                //readOnly: _isEdittingMode,
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
                TimePickerLabel(true),
                SizedBox(width: 10),
                TimePickerLabel(false),
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
              readOnly: !_isEdittingMode,
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
              readOnly: !_isEdittingMode,
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
                readOnly: !_isEdittingMode,
                controller: _taskDecriptionController,
                maxLines: 4,
                context: context,
                hintText: "Nội dung ..."),
            SizedBox(height: 20),
            (_isEdittingMode) ? UpdateTaskButton() : ChangeStatusButton()
          ],
        ),
      ),
    );
  }

  Widget UpdateTaskButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "Cập nhật",
            style: PrimaryTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget ChangeStatusButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Kết thúc",
                  style: PrimaryTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Next Status",
                  style: PrimaryTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget TimePickerLabel(bool isStart) {
    String title = (isStart) ? "Giờ bắt đầu" : "Giờ kết thúc";
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_isEdittingMode) {
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
          } else {
            NotifyToast(
              context: context,
              message: "Chế độ chỉnh sửa đang tắt",
            ).ShowToast();
            return;
          }
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
}
