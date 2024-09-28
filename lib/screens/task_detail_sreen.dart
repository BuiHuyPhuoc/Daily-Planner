import 'package:daily_planner/class/const_variable.dart';
import 'package:daily_planner/class/custom_format.dart';
import 'package:daily_planner/models/person.dart';
import 'package:daily_planner/models/task.dart';
import 'package:daily_planner/models/task_status.dart';
import 'package:daily_planner/services/person_service.dart';
import 'package:daily_planner/services/task_service.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:daily_planner/widgets/custom_text_field.dart';
import 'package:daily_planner/widgets/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  Task? _task;

  @override
  void initState() {
    super.initState();
    _dateController = new TextEditingController();
    _taskTitleController = new TextEditingController();
    _taskDecriptionController = new TextEditingController();
    _taskLocationController = new TextEditingController();
    // _dateController.text =
    //     DateFormat("dd/MM/yyyy").format(_selectedDay).toString();
  }

  void GetDataToScreen() {
    if (_dateController.text.length == 0)
      _dateController.text =
          DateFormat("dd/MM/yyyy").format(_task!.dateTime).toString();
    _taskTitleController.text = _task!.taskTitle.toString();
    if (_taskDecriptionController.text.length == 0)
      _taskDecriptionController.text = _task!.taskDescription;
    if (_taskLocationController.text.length == 0)
      _taskLocationController.text = _task!.location;
    if (_timeStart == null)
      _timeStart = StringFormat.toTimeOfDay(_task!.timeStart);
    if (_timeEnd == null) _timeEnd = StringFormat.toTimeOfDay(_task!.timeEnd);
    if (_selectedDay == null) _selectedDay = _task!.dateTime;
  }

  void GetOldData() {
    _dateController.text =
        DateFormat("dd/MM/yyyy").format(_task!.dateTime).toString();
    _taskTitleController.text = _task!.taskTitle.toString();
    _taskDecriptionController.text = _task!.taskDescription;
    _taskLocationController.text = _task!.location;
    _timeStart = StringFormat.toTimeOfDay(_task!.timeStart);
    _timeEnd = StringFormat.toTimeOfDay(_task!.timeEnd);
    _selectedDay = _task!.dateTime;
  }

  bool hasNewData() {
    String title = _taskTitleController.text;
    String taskDescription = _taskDecriptionController.text;
    String taskLocation = _taskLocationController.text;
    String timeStart = _timeStart!.format(context).toString();
    String timeEnd = _timeEnd!.format(context).toString();
    return !(_task!.dateTime == _selectedDay &&
        _task!.taskTitle == title &&
        _task!.taskDescription == taskDescription &&
        _task!.location == taskLocation &&
        _task!.timeStart == timeStart &&
        _task!.timeEnd == timeEnd);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _taskTitleController.dispose();
    _taskDecriptionController.dispose();
    _taskLocationController.dispose();
    super.dispose();
  }

  void ChangeStatus(TaskStatus nextStatus) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      // Get logged in user
      final User? getCurrentUser = FirebaseAuth.instance.currentUser;
      // Get user as Person
      Person? getCurrentPerson = await PersonService().getPersonByEmail(
        getCurrentUser!.email.toString(),
      );
      _task!.taskHistory.add(TaskStatus(
          dateTime: DateTime.now(),
          status: nextStatus.status,
          person: getCurrentPerson!));
      TaskService().updateTask(_task!, widget.idTask);
      SuccessToast(
        context: context,
        message: "Công việc " + nextStatus.status,
      ).ShowToast();
      setState(() {});
    } catch (e) {
      WarningToast(
        context: context,
        message: "Thay đổi trạng thái thất bại",
      ).ShowToast();
    }
    Navigator.pop(context);
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
                if (_task != null) {
                  if (_task!.getLastStatus().status == "Kết thúc" ||
                      _task!.getLastStatus().status == "Hoàn thành") {
                    WarningToast(
                      context: context,
                      message: "Công việc đã hoàn thành, không thể chỉnh sửa",
                    ).ShowToast();
                    setState(() {
                      _isEdittingMode = false;
                    });
                    return;
                  }
                }
                if (hasNewData()) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        "Xác nhận rời?",
                        style: PrimaryTextStyle(fontSize: 20),
                      ),
                      content: Text(
                        "Những thay đổi của bạn sẽ không được lưu",
                        style: PrimaryTextStyle(fontSize: 16),
                      ),
                      actions: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Huỷ",
                            style: PrimaryTextStyle(),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            GetOldData();
                            setState(() {
                              _isEdittingMode = !_isEdittingMode;
                            });
                            NotifyToast(
                              context: context,
                              message: (_isEdittingMode)
                                  ? "Bật chỉnh sửa"
                                  : "Tắt chỉnh sửa",
                            ).ShowToast();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "OK",
                            style: PrimaryTextStyle(),
                          ),
                        )
                      ],
                    ),
                    barrierDismissible: false,
                  );
                } else {
                  setState(() {
                    _isEdittingMode = !_isEdittingMode;
                  });
                  NotifyToast(
                    context: context,
                    message:
                        (_isEdittingMode) ? "Bật chỉnh sửa" : "Tắt chỉnh sửa",
                  ).ShowToast();
                }
              },
              icon: (!_isEdittingMode)
                  ? Icon(Icons.edit)
                  : Icon(Icons.edit_off_sharp),
            )
          ],
        ),
        body: (_task != null)
            ? ShowScreen()
            : FutureBuilder(
                future: TaskService().getTaskById(widget.idTask),
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
                      return ShowScreen();
                    }
                  }
                },
              ),
      ),
    );
  }

  Widget ShowScreen() {
    GetDataToScreen();
    _dateController.text =
        DateFormat("dd/MM/yyyy").format(_task!.dateTime).toString();
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
                Expanded(
                  child: TimePickerButton(
                    context: context,
                    title: "Giờ bắt đầu",
                    isDisable: !_isEdittingMode,
                    onTap: (timeOfDay) {
                      if (timeOfDay != null) {
                        setState(() {
                          _timeStart = timeOfDay;
                        });
                      }
                    },
                    time: _timeStart,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TimePickerButton(
                    context: context,
                    title: "Giờ kết thúc",
                    isDisable: !_isEdittingMode,
                    onTap: (timeOfDay) {
                      if (timeOfDay != null) {
                        setState(() {
                          _timeEnd = timeOfDay;
                        });
                      }
                    },
                    time: _timeEnd,
                  ),
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
            Text(
              "Quá trình thực hiện",
              style: PrimaryTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 5),
            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _task!.taskHistory.length,
              itemBuilder: (context, index) {
                if (index >= _task!.taskHistory.length) {
                  return SizedBox.shrink(); // Tránh lỗi khi vượt quá phạm vi
                }
                var taskStatus = _task!.taskHistory.elementAt(index);
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        taskStatus.status + " bởi " + taskStatus.person.name,
                        style: PrimaryTextStyle(fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_month,
                            color: Theme.of(context).colorScheme.primary,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(DateFormat("dd/MM/yyyy HH:mm")
                              .format(taskStatus.dateTime))
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            //(_isEdittingMode) ? UpdateTaskButton() : ChangeStatusButton()
            if (_task!.getLastStatus().status == "Kết thúc" ||
                _task!.getLastStatus().status == "Hoàn thành")
              FinishedStatusButton(_task!.getLastStatus().status)
            else if (_isEdittingMode)
              UpdateTaskButton()
            else
              ChangeStatusButton()
          ],
        ),
      ),
    );
  }

  Widget UpdateTaskButton() {
    return GestureDetector(
      onTap: () async {
        // Get data from text field
        String taskTitle = _taskTitleController.text.toString().trim();
        String taskDescription =
            _taskDecriptionController.text.toString().trim();
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
        TaskStatus newStatus = new TaskStatus(
          dateTime: DateTime.now(),
          status: "Chỉnh sửa",
          person: getCurrentPerson!,
        );
        List<TaskStatus> listStatus = _task!.taskHistory;
        listStatus.add(newStatus);
        Task newTask = new Task(
            dateTime: _selectedDay ?? _task!.dateTime,
            taskTitle: taskTitle,
            taskDescription: taskDescription,
            timeStart: (_timeStart != null)
                ? _timeStart!.format(context).toString()
                : _task!.timeStart.toString(),
            timeEnd: (_timeEnd != null)
                ? _timeEnd!.format(context).toString()
                : _task!.timeEnd.toString(),
            location: location,
            members: [getCurrentPerson],
            emailMembers: [getCurrentPerson.email],
            taskHistory: listStatus);
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });
        try {
          TaskService().updateTask(newTask, widget.idTask);
          SuccessToast(
            context: context,
            message: "Cập nhật công việc thành công",
          ).ShowToast();
          setState(() {
            _task = newTask;
            _isEdittingMode = false;
          });
        } catch (e) {
          WarningToast(
            context: context,
            message: "Lỗi. Không thể cập nhật công việc",
          ).ShowToast();
        }
        Navigator.pop(context);
      },
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

  Widget FinishedStatusButton(String status) {
    return Container(
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
          "Nhiệm vụ này đã " + status,
          style: PrimaryTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget ChangeStatusButton() {
    TaskStatus nextStatus = _task!.getLastStatus().getLastStatus();
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              TaskStatus finishedStatus = nextStatus;
              finishedStatus.status = "Kết thúc";
              ChangeStatus(finishedStatus);
            },
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
            onTap: () async {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  nextStatus.status,
                  style: PrimaryTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TimePickerButton extends StatefulWidget {
  TimePickerButton(
      {super.key,
      required this.context,
      required this.onTap,
      this.isDisable = false,
      required this.title,
      this.time});

  final Function(TimeOfDay?) onTap; // Callback khi chọn ngày
  final bool isDisable;
  final String title;
  final TimeOfDay? time;
  final BuildContext context;

  @override
  State<TimePickerButton> createState() => _TimePickerButtonState();
}

class _TimePickerButtonState extends State<TimePickerButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isDisable) {
          NotifyToast(
            context: context,
            message: "Chế độ chỉnh sửa đang tắt",
          ).ShowToast();
          return;
        } else {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((value) {
            if (value != null) {
              return widget.onTap(value);
            } else {
              return widget.onTap(null);
            }
          });
        }
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
                  widget.title,
                  style: PrimaryTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                (widget.time != null)
                    ? Text(
                        widget.time!.format(context).toString(),
                        style: PrimaryTextStyle(fontSize: 16),
                      )
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
