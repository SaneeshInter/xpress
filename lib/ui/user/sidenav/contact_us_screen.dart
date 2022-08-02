import 'dart:core';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/widgets/contact_us_widget.dart';
import '../../../Constants/strings.dart';
import '../../../model/contact_us_model.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/images/icon/arrow.svg',
              width: 5.w,
              height: 4.2.w,
            ),
            onPressed: () {
              Navigator.pop(context);
            },

          ),
          bottomOpacity: 0.0,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: AutoSizeText(
            Txt.contact_us,
            style: TextStyle(fontSize: 17, color: Constants.colors[1], fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        backgroundColor: Constants.colors[9],
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return ContactUsWidget(
              onTap: list[index].onTap,
              title: list[index].subTitle,
              icon: list[index].icon,
              subTitle: list[index].title,

            );

          },

        ),

    );
  }
}
