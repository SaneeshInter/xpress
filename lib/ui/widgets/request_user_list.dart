import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/AppColors.dart';
import '../../Constants/strings.dart';

import '../../model/manager_view_request.dart';
import '../../utils/utils.dart';
import 'buttons/view_button.dart';

class RequestuserListWidget extends StatelessWidget {
  final Function onTapBooking;
  final Function onTapMap;
  final Function onTapCall;
  final Function onTapView;
  final JobRequestDetails item;

  const RequestuserListWidget({
    Key? key,
    required this.item,
    required this.onTapView,
    required this.onTapBooking,
    required this.onTapCall,
    required this.onTapMap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Card(
        elevation: 0.0,
        child: Container(
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

                  CircleAvatar(
                    backgroundColor: appColorPrimary,
                    radius: 28,
                    child: Text(
                        (item.userName!.length>1)? item.userName!.substring(0, 1):"A",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.userName!,
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          item.status!,
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 120)),
                        Row(
                          children: [
                            Text(
                              "${Txt.date}: ${getStringFromDate(getDateFromString(item.date!,"yyyy-MM-dd HH:mm"),"dd-MM-yyyy hh:mm a")}",

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (item.status != "Rejected" &&
                          item.status != "Accepted"
                  //  && item.status != "Completed"
                      )
                        ViewButton(
                          label:Txt.accept,
                          onPressed: () {
                            onTapBooking(item);
                          },
                          key: null,
                        ),

                    ],
                  )
                ]),
                //  SizedBox(height: screenHeight(context, dividedBy: 120)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
