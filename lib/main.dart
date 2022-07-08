
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/services/fcm_service.dart';
import 'package:xpresshealthdev/ui/manager/home/manager_notification_screen.dart';
import 'package:xpresshealthdev/ui/user/sidenav/notification_screen.dart';
import '../ui/error/ConnectionFailedScreen.dart';
import '../ui/error/ErrorScreen.dart';
import '../ui/splash/splash_screen.dart';
import '../ui/user/home/profile_screen.dart';
import '../ui/user/imageupload/upload_documents.dart';

import 'firebase_options.dart';

class ScreenArguments {
  final String type;
  final String imgUrl;
  final String expiry;

  ScreenArguments(this.type, this.imgUrl,this.expiry);
}
enum Availability { morning, day, afternoon, night, sleepover }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations( [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
   FCM().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey=GlobalKey<NavigatorState>();
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
   
        navigatorKey: navigatorKey,

        title: 'xpress health',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/nw_error': (context) =>const ConnectionFailedScreen(),
          '/upload_screen': (context) =>const UploadDocumentsScreen(),
          '/error_screen': (context) =>const ErrorScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/NotificationScreen': (context) => const NotificationScreen(),
          '/ManagerNotificationScreen': (context) => const ManagerNotificationScreen(),
        },
      );
      
    });
  }
}