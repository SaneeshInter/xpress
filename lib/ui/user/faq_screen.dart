import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/AppColors.dart';
import '../../utils/constants.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Constants.colors[1],
        ),
        backgroundColor: white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  'assets/images/icon/logo.svg',
                  fit: BoxFit.contain,
                  height: 8.w,
                )),
          ],
        ),
        centerTitle: true,

      ),
    );
  }
}
