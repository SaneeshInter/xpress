import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';


class CustomRow extends StatelessWidget {
  final Function onPressed;
  final String label;
  final String asset;
  final Color textColors;
  final double size;

   CustomRow({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.asset,
    required this.textColors,
    required this.size,
  }) : super(key: key);

  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
        // setState(() {
        //   tapped = true;
        // });
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 16, left: 10),
        child: Row(
          children: [
            SvgPicture.asset(
              asset,
              width: MediaQuery.of(context).size.width * 0.03,
              height: MediaQuery.of(context).size.width * 0.03,
              // color: widget.textColors,
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 70.w,
              // width: screenWidth(context, dividedBy: 3.5),
              child: AutoSizeText.rich(
                TextSpan(
                  text:label,
                  style: TextStyle(
                    //fontSize: 11,
                      color:textColors,
                      fontFamily: "SFProMedium",
                      fontWeight: FontWeight.w600),
                ),
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


