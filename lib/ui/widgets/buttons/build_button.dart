import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';


class BuildButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  const BuildButton({Key? key, required this.onPressed, required this.label}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 2.w),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Constants.colors[3],
                  Constants.colors[4],
                ]),
            color: Constants.colors[3],
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 8.5.sp,
              color: Constants.colors[0],fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
