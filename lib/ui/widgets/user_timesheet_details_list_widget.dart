import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../model/user_time_sheet_details_respo.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class UserTimeSheetDetailsListWidget extends StatefulWidget {
  final TimeSheetDetails items;
  final Function onTapBooking;
  final Function onTapMap;
  final Function onTapCall;
  final Function onTapView;
  final Function onCheckBoxClicked;
  final Function onRejectCheckBoxClicked;

  const UserTimeSheetDetailsListWidget({
    Key? key,
    required this.items,
    required this.onTapView,
    required this.onTapBooking,
    required this.onTapCall,
    required this.onTapMap,
    required this.onCheckBoxClicked,
    required this.onRejectCheckBoxClicked,
  }) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<UserTimeSheetDetailsListWidget> {
  bool isChecked = false;
  bool isCheckedReject = false;
  TextEditingController jobDescri = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
          children: [
            Row(children: [
              Container(
                width: 35.w,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            widget.items.firstName!,
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
                              "On: " + widget.items.date!,
                              style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Constants.colors[13],
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              "From " +
                                  widget.items.timeFrom! +
                                  " To " +
                                  widget.items.timeTo!,
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
              ),
            ]),
            SizedBox(height: screenHeight(context, dividedBy: 120)),
          ],
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