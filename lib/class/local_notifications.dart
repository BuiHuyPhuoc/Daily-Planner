import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  static final AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails('YOUR_CHANNEL', 'YOUR_CHANNEL_NAME',
          channelDescription: 'YOUR_CHANNEL_DESCRIPTION',
          importance: Importance.max,
          priority: Priority.defaultPriority,
          ticker: 'ticker');

  // on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

  static Future init() async {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // Show a simple Notification
  static Future showSimpleNotification(
      {required String title,
      required String body,
      required String payload}) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: _androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static Future showPeriodicNotifications(
      {required String title,
      required String body,
      required String payload}) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: _androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        1,
        title,
        body,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        RepeatInterval.everyMinute,
        notificationDetails);
  }

  // close a specific channel notification
  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // close all the notifications avaialble

  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  // schedule a notification
  static Future showScheduleNotification(
      {int id = 0,
      required String title,
      required String body,
      required String payload,
      required DateTime scheduleNotificationDatetime}) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: _androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduleNotificationDatetime, tz.local),
        await notificationDetails,
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    print("Receive schedule");
  }

  static void requestIOSPermission() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(alert: true, badge: true, sound: true);
  }
}
