import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class CustomRowz extends StatefulWidget {
  final Function onPressed;
  final String label;
  final String asset;
  final Color textColors;


  const CustomRowz(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.asset,
      required this.textColors,
     })
      : super(key: key);

  @override
  _CustomRowState createState() => _CustomRowState();
}

class _CustomRowState extends State<CustomRowz> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();

      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 16,left: 10),
        child: Row(
          children: [
            if(widget.asset !=null && widget.asset.isNotEmpty)
            SvgPicture.asset(
              widget.asset,
              width: MediaQuery.of(context).size.width * 0.03,
              height: MediaQuery.of(context).size.width * 0.03,
             // color: widget.textColors,
            ),
            SizedBox(width: 10),
            Container(
              width: 70.w,
              // width: screenWidth(context, dividedBy: 3.5),
              child: AutoSizeText.rich(
                TextSpan(
                  text: widget.label,
                  style: TextStyle(
                    fontSize: 16,
                      color: widget.textColors,
                      fontFamily: "SFProMedium",
                      fontWeight: FontWeight.w600),
                ),
                maxLines: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
