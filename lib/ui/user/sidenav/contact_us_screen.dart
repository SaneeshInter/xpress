import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/strings.dart';

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
          iconTheme: const IconThemeData(
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0.0,
            child: Column(children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Txt.contact_us,
                      style: TextStyle(
                          fontSize: 30,
                          color: Constants.colors[1],
                          fontWeight: FontWeight.w700),
                    ),


                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Column(

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            const SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ColoredBox(
                                color: Constants.colors[12],
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.mail,color: white,),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "info@xpresshealth.ie",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Constants.colors[1],
                                  fontWeight: FontWeight.normal),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            const SizedBox(
                              width: 10,
                            ),
                             ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                               child: ColoredBox(
                                 color: Constants.colors[12],
                                 child: const Padding(
                                   padding: EdgeInsets.all(8.0),
                                   child: Icon(Icons.phone,color: white,),
                                 ),
                               ),
                             ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "+35312118883",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Constants.colors[1],
                                  fontWeight: FontWeight.normal),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            const SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ColoredBox(
                                color: Constants.colors[12],
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.location_on,color: white,),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                               '''Leopardstown Road, Stillorgan, Dublin, Ireland''',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Constants.colors[1],
                                    fontWeight: FontWeight.normal),
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ]),
                        ),
                      ],)

                  // SingleChildScrollView(
                  //   child: Stack(
                  //     children: [
                  //       Container(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: screenWidth(context, dividedBy: 5)),
                  //           child: Column(
                  //
                  //             children: [
                  //               20.height,
                  //               Column(
                  //                 mainAxisAlignment:
                  //                 MainAxisAlignment.start,
                  //                 children: [
                  //                   Text(Txt.contact_us,
                  //                       style: boldTextStyle(size: 20)),
                  //                   85.width,
                  //                   16.height,
                  //                   Container(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 32),
                  //                     child: Text(
                  //                       Txt.under_devlpmnt,
                  //                         style: primaryTextStyle(size: 15),
                  //                         textAlign: TextAlign.center),
                  //                   ),
                  //                 ],
                  //               ),
                  //               150.height,
                  //               Image.asset(
                  //                   'assets/images/icon/work.png',
                  //                   height: 250),
                  //             ],
                  //           )),
                  //
                  //     ],
                  //   ),
                  // ),
                ),
              )
            ]
            ),
          ),
        )
    );
  }


}
