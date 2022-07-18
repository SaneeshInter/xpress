import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/strings.dart';

import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
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
        body: SizedBox(
          height: 45.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(children: [
                  Text(
                    Txt.contact_us,
                    style: TextStyle(
                        fontSize: 30,
                        color: Constants.colors[1],
                        fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(
                    height: 10,
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        sendingMails("mailto:info@xpresshealth.ie?subject=&body=");
                      },
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
                              color: Constants.colors[6],
                              fontWeight: FontWeight.normal),
                        ),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        dialCall(Txt.contactNumber);
                      },
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
                              color: Constants.colors[6],
                              fontWeight: FontWeight.normal),
                        ),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        launchLink('https://goo.gl/maps/7Mrii3wE9T4JcHC68');
                      },
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
                                color: Constants.colors[6],
                                fontWeight: FontWeight.normal),
                            maxLines: 3,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]
                ),
              ),
            ),
          ),
        )
    );
  }


}
