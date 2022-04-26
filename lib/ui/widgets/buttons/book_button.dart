import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
class BookButton extends StatefulWidget {
  final Function onPressed;
  final String label;
  const BookButton({Key? key, required this.onPressed, required this.label}) : super(key: key);

  @override
  _BookButtonState createState() => _BookButtonState();
}

class _BookButtonState extends State<BookButton> {
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
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 24),
            vertical: screenHeight(context, dividedBy: 90)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  tapped == false ? Constants.colors[6] : Colors.grey.shade300,
                  tapped == false ? Constants.colors[5] : Colors.grey.shade300,
                ]),
            color: Constants.colors[3],
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          widget.label,
          style: TextStyle(
              fontSize: 8.5.sp,
              color: tapped == false ? Colors.white : Colors.black,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
