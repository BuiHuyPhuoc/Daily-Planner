import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final List<Widget> tasks = List.generate(7, (index) => TaskLabel(),);
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
    SetupData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Công việc",
              style: GoogleFonts.manrope(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(10),
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
                                  ? Color(0xffF5EFE6)
                                  : Color(0xff1A4D2E),
                            ),
                          ),
                          selectedColor: Color(0xff1A4D2E),
                          backgroundColor: Color(0xffF5EFE6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: _value == index
                                  ? Color(0xff1A4D2E)
                                  : Color(0xffF5EFE6),
                              width: 2.0,
                            ),
                          ),
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
      ),
    );
  }

  Widget DateLabel(DateTime dateTime, int position) {
    return Container(
      width: 50,
      padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
      decoration: BoxDecoration(
        color: (dateTime == DateTime.now())
            ? Color(0xff4F6F52)
            : Color(0xffF5EFE6),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text("Wed"),
          SizedBox(height: 5),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  dateTime.day.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget TaskLabel() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
        color: Color(0xffF5EFE6), borderRadius: BorderRadius.circular(10)),
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
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.timer,
              color: Color(0xff1A4D2E),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                child: Text(
                  "8:00 - 10:00",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xff1A4D2E)),
              child: Text(
                "DONE",
                style: TextStyle(color: Color(0xffF5EFE6)),
              ),
            )
          ],
        )
      ],
    ),
  );
}
