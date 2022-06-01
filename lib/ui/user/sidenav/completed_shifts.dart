import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/strings.dart';
import 'package:xpresshealthdev/blocs/shift_completed_bloc.dart';
import '../../../model/user_complted_shift.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/completed_shift_list.dart';
import '../../widgets/loading_widget.dart';
import '../detail/shift_detail.dart';

class CompletedShift extends StatefulWidget {
  const CompletedShift({Key? key}) : super(key: key);

  @override
  _CompletedShiftState createState() => _CompletedShiftState();
}

class _CompletedShiftState extends State<CompletedShift> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime _selectedValue;
  bool visibility = false;
  bool buttonVisibility = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var token;
  var _image;
  List<String> list = [];

  @override
  void didUpdateWidget(covariant CompletedShift oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {
        completeBloc.fetchcomplete(token);
      } else {
        showInternetNotAvailable();
      }
    }
  }

  Future<void> showInternetNotAvailable() async {
    int respo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );

    if (respo == 1) {
      getData();
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    observe();
  }

  void observe() {
    completeBloc.allShift.listen((event) {
      var data = event.response?.data;
      if (data?.items != null) {
        if (data?.items?.length != 0) {
          setState(() {
            buttonVisibility = true;
          });
        }
      }
    });
    completeBloc.uploadStatus.listen((event) {
      print("event");
      print(event.response);
      var message = event.response?.status?.statusMessage;
      setState(() {
        _image = null;
      });
      getData();
      showAlertDialoge(context, message: message!, title: Txt.upload_docs);
    });
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
          //change your color here
        ),
        backgroundColor: HexColor("#ffffff"),
        title: AutoSizeText(
         Txt.completed_shifts,
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
                    horizontal: screenWidth(context, dividedBy: 35)),
                child: Column(children: [
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  StreamBuilder(
                      stream: completeBloc.allShift,
                      builder: (BuildContext context,
                          AsyncSnapshot<UserShoiftCompletedResponse>
                              snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data?.response?.data;
                          if (data?.items != null) {
                            if (data?.items?.length != 0) {
                              return buildList(snapshot);
                            } else {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    20.height,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(Txt.completed_shift,
                                            style: boldTextStyle(size: 20)),
                                        85.width,
                                        16.height,
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 32),
                                          child: Text(
                                           Txt.no_shift,
                                              style:
                                                  primaryTextStyle(size: 15),
                                              textAlign: TextAlign.center),
                                        ),
                                      ],
                                    ),
                                    150.height,
                                    Image.asset(
                                        'assets/images/error/empty_task.png',
                                        height: 250),
                                  ],
                                ),
                              );
                            }
                          }
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Container();
                      }),
                  SizedBox(
                    height: 10,
                  ),
                ])),
            Container(
              width: 100.w,
              height: 70.h,
              child: StreamBuilder(
                stream: completeBloc.visible,
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!) {
                      return const Center(child: LoadingWidget());
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<UserShoiftCompletedResponse> snapshot) {
    var data = snapshot.data?.response?.data;
    return ListView.builder(
      itemCount: data?.items?.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var name = "Shift Reminder";
        var description = "Completed shift";
        var items = data?.items![index];
        return Column(
          children: [
            CompletedBookingWidget(
              onTapView: (item) {
                if (items is Items) {
                  Items data = items;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShiftDetailScreen(
                              shift_id: data.rowId.toString(),
                              isCompleted: true,
                            )),
                  );
                }
              },
              onTapCall: () {},
              onTapMap: () {},
              onTapBooking: () {},
              items: items!,
            ),
            SizedBox(height: screenHeight(context, dividedBy: 100)),
          ],
        );
      },
    );
  }
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
