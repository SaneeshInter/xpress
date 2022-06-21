import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  Future<void> init() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    //:TODO: add FCM Token to server
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");
    if (AwesomeStringUtils.isNullOrEmpty(fcmToken,considerWhiteSpaceAsEmpty: true)) return;


    await FirebaseMessaging.instance.subscribeToTopic("All_Devices");

    FirebaseMessaging.onBackgroundMessage(backgroundListen);
    FirebaseMessaging.onMessage.listen(foregroundListen);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpen);
  }


  Future<void> onMessageOpen(RemoteMessage message) async =>
      showNotification(message);

  Future<void> backgroundListen(RemoteMessage message) async =>
      showNotification(message);

  Future<void> foregroundListen(RemoteMessage message) async =>
      showNotification(message);

  showNotification(RemoteMessage message) async {
    if (!AwesomeStringUtils.isNullOrEmpty(message.notification?.title,
        considerWhiteSpaceAsEmpty: true) ||
        !AwesomeStringUtils.isNullOrEmpty(message.notification?.body,
            considerWhiteSpaceAsEmpty: true)) {
      String? imageUrl;
      imageUrl ??= message.notification!.android?.imageUrl;
      imageUrl ??= message.notification!.apple?.imageUrl;

      Map<String, dynamic> notificationAdapter = {
        NOTIFICATION_CHANNEL_KEY: 'Xpress Health',
        NOTIFICATION_ID: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_ID] ??
            message.messageId ??
            Random().nextInt(2147483647),
        NOTIFICATION_TITLE: message.data[NOTIFICATION_CONTENT]
        ?[NOTIFICATION_TITLE] ??
            message.notification?.title,
        NOTIFICATION_BODY: message.data[NOTIFICATION_CONTENT]
        ?[NOTIFICATION_BODY] ??
            message.notification?.body,
        NOTIFICATION_LAYOUT: AwesomeStringUtils.isNullOrEmpty(imageUrl)
            ? 'Default'
            : 'BigPicture',
        NOTIFICATION_BIG_PICTURE: imageUrl
      };

      AwesomeNotifications()
          .createNotificationFromJsonData(notificationAdapter);
    } else {
      AwesomeNotifications().createNotificationFromJsonData(message.data);
    }
    setUpNotification();
  }


  void setUpNotification() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().createdStream.listen((receivedNotification) {
      String? createdSourceText = AwesomeAssertUtils.toSimpleEnumString(
          receivedNotification.createdSource);
    });

    AwesomeNotifications().actionStream.listen((receivedAction) {
      if (receivedAction.channelKey == 'call_channel') {
        onclick(receivedAction.payload!["action"]!);
        return;
      }
    });
  }

  void onclick(String message) {
    switch(message) {
      case 'UPDATE':
      print("REJECT");
      break;
      default:
      print("default");
      break;
    }
  }


}
