import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/model/viewbooking_response.dart';

import '../../../Constants/strings.dart';
import '../../../model/common/manager_shift.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../manager/home/shift_detail_manager.dart';
import '../buttons/build_button.dart';
import '../buttons/delete_button.dart';
import '../buttons/view_button.dart';

class ManagerBookingListWidget extends StatefulWidget {
  final Items items;
  final Function onTapEdit;
  final Function onTapDelete;
  final Function onTapItem;
  final Function onTapView;

  const ManagerBookingListWidget({
    Key? key,
    required this.items,
    required this.onTapView,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.onTapItem,
  }) : super(key: key);

  @override
  _HomePageCardState createState() => _HomePageCardState();
}

class _HomePageCardState extends State<ManagerBookingListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      AutoSizeText(
                        Txt.at + widget.items.hospital!,
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
                          Txt.on + widget.items.date!,
                          style: TextStyle(
                              fontSize: 9.sp,
                              color: Constants.colors[13],
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          Txt.from +
                             convert24hrTo12hr(widget.items.timeFrom!, context)  +
                              Txt.to +
                            convert24hrTo12hr( widget.items.timeTo!, context) ,
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
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ViewButton(
                      label: Txt.view,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShiftDetailManagerScreen(
                                    shift_id: widget.items.rowId.toString(),
                                  )),
                        );
                      },
                      key: null,
                    )
                  ],
                )
              ]),
              SizedBox(height: screenHeight(context, dividedBy: 120)),
              Row(
                children: [
                  BuildButton(
                    label: Txt.edit,
                    onPressed: () {
                      widget.onTapEdit(widget.items);
                    },
                    key: null,
                  ),
                  SizedBox(width: screenWidth(context, dividedBy: 40)),
                  DeleteButton(
                    label: Txt.delete,
                    onPressed: () {
                      widget.onTapDelete(widget.items.rowId);
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
      ),
    );
  }
}
