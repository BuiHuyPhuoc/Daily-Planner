import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/services/task_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  final Function(DateTime) onDaySelected;
  const CustomTableCalendar({super.key, required this.onDaySelected});

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  DateTime _focusedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _selectedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  late Map<DateTime, List<String>> _events = {};
  List<DateTime> dayHasTask = [];

  @override
  void initState() {
    super.initState();  
  }

  List<String> _getEventsForDay(DateTime day) {
    DateTime simpleDay = DateTime(day.year, day.month, day.day);
    return _events[simpleDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TaskService().getTask(FirebaseAuth.instance.currentUser!.email!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Clear the list before adding new data
          dayHasTask.clear();

          // Iterate through documents in the snapshot
          for (var doc in snapshot.data!.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            // Check if the dateTime field exists in the document
            if (data['dateTime'] != null) {
              DateTime dateTime =
                  DateTime.fromMillisecondsSinceEpoch(data['dateTime'] as int);
              dayHasTask.add(dateTime); // Add the dateTime to the list
            }
          }
          dayHasTask.forEach((value) {
            _events.addAll({new DateTime(value.year, value.month, value.day) : [""]});
          });
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TableCalendar(
              eventLoader: _getEventsForDay,
              availableGestures: AvailableGestures.horizontalSwipe,
              startingDayOfWeek: StartingDayOfWeek.monday,
              focusedDay: _focusedDay,
              headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  titleCentered: true,
                  formatButtonVisible: false),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
                weekendStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              calendarStyle: CalendarStyle(
                markersMaxCount: 1,
                markerDecoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface, // Màu sắc của dấu sự kiện
                  shape: BoxShape.circle, // Dạng hình tròn của dấu
                ),
                weekendTextStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
                defaultTextStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
              firstDay: DateTime(2010),
              lastDay: DateTime(2030),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _onDaySelected(selectedDay, focusedDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      setState(() {
        DateTime newDateTime =
            DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
        _selectedDay = newDateTime;
        _focusedDay = focusedDay;
      });
      widget.onDaySelected(_selectedDay);
    }
  }
}
