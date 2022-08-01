import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/strings.dart';

import '../../model/user_get_timesheet.dart';
import '../../utils/utils.dart';
import '../Widgets/buttons/view_button.dart';

class UserTimeSheetListWidget extends StatelessWidget {
  final TimeSheetInfo items;
  final Function onTapBooking;
  final Function onTapMap;
  final Function onTapCall;
  final Function onTapView;
  final Function onCheckBoxClicked;

   UserTimeSheetListWidget({
    Key? key,
    required this.items,
    required this.onTapView,
    required this.onTapBooking,
    required this.onTapCall,
    required this.onTapMap,
    required this.onCheckBoxClicked,
  }) : super(key: key);

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapView(items);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
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
                    "${items.firstName?.toUpperCase()} ${items.lastName?.toUpperCase()}",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 120)),
                  Row(
                    children: [
                      Text(
                        "${Txt.date}: ${getStringFromDate(getDateFromString(items.date!,"yyyy-MM-dd"),"dd-MM-yyyy")}",
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
                const Spacer(),
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
            ],
          ),
        ),
      ),
    );
  }
}

