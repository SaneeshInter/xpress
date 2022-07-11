import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/strings.dart';

import '../../model/user_availability_btw_date.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'buttons/submit_button.dart';

class AvailabilityListWidget extends StatefulWidget {
  final AvailabilityList item;
  final int value;
  final Function onTapView;
  final Function onSumbmit;

  const AvailabilityListWidget(
      //list
      {Key? key,
      required this.item,
      required this.onTapView,
      required this.onSumbmit,
      required this.value})
      : super(key: key);

  @override
  _AvailabilityState createState() => _AvailabilityState();
}

class _AvailabilityState extends State<AvailabilityListWidget> {
  var selectedValue = "0";
  bool isClicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isClicked) {
      selectedValue = widget.item.availability!;
    }
    debugPrint(isClicked.toString());
    return Container(
      width: 55.w,
      height: 55.w,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context, dividedBy: 25),
          vertical: screenHeight(context, dividedBy: 70)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  selectedValue = "1";
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset(
                              'assets/images/icon/sunny-day.svg'),
                        ),
                        const Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: AutoSizeText(
                                Txt.day,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Visibility(
                              visible: selectedValue == 1,
                              child: SvgPicture.asset(
                                  'assets/images/icon/check.svg'),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isClicked = true;
                  selectedValue = "2";
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset('assets/images/icon/moon.svg'),
                        ),
                        const Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: AutoSizeText(
                                Txt.night,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Visibility(
                              visible: selectedValue == 2,
                              child: SvgPicture.asset(
                                  'assets/images/icon/check.svg'),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isClicked = true;
                  selectedValue = "0";
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset(
                              'assets/images/icon/turn-off.svg'),
                        ),
                        const Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              //color: Colors.green,
                              child: AutoSizeText(
                                "OFF",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Visibility(
                              visible: selectedValue == 0,
                              child: SvgPicture.asset(
                                  'assets/images/icon/check.svg'),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 50)),
            SubmitButton(
                onPressed: () {
                  widget.onSumbmit(selectedValue);
                },
                label: "Submit",
                textColors: Constants.colors[0],
                color1: Constants.colors[3],
                color2: Constants.colors[4]),
          ],
        ),
      ),
    );
  }
}
