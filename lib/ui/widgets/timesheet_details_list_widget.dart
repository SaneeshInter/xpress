import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/strings.dart';

import '../../model/manager_get_time.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../utils/validator.dart';
import 'input_text_description.dart';

class TimeSheetDetailsListWidget extends StatefulWidget {
  final TimeSheetDetails items;
  final Function onTapBooking;
  final Function onCheckBoxClicked;
  final Function textChange;
  final int index;

  const TimeSheetDetailsListWidget({
    Key? key,
    required this.items,
    required this.onTapBooking,
    required this.index,
    required this.onCheckBoxClicked,
    required this.textChange,
  }) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<TimeSheetDetailsListWidget> {
  bool isChecked = false;
  bool isCheckedReject = false;
  TextEditingController jobDescri = TextEditingController();

  @override
  void initState() {
    super.initState();
    jobDescri.addListener(updateValue);

    if(widget.items.time_sheet_detail_status==1)
      {
        isChecked = true;
      }
    if(widget.items.time_sheet_detail_status==2)
    {
      isCheckedReject = true;
    }
    if(null != widget.items.time_sheet_detail_comment)
      {
        jobDescri.text = widget.items.time_sheet_detail_comment!;
      }

  }

  void updateValue() {
    widget.textChange(jobDescri.text, widget.index);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
          children: [
            Column(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    AutoSizeText(
                      Txt.at + widget.items.hospital!,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.visible,
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
                        "${Txt.date}: ${getStringFromDate(getDateFromString(widget.items.date!,"yyyy-MM-dd"),"dd-MM-yyyy")}",
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
                        convert24hrTo12hr(widget.items.timeFrom!)     +
                            Txt.to+
                        convert24hrTo12hr( widget.items.timeTo!)   ,
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
              Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Txt.accept),
                      Container(
                        alignment: Alignment.topLeft,
                        transformAlignment: Alignment.topLeft,
                        child: Checkbox(

                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                              isCheckedReject = !value;
                            });

                            if (isChecked) {
                              widget.onCheckBoxClicked(
                                  widget.index, "1");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(Txt.reject),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                        value: isCheckedReject,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedReject = value!;
                            isChecked = !value;
                          });
                          if (isCheckedReject) {
                            widget.onCheckBoxClicked(
                                widget.index, "0");
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    transformAlignment: Alignment.topLeft,
                    child: TextInputFiledDescription(
                        controlr: jobDescri,
                        onTapDate: () {},
                        validator: (jobDescri) {
                          if (validDescription(jobDescri)) {
                            return null;
                          } else {
                            return Txt.enter_job_descri;
                          }
                        },
                        hintText:Txt.comment,
                        keyboadType: TextInputType.visiblePassword,
                        isPwd: false),
                  ),
                ],
              ),
            ]),
            SizedBox(height: screenHeight(context, dividedBy: 120)),
          ],
        ),
      ),
    );
  }
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Constants.colors[3];
}
