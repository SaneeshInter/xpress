import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/widgets/buttons/call_button.dart';

import '../../blocs/shift_list_bloc.dart';
import '../../model/user_shift_calender.dart';
import '../../utils/constants.dart';
import '../../utils/network_utils.dart';
import '../../utils/utils.dart';
import 'action_alert_dialoge.dart';
import 'buttons/book_button.dart';

class ShiftListCalenderWidget extends StatefulWidget {
  final Items items;
  final String token;
  final Function onTapEdit;
  final Function onTapDelete;
  final Function onTapViewMap;
  final Function onTapView;
  final Function onTapBook;

  const ShiftListCalenderWidget({
    Key? key,
    required this.items,
    required this.token,
    required this.onTapView,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.onTapViewMap,
    required this.onTapBook,
  }) : super(key: key);

  @override
  _HomePageCardState createState() => _HomePageCardState();
}

class _HomePageCardState extends State<ShiftListCalenderWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTapView(widget.items);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ShiftDetailScreen(shift_id: widget.items.rowId.toString(),)),
        // );
      },
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
                if (null != widget.items.hospital)
                  AutoSizeText(
                    widget.items.hospital!,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                SizedBox(height: screenHeight(context, dividedBy: 120)),
                Text(
                  "Date " +
                      widget.items.date!,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: screenHeight(context, dividedBy: 120)),
                if (null != widget.items.timeFrom &&
                    null != widget.items.timeTo)
                  Text(
                    "From " +
                        widget.items.timeFrom! +
                        " To " +
                        widget.items.timeTo!,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                SizedBox(height: screenHeight(context, dividedBy: 120)),
                if (null != widget.items.type)
                  Text(
                    "" + widget.items.type!,
                    style: TextStyle(
                        fontSize: 13,
                        color: Constants.colors[3],
                        fontWeight: FontWeight.w500),
                  ),
              ]),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth(context, dividedBy: 40),
                      ),
                      if (null != widget.items.price &&
                          widget.items.type == "Premium")
                        Text(
                          "\€" + widget.items.price.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Constants.colors[3],
                              fontWeight: FontWeight.w700),
                        )
                    ],
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 70)),
                ],
              )
            ]),
            SizedBox(height: screenHeight(context, dividedBy: 120)),
            Row(
              children: [
                BookButton(
                  label: "Request Now",
                  onPressed: () {
                    widget.onTapBook(widget.items);
                    print("Tapped");
                  },
                  key: null,
                ),
                SizedBox(width: screenWidth(context, dividedBy: 40)),
                Spacer(),
                if (widget.items.type == "Premium")
                  Container(
                      width: 7.w,
                      height: 7.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Constants.colors[8]),
                      child: Center(
                          child: SvgPicture.asset("assets/images/icon/rank.svg",
                              width: 6.w, height: 6.w, fit: BoxFit.cover))),
                SizedBox(width: screenWidth(context, dividedBy: 40)),
                CallButtons(
                  onPressed: () {
                    dialCall("86962876916");
                  },
                ),
              ],
            ),
            SizedBox(height: screenHeight(context, dividedBy: 120)),
          ],
        ),
      ),
    );
  }

  void showActionAlert(
    context, {
    required String tittle,
    required String message,
    required Items item,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
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
                  tittle: tittle,
                  message: message,
                  positiveText: "REQUEST NOW",
                  onPositvieClick: (item) {
// widget.onTapBook(item);
                    if (item is Items) {
                      Items data = item;
                      bloc.fetchuserJobRequest(
                          widget.token, data.rowId.toString());
                    }
                  },
                  onNegativeClick: () {})),
        );
      },
    );
  }
}
