import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class SubmitButton extends StatelessWidget {
  final Function onPressed;
  final String label;

  final Color textColors;
  final Color color1;
  final Color color2;

  const SubmitButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.textColors,
      required this.color1,
      required this.color2})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();

      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 24),
            vertical: screenHeight(context, dividedBy: 90)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  color1,
                  color2,
                ]),
            color: Constants.colors[3],
            borderRadius: BorderRadius.circular(5)),
        child: Container(
          alignment: Alignment.center,
          child: AutoSizeText.rich(
            TextSpan(
              text: label,
              style: TextStyle(
                  fontSize: 14,
                  color: textColors,
                  fontFamily: "SFProMedium",
                  fontWeight: FontWeight.w400),
            ),
            minFontSize: 0,
            stepGranularity: 0.1,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
