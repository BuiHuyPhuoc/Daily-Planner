import 'package:daily_planner/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TimeOfDay? _timeStart;
  TimeOfDay? _timeEnd;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late TextEditingController dateController;

  @override
  void initState() {
    dateController = new TextEditingController();
    dateController.text =
        DateFormat("dd/MM/yyyy").format(_selectedDay).toString();
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),
          title: Center(
            child: Text(
              "THÊM NHIỆM VỤ",
              style: GoogleFonts.manrope(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color(0xff4F6F52),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TableCalendar(
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    focusedDay: _focusedDay,
                    headerStyle: HeaderStyle(
                        titleCentered: true, formatButtonVisible: false),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                      weekendStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: Color(0xff1A4D2E),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Color(0xff1A4D2E).withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                    ),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 10, 16),
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: _onDaySelected,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Ngày đã chọn",
                  style: GoogleFonts.manrope(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                CustomTextField(
                  controller: dateController,
                    context: context,
                    readOnly: true),
                SizedBox(height: 12),
                Text(
                  "Tên nhiệm vụ",
                  style: GoogleFonts.manrope(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                CustomTextField(context: context, hintText: "Tên nhiệm vụ ..."),
                SizedBox(height: 10),
                Text(
                  "Nội dung nhiệm vụ",
                  style: GoogleFonts.manrope(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                CustomTextField(
                    maxLines: 4, context: context, hintText: "Nội dung ..."),
                SizedBox(height: 10),
                Text(
                  "Thời gian",
                  style: GoogleFonts.manrope(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff1A4D2E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "TẠO NHIỆM VỤ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xffF5EFE6),
                      ),
                    ),
                  ),
                )
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
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: Color(0xff1A4D2E),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.access_time_rounded,
                color: Color(0xff1A4D2E),
                size: 30,
              ),
              SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff1A4D2E),
                    ),
                  ),
                  if (isStart)
                    if (_timeStart != null)
                      Text(
                        _timeStart!.format(context).toString(),
                        style: GoogleFonts.manrope(fontSize: 16),
                      )
                    else
                      Container()
                  else if (_timeEnd != null)
                    Text(
                      _timeEnd!.format(context).toString(),
                      style: GoogleFonts.manrope(fontSize: 16),
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

  _onDaySelected(selectedDay, focusedDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        dateController.text =
        DateFormat("dd/MM/yyyy").format(_selectedDay).toString();
      });
    }
  }
}
