import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../Constants/strings.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../Widgets/buttons/build_button.dart';
import '../Widgets/buttons/view_button.dart';
import 'buttons/book_button.dart';

class ActionAlertBox extends StatelessWidget {
  final String tittle;
  final String message;
  final String positiveText;
  final Function onPositvieClick;
  final Function onNegativeClick;

  const ActionAlertBox(
      {Key? key,
      required this.tittle,
      required this.message,
      required this.positiveText,
      required this.onPositvieClick,
      required this.onNegativeClick})
      : super(key: key);

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
                offset: Offset(-2, 2),
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
            AutoSizeText(
              tittle,
              style: TextStyle(
                  fontSize: 17,
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
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildButton(
                    label: Txt.close,
                    onPressed: () {
                      pop(context);
                      debugPrint("Cards booking");
                    },
                    key: null,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  BookButton(
                    label: positiveText,
                    onPressed: () {
                      onPositvieClick();
                    },
                    key: null,
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 80)),
          ],
        ),
      ),
    );
  }
}
