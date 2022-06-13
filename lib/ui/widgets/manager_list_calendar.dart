import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/strings.dart';

//import '../model/viewbooking_response.dart';
import '../../model/common/manager_shift.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../Widgets/buttons/build_button.dart';
import '../Widgets/buttons/view_button.dart';
import '../manager/home/shift_detail_manager.dart';
import 'buttons/delete_button.dart';

class ManagerListCalenderWidget extends StatefulWidget {
  final Items items;
  final Function onTapEdit;
  final Function onTapDelete;
  final Function onTapViewMap;
  final Function onTapView;
  final Function onTapBook;

  const ManagerListCalenderWidget({
    Key? key,
    required this.items,
    required this.onTapView,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.onTapViewMap,
    required this.onTapBook,
  }) : super(key: key);

  @override
  _HomePageCardStates createState() => _HomePageCardStates();
}

class _HomePageCardStates extends State<ManagerListCalenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Badge(
                      padding: EdgeInsets.all(4),
                      position: const BadgePosition(bottom: 10, start: 30),
                      badgeColor: Colors.green,
                      badgeContent: Text(
                        widget.items.requested_count.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      "Request",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              SizedBox(
                                width: 1.w,
                              ),
                            ],
                          ),
                          SizedBox(
                              height: screenHeight(context, dividedBy: 120)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1.0),
                                child: Text(
                                  Txt.on_dot + widget.items.date!,
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
                                     convert24hrTo12hr(widget.items.timeFrom!, context) +
                                      Txt.to +
                                     convert24hrTo12hr( widget.items.timeTo!, context),
                                  style: TextStyle(
                                      fontSize: 9.sp,
                                      color: Constants.colors[13],
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: screenHeight(context, dividedBy: 120)),
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
                                  builder: (context) =>
                                      ShiftDetailManagerScreen(
                                        shiftId: widget.items.rowId.toString(),
                                      )),
                            );
                          },
                          key: null,
                        ),
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
                      // Spacer(),Container(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: screenWidth(context, dividedBy: 50),
                      //       vertical: screenHeight(context, dividedBy: 130)),
                      //   decoration: BoxDecoration(
                      //       gradient: LinearGradient(
                      //           begin: Alignment.centerLeft,
                      //           end: Alignment.centerRight,
                      //           colors: [
                      //             Constants.colors[3],
                      //             Constants.colors[4],
                      //           ]),
                      //       color: Constants.colors[3],
                      //       borderRadius: BorderRadius.circular(5)),
                      //   child: Text(widget.items.requested_count.toString(),style: TextStyle(color: Colors.white,),),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
