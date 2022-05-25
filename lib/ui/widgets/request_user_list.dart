import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../model/manager_view_request.dart';
import '../../utils/utils.dart';
import 'buttons/view_button.dart';

class RequestuserListWidget extends StatefulWidget {
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
  _RequestuserListState createState() => _RequestuserListState();
}

class _RequestuserListState extends State<RequestuserListWidget> {
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          'https://i.imgur.com/PJpPD6S.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.userName!,
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.item.status!,
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 120)),
                        Row(
                          children: [
                            Text(
                              widget.item.date!,
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
                      if (widget.item.status != "Rejected" &&
                          widget.item.status != "Accepted")
                        ViewButton(
                          label: "Accept",
                          onPressed: () {
                            widget.onTapBooking(widget.item);
                          },
                          key: null,
                        ),
                      // Column(
                      //   children: [
                      //     if (widget.item.status == "Accepted")
                      //       ViewButton(
                      //         label: "Reject",
                      //         onPressed: () {
                      //           widget.onTapBooking(widget.item);
                      //         },
                      //         key: null,
                      //       ),
                      //   ],
                      // ),
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
