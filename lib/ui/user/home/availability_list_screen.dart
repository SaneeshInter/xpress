import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import '../../../blocs/user_availability_bloc.dart';
import '../../../main.dart';

import '../../../Constants/strings.dart';
import '../../../model/user_availability_btw_date.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
import '../../../utils/utils.dart';
import '../../datepicker/date_picker_widget.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/loading_widget.dart';

class AvailabilityListScreen extends StatefulWidget {
  const AvailabilityListScreen({Key? key}) : super(key: key);

  @override
  _AvailabilityState createState() => _AvailabilityState();

}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AvailabilityState extends State<AvailabilityListScreen> {
  String? token;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var itemSelected = 0;
  var daysCount = 500;
  var startDate;
  var endDate;
  PageController? pageController;
  bool visibility = false;
  double viewportFraction = 0.8;
  Availability? availability = null;
  double? pageOffset = 0;

  @override
  void didUpdateWidget(covariant AvailabilityListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    availabilitybloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    var today = DateTime.now();
    endDate = today.add(const Duration(days: 29));
    availability = Availability.sleepover;
    observe();
    getData();
    pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  Future getData() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {
        availabilitybloc.fetchuserAvailability(token!, startDate, endDate);
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

  void observe() {
    availabilitybloc.useravailabilitiy.listen((event) {
      if (event.response?.status?.statusCode == 200) {
        getData();
      } else {
        var message = event.response?.status?.statusMessage;
        showAlertDialoge(context, title: Txt.availability, message: message!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final PageController ctrl = PageController(
      viewportFraction: .612,
    );
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    DatePicker date;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.colors[9],
      body: LiquidPullToRefresh(
        animSpeedFactor: 1.5,
        onRefresh: () async {
          getData();
        },
        child: Stack(
          children: [
            ListView(
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AutoSizeText(
                               Txt.availability,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Constants.colors[1],
                                  fontSize: 16.sp,
                                  fontFamily: "SFProMedium",
                                ),
                              )),
                          StreamBuilder(
                              stream: availabilitybloc.useravailabilitiydate,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<AvailabilityList>>
                                      snapshot) {
                                print("stream");
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var item = snapshot.data![index];
                                      if (item.availability == 1) {
                                        availability = Availability.morning;
                                      } else if (item.availability == 2) {
                                        availability = Availability.day;
                                      } else if (item.availability == 3) {
                                        availability = Availability.afternoon;
                                      } else if (item.availability == 4) {
                                        availability = Availability.night;
                                      } else {
                                        availability = Availability.sleepover;
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Card(
                                          elevation: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: AutoSizeText(
                                                    item.date.toString(),
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color:
                                                          Constants.colors[1],
                                                      fontSize: 12.sp,
                                                      fontFamily: "SFProMedium",
                                                    ),
                                                  )),
                                              Divider(
                                                height: 1,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Radio<Availability>(
                                                            fillColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            focusColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            value: Availability
                                                                .morning,
                                                            groupValue:
                                                                availability,
                                                            onChanged: (value) {
                                                              updateShiftAvailabaity(
                                                                  1,
                                                                  item.date
                                                                      .toString());
                                                              setState(() {
                                                                availability =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Text(Txt.morning),
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Radio<Availability>(
                                                            fillColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            focusColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            value: Availability
                                                                .day,
                                                            groupValue:
                                                                availability,
                                                            onChanged: (value) {
                                                              updateShiftAvailabaity(
                                                                  2,
                                                                  item.date
                                                                      .toString());
                                                              setState(() {
                                                                availability =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Text(Txt.day),
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Radio<Availability>(
                                                            fillColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            focusColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            value: Availability
                                                                .afternoon,
                                                            groupValue:
                                                                availability,
                                                            onChanged: (value) {
                                                              updateShiftAvailabaity(
                                                                  3,
                                                                  item.date
                                                                      .toString());
                                                              setState(() {
                                                                availability =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Text(Txt.after_noon),
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Radio<Availability>(
                                                            fillColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            focusColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            value: Availability
                                                                .night,
                                                            groupValue:
                                                                availability,
                                                            onChanged: (value) {
                                                              updateShiftAvailabaity(
                                                                  4,
                                                                  item.date
                                                                      .toString());
                                                              setState(() {
                                                                availability =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Text(Txt.night),
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Radio<Availability>(
                                                            fillColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            focusColor: MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green),
                                                            value: Availability
                                                                .sleepover,
                                                            groupValue:
                                                                availability,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                availability =
                                                                    value;
                                                              });
                                                              updateShiftAvailabaity(
                                                                  0,
                                                                  item.date
                                                                      .toString());
                                                            },
                                                          ),
                                                          Text(Txt.sleep_over),
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                return Container();
                              }),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ],
                  ),
                )
              ],
            ),
            StreamBuilder(
              stream: availabilitybloc.visible,
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
          ],
        ),
      ),
    );
  }

  void updateShiftAvailabaity(int selectedShfit, String date) {
    if (null != token) {
      availabilitybloc.addUserAvailability(
          token!, date, selectedShfit.toString());
    }
  }
}
