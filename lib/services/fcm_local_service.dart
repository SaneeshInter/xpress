import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import '../ui/manager/home/shift_detail_manager.dart';
import '../ui/user/detail/shift_detail.dart';
import '../ui/user/home/completed_shift_screen.dart';
import '../ui/user/sidenav/notification_screen.dart';
import '../ui/widgets/screen_case.dart';

class FCMLocal {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> fcmInitialize() async {
    debugPrint("FCM Initialize");


    await firebaseMessaging.requestPermission();
    initialise();

    firebaseMessaging.subscribeToTopic("all_device");

    firebaseMessaging.setAutoInitEnabled(true);

    firebaseMessaging.getInitialMessage().then(
            (RemoteMessage? value) => navigate(value?.data['click_action'] ?? ""));

    FirebaseMessaging.onMessage.listen(foregroundListen);

    FirebaseMessaging.onBackgroundMessage(backgroundListen);

    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpen);
  }

  void initialise() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelected);
  }

  Future<void> foregroundListen(RemoteMessage message) async {
    showNotification(message);

  }

  Future<void> backgroundListen(RemoteMessage message) =>
      showNotification(message);

  Future<void> onMessageOpen(RemoteMessage message) =>
      navigate(message.data['click_action']);

  Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    RemoteNotification? notification = message.notification;

    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification?.title ?? "",
        notification?.body ?? "",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name),
            iOS: const IOSNotificationDetails()),
        payload: message.data['click_action']);
  }

  void onSelected(String? payload) {
    if (payload != null) navigate(payload);
  }

  Future<void> navigate(String query) async {
    print("qqqqqqqq on click");
    Future.delayed(const Duration(seconds: 3), () {
      switch (query) {
        case 'SHIFT_DETAILS':
          Navigator.push(
            MyApp.navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (globalContext) =>ScreenCase(title: 'Shift Detail', child: ShiftDetailScreen(
                  shift_id: "id",
                  isCompleted: true,
                ),)
            ),
          );
          break;
        case 'MANAGER_SHIFT_DETAILS':
          Navigator.push(
            MyApp.navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (globalContext) =>ScreenCase(title: 'Shift Detail', child: ShiftDetailManagerScreen(
                  shiftId: "id",
                ),)
            ),
          );
          break;
        case 'UPLOAD_TIME_SHEET':
          Navigator.push(
            MyApp.navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (globalContext) =>ScreenCase(title: 'Upload Time Sheet', child: CompletedShiftScreen(
                ),)
            ),
          );
          break;
        default:
          print("qqqqqqqq default");
          Navigator.push(
            MyApp.navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (globalContext) =>const NotificationScreen()
            ),
          );
          break;
      }
    });
  }
}