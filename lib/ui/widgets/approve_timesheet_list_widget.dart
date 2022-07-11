import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/strings.dart';

import '../../model/manager_timesheet.dart';
import '../../utils/utils.dart';
import 'buttons/build_button.dart';
import 'buttons/view_button.dart';

class TimeSheetApproveListWidget extends StatelessWidget {
  final TimeSheetInfo items;
  final Function onTapBooking;
  final Function onTapMap;
  final Function onTapCall;
  final Function onTapView;

  const TimeSheetApproveListWidget({
    Key? key,
    required this.items,
    required this.onTapView,
    required this.onTapBooking,
    required this.onTapCall,
    required this.onTapMap,
  }) : super(key: key);


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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  items.firstName!,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: screenHeight(context, dividedBy: 120)),
                Row(
                  children: [
                    Text(
                      "${Txt.date}: ${getStringFromDate(getDateFromString(items.date!,"yyyy-MM-dd HH:mm:ss"),"dd-MM-yyyy hh:mm a")}",
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
                    label: items.userType!,
                    onPressed: () {},
                    key: null,
                  )
                ],   
              )
            ]),
            SizedBox(height: screenHeight(context, dividedBy: 120)),
            Row(
              children: [

                BuildButton(
                  label: Txt.view_timesheets,
                  onPressed: () {
                    onTapView(items);
                  },
                  key: null,
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: screenHeight(context, dividedBy: 120)),
          ],
        ),
      ),
    );
  }
}
