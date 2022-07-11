import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';

import '../../utils/utils.dart';

class TextInputFileds extends StatefulWidget {
  String hintText;
  dynamic validator;
  TextEditingController controlr;
  TextInputType keyboadType;
  bool isPwd;
  Function onTapDate;
  Function onChange;
  TextInputFileds(
      {Key? key,
      required this.hintText,
      this.validator,
      required this.controlr,
      required this.keyboadType,
      required this.isPwd,
      required this.onChange,
      required this.onTapDate}) : super(key: key);

  @override
  _BuildButtonState createState() => _BuildButtonState();
}
class _BuildButtonState extends State<TextInputFileds> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: SizedBox(
      // height: 7.3.h,
      width: screenWidth(context, dividedBy: 1),
      child: TextFormField(
        cursorWidth: 1.0,
        onTap: () {
          widget.onTapDate();
        },
        controller: widget.controlr,
        validator: widget.validator,
        textAlign: TextAlign.justify,
        obscureText: widget.isPwd,
        maxLines: 1,
        onChanged: (value) {

        },
        keyboardType: widget.keyboadType,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
            errorBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Constants.colors[28], width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Constants.colors[28], width: 1),
            ),
            labelStyle: TextStyle(
                fontFamily: 'SFProRegular',
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
              color: Colors.grey),
            enabledBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Constants.colors[28], width: 1),
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Constants.colors[28], width: 1),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontFamily: 'SFProRegular',
                fontWeight: FontWeight.normal,
                fontSize: 10.sp,
                color: Constants.colors[29])),
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
            decoration: TextDecoration.none,
          color: Constants.colors[29],),
      ),
    ));
  }
}
