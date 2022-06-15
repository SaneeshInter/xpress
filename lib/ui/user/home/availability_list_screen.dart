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
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/loading_widget.dart';
class AvailabilityListScreen extends StatefulWidget {
  const AvailabilityListScreen({Key? key}) : super(key: key);
  @override
  _AvailabilityState createState() => _AvailabilityState();

}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AvailabilityState extends State<AvailabilityListScreen> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? pageController;


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
    init();
    observe();
    getData();
    pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  void init() {
    availabilitybloc.startDate = DateTime.now();
    var today = DateTime.now();
    availabilitybloc.endDate = today.add(const Duration(days: 29));
    availabilitybloc.availability = Availability.sleepover;
  }

  Future getData() async {
    availabilitybloc.token = await TokenProvider().getToken();
    if (null != availabilitybloc.token) {
      if (await isNetworkAvailable()) {
        availabilitybloc.fetchuserAvailability();
      } else {
        showInternetNotAvailable();
      }
    }
  }

  Future<void> showInternetNotAvailable() async {
    int resp = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );

    if (resp == 1) {
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                        availabilitybloc.availability = Availability.morning;
                                      } else if (item.availability == 2) {
                                        availabilitybloc.availability = Availability.day;
                                      } else if (item.availability == 3) {
                                        availabilitybloc.availability = Availability.afternoon;
                                      } else if (item.availability == 4) {
                                        availabilitybloc.availability = Availability.night;
                                      } else {
                                        availabilitybloc.availability = Availability.sleepover;
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
                                                      flex: 1,
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
                                                            availabilitybloc.availability,
                                                            onChanged: (value) {
                                                              updateShiftAvailabaity(
                                                                  1,
                                                                  item.date
                                                                      .toString());
                                                              setState(() {
                                                                availabilitybloc.availability =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Text(Txt.morning),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
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
                                                            availabilitybloc.availability,
                                                            onChanged: (value) {
                                                              updateShiftAvailabaity(
                                                                  2,
                                                                  item.date
                                                                      .toString());
                                                              setState(() {
                                                                availabilitybloc.availability =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Text(Txt.day),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
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
                                                            availabilitybloc.availability,
                                                            onChanged: (value) {
                                                              updateShiftAvailabaity(
                                                                  3,
                                                                  item.date
                                                                      .toString());
                                                              setState(() {
                                                                availabilitybloc.availability =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Text(Txt.after_noon),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
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
                                                            availabilitybloc.availability,
                                                            onChanged: (value) {
                                                              updateShiftAvailabaity(
                                                                  4,
                                                                  item.date
                                                                      .toString());
                                                              setState(() {
                                                                availabilitybloc.availability =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          Text(Txt.night),
                                                        ],
                                                      ),
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
                                                            availabilitybloc.availability,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                availabilitybloc.availability =
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
                                return const SizedBox();
                              }),
                        ],
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
                    return const SizedBox();
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void updateShiftAvailabaity(int selectedShfit, String date) {
    if (null != availabilitybloc.token) {
      availabilitybloc.addUserAvailability(date, selectedShfit.toString());
    }
  }
}
