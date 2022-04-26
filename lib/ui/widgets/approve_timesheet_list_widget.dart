import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/widgets/buttons/delete_button.dart';

import '../../model/manager_timesheet.dart';
import '../../utils/utils.dart';
import '../manager/home/time_sheet_details.dart';
import 'buttons/build_button.dart';
import 'buttons/view_button.dart';

class TimeSheetApproveListWidget extends StatefulWidget {
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
  _TimeSheetApproveState createState() => _TimeSheetApproveState();
}

class _TimeSheetApproveState extends State<TimeSheetApproveListWidget> {
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
                  widget.items.firstName!,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: screenHeight(context, dividedBy: 120)),
                Row(
                  children: [
                    Text(
                      "Date : " + widget.items.date!,
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
            Row(
              children: [
                BuildButton(
                  label: "Approve Timesheets",
                  onPressed: widget.onTapMap,
                  key: null,
                ),
                SizedBox(width: screenWidth(context, dividedBy: 40)),
                DeleteButton(
                  label: "View Timesheets",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ManagerTimeSheetDetails(
                                item: widget.items,
                              )),
                    );
                    widget.onTapView(widget.items);
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
