import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class SubmitButton extends StatefulWidget {
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
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        setState(() {
          tapped = true;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 50),
            vertical: screenHeight(context, dividedBy: 90)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  widget.color1,
                  widget.color2,
                ]),
            color: Constants.colors[3],
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          alignment: Alignment.center,
          child: AutoSizeText.rich(
            TextSpan(
              text: widget.label,
              style: TextStyle(
                  fontSize: 16,
                  color: widget.textColors,
                  fontFamily: "SFProMedium",
                  fontWeight: FontWeight.w600),
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
