import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/strings.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class AddTimeSheetAlertBox extends StatelessWidget {
  final String date;

  AddTimeSheetAlertBox({Key? key, required this.date}) : super(key: key);

  TextEditingController email = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, dividedBy: 1),
      padding: EdgeInsets.symmetric(
          // horizontal: screenWidth(context, dividedBy: 25),
          vertical: screenHeight(context, dividedBy: 70)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(-2, 2),
                blurRadius: 2,
                spreadRadius: 2,
                color: Constants.colors[7].withOpacity(0.15))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100.w,
            height: 5.h,
            color: Colors.green,
            alignment: Alignment.centerLeft,
            child: Text(
              "Add Timesheet",
              style: TextStyle(
                  fontSize: 17,
                  color: Constants.colors[0],
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: screenHeight(context, dividedBy: 70)),
          Row(
            children: [
              Expanded(

                child: Column(
                  children: [
                    Text(
                      "Start Time " + date,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          color: Constants.colors[7],
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      child: textInputFileds(
                          controlr: email,
                          hintText: Txt.email,
                          keyboadType: TextInputType.emailAddress,
                          isPwd: false),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "End Time " + date,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Constants.colors[7],
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      child: textInputFileds(
                          controlr: email,
                          hintText: Txt.email,
                          keyboadType: TextInputType.emailAddress,
                          isPwd: false),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight(context, dividedBy: 40)),
        ],
      ),
    );
  }

  Widget textInputFileds(
      {required String hintText,
      validator,
      required TextEditingController controlr,
      required TextInputType keyboadType,
      required bool isPwd}) {
    return Container(
      // height: 100,

      padding: EdgeInsets.only(top: 0, left: 20, right: 20),
      child: TextFormField(
        cursorWidth: 1.0,
        controller: controlr,
        validator: validator,
        textAlign: TextAlign.justify,
        obscureText: isPwd,
        maxLines: 1,
        keyboardType: keyboadType,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            labelStyle: TextStyle(
                fontFamily: 'SFProRegular',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.grey),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: 'SFProRegular',
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.grey)),
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            decoration: TextDecoration.none,
            color: Colors.brown),
      ),
    );
  }
}
