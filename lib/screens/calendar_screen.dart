import 'package:daily_planner/screens/to_do_screen.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:daily_planner/widgets/custom_table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          title: Center(
            child: Text(
              "Lịch",
              style: GoogleFonts.montserrat(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTableCalendar(
                  onDaySelected: (selectedDate) {
                    setState(() {
                      _selectedDay = selectedDate;
                    });
                  },
                ),
                SizedBox(height: 14),
                Container(
                  child: Text(
                    "Kế hoạch trong ngày " +
                        DateFormat('dd/MM/yyyy').format(_selectedDay),
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TaskLabel(context),
                SizedBox(height: 10),
                TaskLabel(context),
                SizedBox(height: 10),
                TaskLabel(context),
                SizedBox(height: 75),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
