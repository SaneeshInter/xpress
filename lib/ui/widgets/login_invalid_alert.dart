import 'package:flutter/material.dart';

import '../../Constants/strings.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'buttons/book_button.dart';

class LoginAlertBox extends StatelessWidget {
  final String title;
  final String message;

  LoginAlertBox({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, dividedBy: 1),
      padding: EdgeInsets.symmetric(
          // horizontal: screenWidth(context, dividedBy: 25),
          vertical: screenHeight(context, dividedBy: 70)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(-2, 2),
                blurRadius: 2,
                spreadRadius: 2,
                color: Constants.colors[7].withOpacity(0.15))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: screenHeight(context, dividedBy: 40)),
            Text(
            title,
              style: TextStyle(
                  fontSize: 15,
                  color: Constants.colors[3],
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 70)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Constants.colors[7],
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 60)),
            BookButton(
              label:Txt.close,
              onPressed: () {
                pop(context);
                debugPrint("Cards booking");
              },
              key: null,
            ),
            SizedBox(height: screenHeight(context, dividedBy: 80)),
          ],
        ),
      ),
    );
  }
}
