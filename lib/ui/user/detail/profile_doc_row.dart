import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
class ProfileDocRow extends StatefulWidget {
  final String label;
  final String asset;
  final String image;
  final String url;
  const ProfileDocRow({
    Key? key,
    required this.label,
    required this.asset,
    required this.image,
    required this.url,
  }) : super(key: key);
  @override
  _CustomRowState createState() => _CustomRowState();
}

class _CustomRowState extends State<ProfileDocRow> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    print("widget.url");
    print(widget.url);
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
                    if(widget.url.isNotEmpty )
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          height: 4.w,
                          width: 4.w,
                          child: SvgPicture.asset(
                           "assets/images/icon/check.svg",
                          )),
                    ),
                    if(widget.url.isEmpty)
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          height: 4.w,
                          width: 4.w,
                          child: SvgPicture.asset(
                            "assets/images/icon/information-button.svg",
                          )),
                    ),
                if(widget.url.isEmpty)
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                        height: 4.w,
                        width: 4.w,
                        child: SvgPicture.asset(
                          "assets/images/icon/surface1.svg",
                        )),
                  ),

              ],
            ),
            if (widget.image.isNotEmpty)
            SizedBox(
              height: 3.w,
            ),
            if (widget.image.isNotEmpty)
              SizedBox(
                  height: 50.w,
                  width: 100.w,
                  child: widget.image.isNotEmpty
                      ? Image.file(
                          File(widget.image),
                          fit: BoxFit.cover,
                        )
                      : const SizedBox()),
          ],
        ),
      ),
    );
  }
}
