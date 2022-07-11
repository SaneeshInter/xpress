import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/strings.dart';
import '../../model/user_shift_calender.dart';
import '../../ui/widgets/buttons/call_button.dart';
import '../../utils/constants.dart';
import '../../utils/network_utils.dart';
import '../../utils/utils.dart';
import 'buttons/book_button.dart';

class ShiftListCalenderWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    debugPrint("widget.items.if_requested");
    debugPrint(items.if_requested.toString());
    return GestureDetector(
      onTap: () {
        onTapView(items);
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
                if (null != items.hospital)
                  AutoSizeText(
                    items.hospital!,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                SizedBox(height: screenHeight(context, dividedBy: 120)),
                Text(
                 " ${Txt.date}: ${getStringFromDate(getDateFromString(items.date!,"yyyy-MM-dd"),"dd-MM-yyyy")}",
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: screenHeight(context, dividedBy: 120)),
              (items.timeFrom.toString().isEmpty &&
                    items.timeTo.toString().isEmpty)?
                const Text(""):  Text(
                Txt.from +
                    convert24hrTo12hr( items.timeFrom.toString().trim())   +
                    Txt.to +
                    convert24hrTo12hr(items.timeTo.toString().trim()) ,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
                SizedBox(height: screenHeight(context, dividedBy: 120)),
                if (null != items.type)
                  Text(
                    items.type!,
                    style: TextStyle(
                        fontSize: 13,
                        color: Constants.colors[3],
                        fontWeight: FontWeight.w500),
                  ),
              ]),
              const Spacer(),
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
                      if (null != items.price &&
                          items.type == "Premium")
                        Text(
                          "\€${items.price}",
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
                (items.if_requested! == -1)? BookButton(
                    label: Txt.request_now,
                    onPressed: () {
                      onTapBook(items);
                      debugPrint("Tapped");
                    },
                    key: null,
                  ):
                (items.if_requested! == 0)? BookButton(
                    label: Txt.requested,
                  isEnabled: true,
                    onPressed: () {

                      debugPrint("Tapped");
                    },
                    key: null,
                  ):
                (items.if_requested! == 1)?BookButton(
                  label: Txt.accepted,
                  isEnabled: true,
                  onPressed: () {

                    debugPrint("Tapped");
                  },
                  key: null,
                ):
                (items.if_requested! == 2)? BookButton(
                    label: Txt.rejected,
                    isEnabled: true,
                    onPressed: () {
                      // widget.onTapBook(widget.items);
                      debugPrint("Tapped");
                    },
                    key: null,
                  ):
                (items.if_requested! == 3)?BookButton(
                  label: Txt.cancelled,
                  isEnabled: true,
                  onPressed: () {
                    // widget.onTapBook(widget.items);
                    debugPrint("Tapped");
                  },
                  key: null,
                ):
                (items.if_requested! == 4)?BookButton(
                  label: Txt.cancelled,
                  isEnabled: true,
                  onPressed: () {
                    // widget.onTapBook(widget.items);
                    debugPrint("Tapped");
                  },
                  key: null,
                ):
                (items.if_requested! == 5)?BookButton(
                  label: Txt.rejected,
                  isEnabled: true,
                  onPressed: () {
                    // widget.onTapBook(widget.items);
                    debugPrint("Tapped");
                  },
                  key: null,
                ):
                (items.if_requested! == 6)?BookButton(
                  label: Txt.past,
                  isEnabled: true,
                  onPressed: () {
                    // widget.onTapBook(widget.items);
                    debugPrint("Tapped");
                  },
                  key: null,
                ):
                (items.if_requested! == 7)?BookButton(
                  label: Txt.not_attended,
                  isEnabled: true,
                  onPressed: () {
                    // widget.onTapBook(widget.items);
                    debugPrint("Tapped");
                  },
                  key: null,
                ):
                SizedBox(
                  child: Text("${items.if_requested!}"),
                ),
                SizedBox(width: screenWidth(context, dividedBy: 40)),
                Spacer(),
                if (items.type == "Premium")
                  Container(
                      width: 7.w,
                      height: 7.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Constants.colors[8]),
                      child: Center(
                          child: SvgPicture.asset("assets/images/icon/rank.svg",
                              width: 6.w, height: 6.w, fit: BoxFit.cover))),
                SizedBox(width: screenWidth(context, dividedBy: 40)),
                // CallButtons(
                //   onPressed: () {
                //     dialCall();
                //   },
                // ),
                GestureDetector(onTap: ()=>dialCall(Txt.contactNumber),child: Image.asset("assets/images/icon/callgif.gif",width: 45,height: 45,)),
                GestureDetector(onTap: ()=>whatsappCall(),child: Image.asset("assets/images/icon/whatsapp.gif",width: 40,height: 40,)),

              ],
            ),
            SizedBox(height: screenHeight(context, dividedBy: 120)),
          ],
        ),
      ),
    );
  }
}
