import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/Constants/strings.dart';

import '../../model/user_get_timesheet.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../Widgets/buttons/view_button.dart';

class UserTimeSheetListWidget extends StatefulWidget {
  final TimeSheetInfo items;
  final Function onTapBooking;
  final Function onTapMap;
  final Function onTapCall;
  final Function onTapView;
  final Function onCheckBoxClicked;

  const UserTimeSheetListWidget({
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

class _TimeSheetListState extends State<UserTimeSheetListWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTapView(widget.items);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: screenWidth(context, dividedBy: 1),
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 25),
              vertical: screenHeight(context, dividedBy: 70)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    widget.items.firstName! + " " +widget.items.lastName!,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 120)),
                  Row(
                    children: [
                      Text(
                      Txt.date_dot + widget.items.date!,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 2.w),
                    ],
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 120)),
                ]),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ViewButton(
                      label: widget.items.userType!,
                      onPressed: () {},
                      key: null,
                    )
                  ],
                )
              ]),
              SizedBox(height: screenHeight(context, dividedBy: 120)),
            ],
          ),
        ),
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
