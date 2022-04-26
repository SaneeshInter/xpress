import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
class DeleteButton extends StatefulWidget {
  final Function onPressed;
  final String label;
  const DeleteButton({Key? key, required this.onPressed, required this.label}) : super(key: key);

  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
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
                  tapped == false ? Constants.colors[17]: Constants.colors[17],
                  tapped == false ? Constants.colors[17]: Constants.colors[17],
                ]),
            color: Constants.colors[0],
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          widget.label,
          style: TextStyle(
              fontSize: 8.5.sp,
              color: tapped == false ?
              Constants.colors[18] : Constants.colors[18],

              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
