import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  int? _value = 0;
  final List<String> _choices = [
    "Mới tạo",
    "Đang thực hiện",
    "Thành công",
    "Kết thúc",
  ];
  late DateTime firstDayOfWeek;
  late List<Widget> dateLabels;
  _ToDoScreenState({DateTime? firstDayOfWeek}) {
    DateTime now = DateTime.now();
    this.firstDayOfWeek =
        firstDayOfWeek ?? now.add(Duration(days: -(now.weekday - 1)));
  }

  void SetupData() {
    dateLabels = [];
    for (int i = 0; i <= 6; i++) {
      dateLabels.add(DateLabel(this.firstDayOfWeek.add(Duration(days: i)), i));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tasks = List.generate(
      7,
      (index) => TaskLabel(context),
    );
    SetupData();
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: Center(
          child: Text(
            "Công việc",
            style: GoogleFonts.openSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
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
                          style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: (_value == index)
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
                                color:
                                    Theme.of(context).colorScheme.outline)),
                        selected: _value == index,
                        onSelected: (bool selected) {
                          setState(
                            () {
                              _value = index;
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Column(
                children: tasks,
              ),
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

  Widget DateLabel(DateTime dateTime, int position) {
    bool _isSameDay = isSameDay(dateTime, DateTime.now());
    return Container(
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
          SizedBox(height: 5),
          Text(
            "Wed",
            style: TextStyle(
              fontSize: 16,
              color: (!_isSameDay)
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 5),
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
    );
  }
}

Widget TaskLabel(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
      border:
          Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Tét phông chữ",
                style: GoogleFonts.lexendDeca(
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
          "Message of the noteeedddd",
          style: GoogleFonts.lexendDeca(
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
                  "8:00 - 10:00",
                  style: GoogleFonts.roboto(
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
