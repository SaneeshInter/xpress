import 'dart:core';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/Constants/strings.dart';

import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var token;


  @override
  void didUpdateWidget(covariant ContactScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
    FixedExtentScrollController();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
        iconTheme: IconThemeData(
          color: Colors.black,

        ),
        backgroundColor: HexColor("#ffffff"),
        title: AutoSizeText(
         Txt.contact_us,
          style: TextStyle(
              fontSize: 17,
              color: Constants.colors[1],
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      backgroundColor: Constants.colors[9],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, dividedBy: 5)),
                child: Column(

                  children: [
                    20.height,
                    Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Text(Txt.contact_us,
                            style: boldTextStyle(size: 20)),
                        85.width,
                        16.height,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32),
                          child: Text(
                            Txt.under_devlpmnt,
                              style: primaryTextStyle(size: 15),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                    150.height,
                    Image.asset(
                        'assets/images/icon/work.png',
                        height: 250),
                  ],
                )),

          ],
        ),
      ),
    );
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
    return Colors.red;
  }
}
