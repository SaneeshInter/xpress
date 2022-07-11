import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class DrawableButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final String asset;
  final Color textColors;
  final Color backgroundColor;

   DrawableButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.backgroundColor,
      required this.textColors,
      required this.asset})
      : super(key: key);


  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();

      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 200),
            vertical: screenHeight(context, dividedBy: 200)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [backgroundColor, backgroundColor]),
            color: Constants.colors[3],
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 2, 5, 2),
              child: SvgPicture.asset(
                asset,
                height: screenWidth(context, dividedBy: 30),
                width: screenWidth(context, dividedBy: 30),
                color: textColors,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: AutoSizeText(
                label,
                style: TextStyle(
                    fontSize: 8.sp,
                    color: textColors,
                    fontFamily: "SFProMedium",
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
