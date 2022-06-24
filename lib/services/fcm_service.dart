import 'dart:math';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../resources/api_provider.dart';
import '../resources/token_provider.dart';
import '../ui/user/detail/shift_detail.dart';
late BuildContext globalContext;
class FCM {
  String fcmToken="";
  late Stream<String> _tokenStream;

  Future<void> init() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    getFCMToken();

    await FirebaseMessaging.instance.subscribeToTopic("All_Devices");
    setUpNotification();
    FirebaseMessaging.onBackgroundMessage(backgroundListen);
    FirebaseMessaging.onMessage.listen(foregroundListen);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpen);

  }


  getFCMToken() async{
    FirebaseMessaging.instance
        .getToken()
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  void setToken(String? token) async {
    print('FCM Token: $token');

    fcmToken = token!;
    String auth = await TokenProvider().getToken()??"";
    String user_type = await TokenProvider().getUserId()??"";
    if (auth != "") {
      var respose =await ApiProvider().updateFCMToken( auth, fcmToken,user_type);
      print("FCM Token Updated: $respose");
    }
  }

  Future<void> onMessageOpen(RemoteMessage message) async =>
      showNotification(message);

  Future<void> backgroundListen(RemoteMessage message) async =>
      showNotification(message);

  Future<void> foregroundListen(RemoteMessage message) async =>
      showNotification(message);

  showNotification(RemoteMessage message) async {
    print("sdfcddrgdg ${message.toMap().toString()}");
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random().nextInt(2147483647),
          notificationLayout: NotificationLayout.Inbox,
           channelKey: 'basic_channel',
            title: message.data[NOTIFICATION_CONTENT]
            ?[NOTIFICATION_TITLE] ??
                message.notification?.title,
            body: message.data[NOTIFICATION_CONTENT]
            ?[NOTIFICATION_BODY] ??
                message.notification?.body,
            payload: message.data["payload"] ,
            category: message.data["category"] ,
          bigPicture:
          'https://tecnoblog.net/wp-content/uploads/2019/09/emoji.jpg',
            wakeUpScreen: true,
            fullScreenIntent: true,

            criticalAlert: true,
            showWhen: true,
            displayOnForeground: true,
            displayOnBackground: true,
            locked: false,


        ),
        actionButtons: [
          NotificationActionButton(
            key: "Open",
            label: "Open",
          ),
        ]
    );


    // if (!AwesomeStringUtils.isNullOrEmpty(message.notification?.title,
    //     considerWhiteSpaceAsEmpty: true) ||
    //     !AwesomeStringUtils.isNullOrEmpty(message.notification?.body,
    //         considerWhiteSpaceAsEmpty: true)) {
    //   String? imageUrl;
    //   imageUrl ??= message.notification!.android?.imageUrl;
    //   imageUrl ??= message.notification!.apple?.imageUrl;
    //
    //   Map<String, dynamic> notificationAdapter = {
    //     NOTIFICATION_CHANNEL_KEY: 'basic_channel',
    //     NOTIFICATION_ID: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_ID] ??
    //         message.messageId ??
    //         Random().nextInt(2147483647),
    //     NOTIFICATION_TITLE: message.data[NOTIFICATION_CONTENT]
    //     ?[NOTIFICATION_TITLE] ??
    //         message.notification?.title,
    //     NOTIFICATION_BODY: message.data[NOTIFICATION_CONTENT]
    //     ?[NOTIFICATION_BODY] ??
    //         message.notification?.body,
    //     NOTIFICATION_LAYOUT: AwesomeStringUtils.isNullOrEmpty(imageUrl)
    //         ? 'Default'
    //         : 'BigPicture',
    //     NOTIFICATION_BIG_PICTURE: imageUrl
    //   };
    //
    //   AwesomeNotifications()
    //       .createNotificationFromJsonData(notificationAdapter);
    // } else {
    //   AwesomeNotifications().createNotificationFromJsonData(message.data);
    // }

  }


  void setUpNotification() {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel', /* same name */
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: const Color(0xFF9D50DD),
              groupSort: GroupSort.Desc,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              criticalAlerts: false,
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupkey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: false);

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    ////Notification Listener

    AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification receivedNotification) {

    });
    AwesomeNotifications().createdStream.listen((receivedNotification) {
      String? createdSourceText = AwesomeAssertUtils.toSimpleEnumString(
          receivedNotification.createdSource);
    });
    //
    // AwesomeNotifications().actionStream.listen((ReceivedAction receivedAction) {
    //   onclick(receivedAction.payload.toString(),"");
    //   if (receivedAction.channelKey == 'basic_channel') {
    //     onclick(receivedAction.payload.toString(),"");
    //     return;
    //   }
    // });
  }

  void onclick(String action,id) {
    print("zdscfdsfsf  $action  $id");;
    switch(action) {
      case 'SHIFT_DETAILS':
        Navigator.push(
          globalContext,
          MaterialPageRoute(
              builder: (context) =>
                  ShiftDetailScreen(
                    shift_id: id,
                    isCompleted: false,
                  )),
        );
      break;
      default:
      print("default");
      break;
    }
  }


}
