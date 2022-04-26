import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class CallButton extends StatefulWidget {
  final Function onPressed;
  const CallButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _CallButtonState createState() => _CallButtonState();
}

class _CallButtonState extends State<CallButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: screenWidth(context, dividedBy: 11),
        height: screenWidth(context, dividedBy: 11),
        decoration: BoxDecoration(
          // color: Constants.colors[3],
          shape: BoxShape.circle,
          border:Border.all(color:Constants.colors[5],width:0.9)
          
        ),
        child: Container(
            width: screenWidth(context, dividedBy: 13),
            height: screenWidth(context, dividedBy: 13),
            // padding: EdgeInsets.symmetric(
            //     horizontal: screenWidth(context, dividedBy: 24),
            //     vertical: screenHeight(context, dividedBy: 90)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Constants.colors[6],
                    Constants.colors[5],
                  ]),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    offset: Offset(-2, 2),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Constants.colors[5].withOpacity(0.2)),
                BoxShadow(
                    offset: Offset(2, -2),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Constants.colors[5].withOpacity(0.2)),
                BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Constants.colors[5].withOpacity(0.2)),
                BoxShadow(
                    offset: Offset(-2, -2),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Constants.colors[5].withOpacity(0.2))
              ],
            ),
            child: Center(
                child: Icon(Icons.call_rounded, color: Colors.white, size: 16))),
      ),
    );
  }
}
