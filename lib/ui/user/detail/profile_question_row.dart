import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants.dart';

class ProfileQuestionRow extends StatefulWidget {
  final String label;
  final String asset;
  final int status;
  final Function onChanged;

  const ProfileQuestionRow({
    Key? key,
    required this.label,
    required this.asset,
    required this.status,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomRowState createState() => _CustomRowState();
}

class _CustomRowState extends State<ProfileQuestionRow> {
  bool tapped = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: AutoSizeText(
                    widget.label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontFamily: "SFProMedium",
                    ),
                    maxLines: 2,
                  ),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(

                      inactiveTrackColor:  Constants.colors[39],
                      inactiveThumbColor:  Constants.colors[24],
                      activeColor:  Constants.colors[12],
                      activeTrackColor:  Constants.colors[16],
                      value: widget.status == 1,
                      onChanged: (value) {
                        return null;
                        if (value) {
                          // setState(() {
                          widget.status == 0;
                          // });
                        } else {
                          // setState(() {
                          widget.status == 1;
                          // });
                        }
                        widget.onChanged(value);
                      }


                      ),
                ),
                if (widget.status == 1)
                  Expanded(
                    flex: 1,
                    child: Container(
                        height: 4.w,
                        width: 4.w,
                        child: SvgPicture.asset(
                          "assets/images/icon/check.svg",
                        )),
                  ),
                if (widget.status == 0)
                  Expanded(
                    flex: 1,
                    child: Container(
                        height: 4.w,
                        width: 4.w,
                        child: SvgPicture.asset(
                          "assets/images/icon/information-button.svg",
                        )),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
