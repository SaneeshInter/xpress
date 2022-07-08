import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class HomeButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final String asset;
  final Color textColors;
  final Color color1;
  final Color color2;

   HomeButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.asset,
      required this.textColors,
      required this.color1,
      required this.color2})
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
            horizontal: screenWidth(context, dividedBy: 40),
            vertical: screenHeight(context, dividedBy: 80)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  color1,
                  color2,
                ],
            ),
            color: Constants.colors[3],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            CircleAvatar(
              minRadius: MediaQuery.of(context).size.width * 0.052,
              maxRadius: MediaQuery.of(context).size.width * 0.052,
              backgroundColor: color2,
              child: SvgPicture.asset(
                asset,
                width: MediaQuery.of(context).size.width * 0.04,
                height: MediaQuery.of(context).size.width * 0.04,
                color: textColors,
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: screenWidth(context, dividedBy: 3.5),
              child: AutoSizeText.rich(
                TextSpan(
                  text: label,
                  style: TextStyle(
                      fontSize: 16,
                      color: textColors,
                      fontFamily: "SFProMedium",
                      fontWeight: FontWeight.w600),
                ),
                minFontSize: 0,
                stepGranularity: 0.1,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
