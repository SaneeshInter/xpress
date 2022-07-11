import 'dart:async';

import 'package:flutter/material.dart';
import 'toast.dart';

class DoubleBack extends StatelessWidget {
  final Widget child;
  final BuildContext context;
  final String message;
  final int waitForSecondBackPress;
  final Function? onFirstBackPress;
  final TextStyle textStyle;
  final Color background;
  final double backgroundRadius;
  final int index;

   DoubleBack({
    Key? key,
    required this.child,
    this.message = "Press back again to exit",
    this.waitForSecondBackPress = 2,
    this.onFirstBackPress,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.background = const Color(0xAA000000),
    this.backgroundRadius = 20,
    required this.index, required this.context,
  }) : super(key: key);


  bool tapped = false;
  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: () async {
          debugPrint("onWillPop ${index} ${Navigator.canPop(context)}");
         if(index==0&&!Navigator.canPop(context)){
             if (tapped) {
               return true;
             }
             else {
               tapped = true;
               Timer(
                 Duration(
                   seconds: waitForSecondBackPress,
                 ),
                 resetBackTimeout,
               );

               if (onFirstBackPress != null) {
                 onFirstBackPress!(context);
               } else {
                 Toast.show(
                   message,
                   context,
                   duration: waitForSecondBackPress,
                   gravity: Toast.bottom,
                   textStyle: textStyle,
                   backgroundColor: background,
                   backgroundRadius: backgroundRadius,
                 );
               }

               return false;
             }
         }else{
            return true;
         }
        },
        child: child,
      );
    } else {
      return child;
    }
  }

  void resetBackTimeout() {
    tapped = false;
  }
}