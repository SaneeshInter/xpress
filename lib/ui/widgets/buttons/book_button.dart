import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class BookButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final bool isEnabled;
  const BookButton({Key? key, required this.onPressed, required this.label, this.isEnabled=false,}) : super(key: key);

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
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 24),
            vertical: screenHeight(context, dividedBy: 90)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  !isEnabled? Constants.colors[6] : Colors.grey.shade300,
                  !isEnabled? Constants.colors[5] : Colors.grey.shade300,
                ]),
            color: Constants.colors[3],
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 8.5.sp,
              color: !isEnabled ? Colors.white : Colors.black,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}



