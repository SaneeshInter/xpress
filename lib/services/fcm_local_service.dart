import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';
import '../resources/api_provider.dart';
import '../resources/token_provider.dart';
import '../ui/manager/home/shift_detail_manager.dart';
import '../ui/user/detail/shift_detail.dart';
import '../ui/user/home/completed_shift_screen.dart';
import '../ui/widgets/screen_case.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class FCMLocal {
  final _userNotificationCounter = PublishSubject<int>();

  Stream<int> get notificationCount => _userNotificationCounter.stream;
  String fcmToken = '';
  late Stream<String> _tokenStream;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> fcmInitialize() async {
    debugPrint("FCM Initialize");

    await firebaseMessaging.requestPermission();
    initialise();

    firebaseMessaging.subscribeToTopic("all_device");

    firebaseMessaging.setAutoInitEnabled(true);

    firebaseMessaging.getInitialMessage().then((RemoteMessage? value) => navigate(value?.data['payload'] ?? ""));

    FirebaseMessaging.onMessage.listen(foregroundListen);
    //
    // FirebaseMessaging.onBackgroundMessage(backgroundListen);

    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpen);
  }

  getFCMToken() async {
    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  void setToken(String? token) async {
    debugPrint('FCM Token Initial : $token');

    fcmToken = token!;
    String auth = await TokenProvider().getToken() ?? '';
    String user_type = await TokenProvider().getUserId() ?? '';
    if (auth != "") {
      var respose = await ApiProvider().updateFCMToken(auth, fcmToken, user_type);
      debugPrint('FCM Token Updated: $respose');
    }
  }

  void initialise() {
    getFCMToken();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentBadge: false,
      defaultPresentAlert: true,
      defaultPresentSound: true

    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,

    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelected);
  }



}

Future<void> backgroundListen(RemoteMessage message) => showNotification(message);
Future<void> onMessageOpen(RemoteMessage message) => navigate(message.data['payload']);
Future<void> foregroundListen(RemoteMessage message) async {
  showNotification(message);
}
Future<void> showNotification(RemoteMessage message) async {
  // FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpen);

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    defaultPresentSound: true,
    defaultPresentAlert: true,
    defaultPresentBadge: false,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelected);
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Xpress_Health', // id
    'Xpress Health', // title
    description: 'This channel is used for important notifications by Xpress Health.',
    importance: Importance.max,
    playSound: true,
    showBadge: true,
    enableLights: true,
    enableVibration: true,
  );

  RemoteNotification? notification = message.notification;
  print("dsdsfdfsffdf ${message.data['payload']}");

  flutterLocalNotificationsPlugin.show(

      notification.hashCode,
      notification?.title ?? "",
      notification?.body ?? "",
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              enableVibration: true, enableLights: true, playSound: true, channelShowBadge: true, colorized: true, importance: Importance.max, showProgress: true),
          iOS: const IOSNotificationDetails(
            presentSound: true,presentAlert: true,presentBadge: true,

          )),

      payload: message.data['payload'],);
}


void onSelected(String? payload) {
  print('dsdsfdfsffdf $payload ');
  if (payload != null) navigate(payload);
}
Future<void> navigate(String query) async {
  if (query.isNotEmpty) {
    Map valueMap = jsonDecode(query);

    print("qqqqqqqq on click $query");
    Future.delayed(const Duration(seconds: 0), () {
      switch (valueMap["type"].toString()) {
        case 'SHIFT_DETAILS':
          Navigator.push(
            MyApp.navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (globalContext) => ScreenCase(
                      title: 'Shift Detail',
                      child: ShiftDetailScreen(
                        shift_id: valueMap["id"].toString(),
                        isCompleted: true,
                      ),
                    )),
          );
          break;
        case 'MANAGER_SHIFT_DETAILS':
          Navigator.push(
            MyApp.navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (globalContext) => ScreenCase(
                      title: 'Shift Detail',
                      child: ShiftDetailManagerScreen(
                        shiftId: valueMap["id"].toString(),
                      ),
                    )),
          );
          break;
        case 'UPLOAD_TIME_SHEET':
          Navigator.push(
            MyApp.navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (globalContext) => ScreenCase(
                      title: 'Upload Time Sheet',
                      child: const CompletedShiftScreen(),
                    )),
          );
          break;
        default:
          // print("qqqqqqqq default");
          // Navigator.push(
          //   MyApp.navigatorKey.currentContext!,
          //   MaterialPageRoute(
          //       builder: (globalContext) =>const NotificationScreen()
          //   ),
          // );
          break;
      }
    });
  }
}
