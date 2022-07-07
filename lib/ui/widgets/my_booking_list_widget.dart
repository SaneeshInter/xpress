
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/widgets/remaining_timer_widget.dart';

import '../../Constants/strings.dart';
import '../../model/user_view_request_response.dart';
import '../../ui/Widgets/buttons/view_button.dart';
import '../../ui/user/detail/shift_detail.dart';
import '../../utils/constants.dart';
import '../../utils/network_utils.dart';
import '../../utils/utils.dart';
import 'action_alert_dialoge.dart';
import 'buttons/book_button.dart';
import 'buttons/call_button.dart';

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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
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
                            "${Txt.date}: ${getStringFromDate(getDateFromString(widget.items.date!,"yyyy-MM-dd"),"dd-MM-yyyy")}",
                            style: TextStyle(
                                fontSize: 9.sp,
                                color: Constants.colors[13],
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: screenHeight(context, dividedBy: 180)),
                          Text(
                            Txt.from +
                                convert24hrTo12hr(
                                  widget.items.timeFrom!,
                                ) +
                                Txt.to +
                                convert24hrTo12hr(widget.items.timeTo!),
                            style: TextStyle(
                                fontSize: 9.sp,
                                color: Constants.colors[13],
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: screenHeight(context, dividedBy: 180)),
                          AutoSizeText.rich(
                            TextSpan(
                              text: Txt.at + widget.items.hospital!,
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
                        ]),
                    SizedBox(height: screenHeight(context, dividedBy: 180)),
                    buttonList(context, widget)
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ViewButton(
                          label: Txt.view,
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
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 80)),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context, dividedBy: 200),
                              vertical: screenHeight(context, dividedBy: 200)),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Constants
                                      .colors[9],Constants
                                      .colors[9]]),
                              color: Constants.colors[3],
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: AutoSizeText(
                              widget.items.status!,
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: Constants
                                      .colors[11],
                                  fontFamily: "SFProMedium",
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 80)),
                        if(widget.items.status == "Accepted" ||
                            widget.items.status == "Pending") RemainingTimerWidget(date: getDateFromString('${widget.items.date!} ${widget.items.timeFrom}',"yyyy-MM-dd HH:mm"),),
                      ],),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buttonList(BuildContext context, MyBookingListWidget widget) {
int totalWorkHours = int.parse(getDiffrenceBetweenTwoDates(getDateFromString('${widget.items.date!} ${widget.items.timeFrom}',"yyyy-MM-dd HH:mm"), DateTime.now()).split(':')[0]);
int afterWorkHours = int.parse(getDiffrenceBetweenTwoDates(getDateFromString('${widget.items.date!} ${widget.items.timeTo}',"yyyy-MM-dd HH:mm"), DateTime.now()).split(':')[0]);
  debugPrint("widget.items.workingTimeStatus");
  debugPrint(widget.items.workingTimeStatus.toString());
  if (widget.position == 1) {
    return Row(
      children: [
        BookButton(
          label: Txt.add_time_sheet,
          onPressed: () {
            widget.onTapView(widget.items);
            debugPrint("Cards booking");
          },
          key: null,
        ),
        const Spacer(),
      ],
    );
  } else {
    return Row(
      children: [
        if (widget.items.status == "Accepted" ||
            widget.items.status == "Pending")
          if (widget.items.workingTimeStatus == 0)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              totalWorkHours>16?
                BookButton(
                  label: Txt.cancel_req,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        Future.delayed(const Duration(seconds: 2), () {
                          // Navigator.of(context).pop(true);
                        });
                        return Center(
                          child: AlertDialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth(context, dividedBy: 30),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              content: ActionAlertBox(
                                  tittle: "Cancel",
                                  message:
                                      "Are you sure you want to cancel the request?",
                                  positiveText: "YES",
                                  negativeText: "NO",
                                  onPositvieClick: () {
                                    widget.onTapCancel(widget.items);
                                    Navigator.of(context).pop(true);
                                  },
                                  onNegativeClick: () {
                                    Navigator.of(context).pop(true);
                                  })),
                        );
                      },
                    );

                    print("Cards booking");
                  },
                  key: null,
                ):
              BookButton(
                label: "Call for Cancel",
                onPressed: () => dialCall(Txt.contactNumber),
                key: null,
              )
                ,

                SizedBox(width: screenWidth(context, dividedBy: 40)),
              ],
            ),
        if (widget.items.status == "Accepted" &&
            widget.items.workingTimeStatus == 0)
          if(afterWorkHours<0) BookButton(
            label: Txt.add_wrkng_hrs,
            onPressed: () {
              widget.onTapView(widget.items);
              print("Cards booking");
            },
            key: null,
          ),

        //
        if (widget.items.status == "Completed" &&
            widget.items.workingTimeStatus == 0)
          BookButton(
            label: Txt.add_wrkng_hrs,
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
