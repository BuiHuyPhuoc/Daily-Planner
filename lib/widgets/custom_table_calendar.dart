import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  final Function(DateTime) onDaySelected; // Callback khi chọn ngày
  const CustomTableCalendar({super.key, required this.onDaySelected});

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  DateTime _focusedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _selectedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
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
  }

  _onDaySelected(selectedDay, focusedDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      setState(() {
        DateTime newDateTime = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
        _selectedDay = newDateTime;
        _focusedDay = focusedDay;
      });
      print("Chọn ngày: " + _selectedDay.millisecondsSinceEpoch.toString());
      widget.onDaySelected(_selectedDay);
    }
  }
}
