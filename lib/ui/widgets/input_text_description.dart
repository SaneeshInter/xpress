import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';

class TextInputFiledDescription extends StatefulWidget {
  String hintText;
  dynamic validator;
  TextEditingController controlr;
  TextInputType keyboadType;
  bool isPwd;
  Function onTapDate;
  TextInputFiledDescription(
      {Key? key,
      required this.hintText,
      this.validator,
      required this.controlr,
      required this.keyboadType,
      required this.isPwd,
      required this.onTapDate});

  @override
  _BuildButtonState createState() => _BuildButtonState();
}
class _BuildButtonState extends State<TextInputFiledDescription> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      height: 8.h,
      width: screenWidth(context, dividedBy: 1),
      child: TextFormField(
        cursorWidth: 1.0,
        onTap: () {
          print("ontap");
          widget.onTapDate();
        },
        controller: widget.controlr,
        validator: widget.validator,
        textAlign: TextAlign.justify,
        obscureText: widget.isPwd,
        maxLines: 10,
        keyboardType: widget.keyboadType,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            labelStyle: TextStyle(
                fontFamily: 'SFProRegular',
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                color: Colors.grey),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontFamily: 'SFProRegular',
                fontWeight: FontWeight.normal,
                fontSize: 10.sp,
                color: Colors.grey)),
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
            decoration: TextDecoration.none,
            color: Colors.brown),
      ),
    ));
  }
}
