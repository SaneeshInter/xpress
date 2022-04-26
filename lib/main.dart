import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/error/ConnectionFailedScreen.dart';
import 'package:xpresshealthdev/ui/error/ErrorScreen.dart';
import 'package:xpresshealthdev/ui/splash/splash_screen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => SplashScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/nw_error': (context) => ConnectionFailedScreen(),
          '/error': (context) => ErrorScreen(),
        },
      );
    });
  }
}
