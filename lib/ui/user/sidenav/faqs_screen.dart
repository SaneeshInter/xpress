import 'dart:core';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/strings.dart';
import '../../../model/faq_model.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../widgets/expandable_group.dart';


class FaqsShitsScreen extends StatefulWidget {
  const FaqsShitsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FaqsShitsScreenState();
  }
}

class _FaqsShitsScreenState extends State<FaqsShitsScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int indexExpanded= 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var token;


  @override
  void didUpdateWidget(covariant FaqsShitsScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }



  @override
  void dispose() {
    super.dispose();
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
         Txt.faqs,
          style: TextStyle(
              fontSize: 17,
              color: Constants.colors[1],
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      backgroundColor: Constants.colors[9],
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: data.length,

          itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ExpandableGroup(
                isExpanded: false,
                header:  Text(data[index].question,
                    style: TextStyle(
                        fontSize: 14,
                        color: Constants.colors[1],
                        fontWeight: FontWeight.bold)),
                items: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(data[index].answer,textAlign: TextAlign.justify,),
                ),

                headerEdgeInsets: const EdgeInsets.only(left: 16.0, right: 16.0)
            ),
          );
        },),
      ),
    );
  }
}
