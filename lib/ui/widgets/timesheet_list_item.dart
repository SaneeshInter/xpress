import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/strings.dart';
import '../../model/user_complted_shift.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';

class TimeSheetListWidget extends StatefulWidget {
  final Items items;
  final Function onTapBooking;
  final Function onTapMap;
  final Function onTapCall;
  final Function onTapView;
  final Function onCheckBoxClicked;

  const TimeSheetListWidget({
    Key? key,
    required this.items,
    required this.onTapView,
    required this.onTapBooking,
    required this.onTapCall,
    required this.onTapMap,
    required this.onCheckBoxClicked,
  }) : super(key: key);

  @override
  _TimeSheetListState createState() => _TimeSheetListState();
}

class _TimeSheetListState extends State<TimeSheetListWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, dividedBy: 1),
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context, dividedBy: 25),
          vertical: screenHeight(context, dividedBy: 70)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(children: [
            Container(
              alignment: Alignment.topLeft,
              transformAlignment: Alignment.topLeft,
              child: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {

                  setState(() {
                    isChecked = value!;
                  });

                  widget.onCheckBoxClicked(widget.items.rowId.toString(), value);
                },
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  AutoSizeText(
                    Txt.at+ widget.items.hospital!,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    style: TextStyle(
                        color: Constants.colors[14],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: "SFProBold"),
                  ),
                ],
              ),
              SizedBox(height: screenHeight(context, dividedBy: 120)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      Txt.on_dot + widget.items.date!,
                      style: TextStyle(
                          fontSize: 9.sp,
                          color: Constants.colors[13],
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      Txt.from+
                         convert24hrTo12hr(widget.items.timeFrom!, context)  +
                          Txt.to+
                       convert24hrTo12hr(  widget.items.timeTo!, context) ,
                      style: TextStyle(
                          fontSize: 9.sp,
                          color: Constants.colors[13],
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight(context, dividedBy: 120)),
              if (null != widget.items.userType)
                Text(
                  widget.items.userType!,
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: Constants.colors[3],
                      fontWeight: FontWeight.w500),
                ),
            ]),
            Spacer(),
          ]),
          SizedBox(height: screenHeight(context, dividedBy: 120)),
        ],
      ),
    );
  }
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Constants.colors[3];
}
