import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class HomeButton extends StatefulWidget {
  final Function onPressed;
  final String label;
  final String asset;
  final Color textColors;
  final Color color1;
  final Color color2;

  const HomeButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.asset,
      required this.textColors,
      required this.color1,
      required this.color2})
      : super(key: key);

  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
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
            horizontal: screenWidth(context, dividedBy: 40),
            vertical: screenHeight(context, dividedBy: 80)),
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
        child: Row(
          children: [
            CircleAvatar(
              minRadius: MediaQuery.of(context).size.width * 0.052,
              maxRadius: MediaQuery.of(context).size.width * 0.052,
              backgroundColor: widget.color2,
              child: SvgPicture.asset(
                widget.asset,
                width: MediaQuery.of(context).size.width * 0.04,
                height: MediaQuery.of(context).size.width * 0.04,
                color: widget.textColors,
              ),
            ),
            SizedBox(width: 6),
            Container(
              width: screenWidth(context, dividedBy: 3.5),
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
          ],
        ),
      ),
    );
  }
}
