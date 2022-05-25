import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/model/user_view_request_response.dart';

import '../../ui/Widgets/buttons/view_button.dart';
import '../../ui/user/detail/shift_detail.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'buttons/book_button.dart';

class MyBookingListWidget extends StatefulWidget {
  final Items items;
  final int position;
  final Function onTapBooking;
  final Function onTapMap;
  final Function onTapCall;
  final Function onTapCancel;
  final Function onTapView;

  const MyBookingListWidget(
      {Key? key,
      required this.items,
      required this.onTapView,
      required this.onTapBooking,
      required this.onTapCall,
      required this.onTapMap,
      required this.onTapCancel,
      required this.position})
      : super(key: key);

  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBookingListWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShiftDetailScreen(
                    shift_id: widget.items.jobId.toString(),
                    isCompleted: true,
                  )),
        );
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70.w,
                          child: AutoSizeText.rich(
                            TextSpan(
                              text: widget.items.jobTitle,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            minFontSize: 0,
                            stepGranularity: 0.3,
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 180)),
                        Text(
                          "On: " + widget.items.date!,
                          style: TextStyle(
                              fontSize: 9.sp,
                              color: Constants.colors[13],
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 180)),
                        Text(
                          "From " +
                              widget.items.timeFrom! +
                              " To " +
                              widget.items.timeTo!,
                          style: TextStyle(
                              fontSize: 9.sp,
                              color: Constants.colors[13],
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 180)),
                        AutoSizeText.rich(
                          TextSpan(
                            text: "At : " + widget.items.hospital!,
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: Constants.colors[4],
                                fontWeight: FontWeight.w700),
                          ),
                          minFontSize: 0,
                          stepGranularity: 0.3,
                          maxLines: 3,
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 180)),
                        // Text(
                        //   widget.items.userType!,
                        //   style: TextStyle(
                        //       fontSize: 9.5.sp,
                        //       color: Constants.colors[3],
                        //       fontWeight: FontWeight.w500),
                        // ),
                      ]),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ViewButton(
                        label: "view",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShiftDetailScreen(
                                      shift_id: widget.items.jobId.toString(),
                                      isCompleted: true,
                                    )),
                          );
                        },
                        key: null,
                      )
                    ],
                  )
                ]),
                SizedBox(height: screenHeight(context, dividedBy: 180)),
                buttonList(context, widget)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buttonList(BuildContext context, MyBookingListWidget widget) {
  if (widget.position == 1) {
    return Row(
      children: [
        BookButton(
          label: "Add Timesheet",
          onPressed: () {
            widget.onTapView(widget.items);
            print("Cards booking");
          },
          key: null,
        ),
        Spacer(),
      ],
    );
  } else {
    return Row(
      children: [
        // BuildButton(
        //   label: "View Shift",
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => ShiftDetailScreen(
        //                 shift_id: widget.items.jobId.toString(),
        //               )),
        //     );
        //     widget.onTapMap();
        //     print("Cards booking");
        //   },
        //   key: null,
        // ),

        if (widget.items.status == "Accepted" || widget.items.status == "Pending")
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BookButton(
                label: "Cancel Request",
                onPressed: () {
                  widget.onTapCancel();
                  print("Cards booking");
                },
                key: null,
              ),
              SizedBox(width: screenWidth(context, dividedBy: 40)),
            ],
          ),


        if (widget.items.status == "Accepted")
          BookButton(
            label: "Add Working Hours",
            onPressed: () {
              widget.onTapView(widget.items);
              print("Cards booking");
            },
            key: null,
          ),

        if (widget.items.status == "Completed")
          BookButton(
            label: "Add Working Hours",
            onPressed: () {
              widget.onTapView(widget.items);
              print("Cards booking");
            },
            key: null,
          ),



      ],
    );
  }
}
