import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';

class ShiftDetailCard extends StatelessWidget {
  ShiftDetailCard({
    Key? key,
    required this.label,
    required this.hint,
    required this.height,
    required this.svgPath,
    this.svgColor = redColor,
    this.labelColor = Colors.black,
    this.hintColor = Colors.grey,
  }) : super(key: key);
  String label;
  String hint;
  double height;
  String svgPath;
  Color svgColor;
  Color labelColor;
  Color hintColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: SizedBox(
        width: height,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Constants.colors[12],
              child: SvgPicture.asset(
                svgPath,
                height: 5.w,
                width: 5.w,
                color: Constants.colors[0],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              AutoSizeText(
                label,
                maxLines: 1,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 16.sp,
                  fontFamily: "SFProMedium",
                ),
                textAlign: TextAlign.left,
              ),
              AutoSizeText(
                hint,
                maxLines: 1,
                style: TextStyle(
                  color: hintColor,
                  fontSize: 10.sp,
                  fontFamily: "SFProMedium",
                ),
                textAlign: TextAlign.right,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
