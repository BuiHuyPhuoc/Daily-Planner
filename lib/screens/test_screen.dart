import 'package:daily_planner/class/local_notifications.dart';
import 'package:daily_planner/screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    listenToNotification();
    super.initState();
  }

  // Listen anu notification clicked or not
  listenToNotification() {
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((onData) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavigationScreen()));
    });
  }

  DateTime scheduleTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Flutter local notification"),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              LocalNotifications.showSimpleNotification(
                  title: "Test Title",
                  body: "Test Body ",
                  payload: "Test payload");
            },
            icon: Icon(Icons.notifications),
            label: Text("Simple notification"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              print("Show periodic notifications");
              LocalNotifications.showPeriodicNotifications(
                  title: "Test Periodic Title",
                  body: "Test Periodic Body ",
                  payload: "Test Periodic payload");
            },
            icon: Icon(Icons.timer),
            label: Text("Periodic notification"),
          ),
          TextButton(
            onPressed: () {
              LocalNotifications.cancel(1);
            },
            child: Text("Cancel Periodic Notification"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              DateTime schedule = DateTime.now().add(Duration(seconds: 5));
              print("Show schedule notifications: " + DateFormat("dd/MM/yyyy HH:mm:ss").format(schedule));
              LocalNotifications.showScheduleNotification(
                title: "Test schedule Title",
                body: "Test schedule Body ",
                payload: "Test schedule payload",
                scheduleNotificationDatetime: schedule,
              );
            },
            icon: Icon(Icons.timer),
            label: Text("Schedule notification"),
          )
        ],
      ),
    ));
  }
}
