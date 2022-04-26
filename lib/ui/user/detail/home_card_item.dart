import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/app_defaults.dart';
import '../../../utils/constants.dart';
import '../../widgets/buttons/drawable_button.dart';

class HomeCardItem extends StatefulWidget {
  final String label;
  final String asset;

  const HomeCardItem({
    Key? key,
    required this.label,
    required this.asset,
  }) : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCardItem> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: AutoSizeText(
                  widget.label,
                  maxLines: 2,
                  style: TextStyle(
                   color: Constants.colors[1],
                    fontSize: 14.sp,
                    fontFamily: "SFProMedium",
                  ),
                ),
              ),
              Container(

                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: Constants.colors[12],
                  child: SvgPicture.asset(
                    widget.asset,
                    height: 5.w,
                    width: 5.w,
                    color: Constants.colors[0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
