import 'dart:async';

import 'package:flutter/material.dart';
import 'toast.dart';

class DoubleBack extends StatefulWidget {
  final Widget child;
  final BuildContext context;
  final String message;
  final int waitForSecondBackPress;
  final Function? onFirstBackPress;
  final TextStyle textStyle;
  final Color background;
  final double backgroundRadius;
  final int index;

  const DoubleBack({
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

  @override
  _DoubleBackState createState() => _DoubleBackState();
}

class _DoubleBackState extends State<DoubleBack> {
  bool tapped = false;
  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: () async {
          debugPrint("onWillPop ${widget.index}");
         if(widget.index==0&&!Navigator.canPop(context)){
             if (tapped) {
               return true;
             }
             else {
               tapped = true;
               Timer(
                 Duration(
                   seconds: widget.waitForSecondBackPress,
                 ),
                 resetBackTimeout,
               );

               if (widget.onFirstBackPress != null) {
                 widget.onFirstBackPress!(context);
               } else {
                 Toast.show(
                   widget.message,
                   context,
                   duration: widget.waitForSecondBackPress,
                   gravity: Toast.bottom,
                   textStyle: widget.textStyle,
                   backgroundColor: widget.background,
                   backgroundRadius: widget.backgroundRadius,
                 );
               }

               return false;
             }
         }else{
            return true;
         }
        },
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  void resetBackTimeout() {
    tapped = false;
  }
}