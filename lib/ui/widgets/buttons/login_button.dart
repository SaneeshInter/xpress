import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class LoginButton extends StatefulWidget {
  final Function onPressed;
  final String label;

  const LoginButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
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
            horizontal: screenWidth(context, dividedBy: 5),
            vertical: screenHeight(context, dividedBy: 79)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Constants.colors[3],
                  Constants.colors[4],
                ]),
            color: Constants.colors[4],
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          widget.label,
          style: TextStyle(
              fontSize: 14.sp,
              color: Constants.colors[0],
              fontFamily: "SFProMedium",
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
