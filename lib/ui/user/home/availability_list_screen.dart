import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/strings.dart';
import '../../../blocs/user_availability_bloc.dart';
import '../../../main.dart';
import '../../../model/user_availability_btw_date.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../widgets/labeled_checkbox.dart';
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
        Future.delayed(Duration.zero, () {
          showInternetNotAvailable();
        });
      }
    }
  }

  void observe() {
    availabilitybloc.useravailabilitiy.listen((event) {
      if (event.response != null) {
        if (event.response?.status?.statusCode == 200) {
          getData();
        } else {
          var message = event.response?.status?.statusMessage;
          showAlertDialoge(context, title: Txt.availability, message: message!);
        }
      } else {
        showInternetNotAvailable();
      }
    });
  }
  void showInternetNotAvailable() {
    Navigator.pushNamed(context, '/nw_error').then((_) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Constants.colors[9],
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await availabilitybloc.fetchuserAvailability();
            },
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return false;
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 4),
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
                            AsyncSnapshot<List<AvailabilityList>> snapshot) {
                          print("stream");
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                List<String> slot = [
                                  "morning",
                                  "Day",
                                  "Afternoon",
                                  "Night",
                                  "Sleepover",
                                  "Off",
                                ];
                                var item = snapshot.data![index];
                                //String to list of strings
                                List<String> list = item.availability!.split(",");
                                list.remove("0");
                                print("list length: ${item.availability}  ${list.isEmpty} ${list.toString()} ");
                                if(list.isEmpty){
                                    list.add("6");
                                }
                                List<bool> listOfSlot = [];
                                for (var i = 1; i <= slot.length; i++) {
                                  if (list.contains((i).toString())) {
                                    listOfSlot.add(true);
                                  } else {
                                    listOfSlot.add(false);
                                  }
                                }

                                // if (item.availability == 1) {
                                //   availabilitybloc.availability =
                                //       Availability.morning;
                                // }

                                // else if (item.availability == 2) {
                                //   availabilitybloc.availability =
                                //       Availability.day;
                                // }
                                // else if (item.availability == 3) {
                                //   availabilitybloc.availability =
                                //       Availability.afternoon;
                                // }
                                // else if (item.availability == 4) {
                                //   availabilitybloc.availability =
                                //       Availability.night;
                                // }
                                // else {
                                //   availabilitybloc.availability =
                                //       Availability.sleepover;
                                // }
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4.0),
                                  child: Card(
                                    elevation: 0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.calendar_month,color: greenColor,),const SizedBox(width: 10,),
                                                AutoSizeText(
                                                  item.date.toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Constants.colors[1],
                                                    fontSize: 12.sp,
                                                    fontFamily: "SFProMedium",
                                                  ),
                                                ),
                                              ],
                                            )),
                                        const Divider(
                                          height: 1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                                          child: SizedBox(
                                            height: 80,
                                            child: ListView.builder(
                                              itemCount: slot.length,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (BuildContext context,
                                                  int position) {
                                                return LabeledCheckbox(
                                                  label: slot[position],
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  value: listOfSlot[position],
                                                  onChanged: (bool newValue) {
                                                    listOfSlot[position] =newValue;
                                                    if(position==5){
                                                      updateShiftAvailabaity("6",
                                                          item.date.toString());
                                                    }else{
                                                      String value = "";
                                                      for (int i = 0; i < slot.length;
                                                      i++) {
                                                        if (listOfSlot[i]) {
                                                          if(i!=5){
                                                            value += "${i + 1},";
                                                            list.add({i + 1}.toString());
                                                          }
                                                        }
                                                      }
                                                      updateShiftAvailabaity(value!=""?value:"6",
                                                          item.date.toString());

                                                    }

                                                    setState(() {

                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          ),

                                          // Row(
                                          //   children: [
                                          //     Expanded(
                                          //       flex: 1,
                                          //       child: Column(
                                          //         children: [
                                          //           LabeledCheckbox(label: Txt.morning,padding: const EdgeInsets.all(4),value:true, onChanged: (bool newValue) {
                                          //             setState(() {
                                          //              debugPrint("value");
                                          //             });
                                          //           },)
                                          //           // Radio<Availability>(
                                          //           //   fillColor: MaterialStateColor
                                          //           //       .resolveWith(
                                          //           //           (states) =>
                                          //           //               Colors
                                          //           //                   .green),
                                          //           //   focusColor: MaterialStateColor
                                          //           //       .resolveWith(
                                          //           //           (states) =>
                                          //           //               Colors
                                          //           //                   .green),
                                          //           //   value: Availability
                                          //           //       .morning,
                                          //           //   groupValue:
                                          //           //   availabilitybloc.availability,
                                          //           //   onChanged: (value) {
                                          //           //     updateShiftAvailabaity(
                                          //           //         1,
                                          //           //         item.date
                                          //           //             .toString());
                                          //           //     setState(() {
                                          //           //       availabilitybloc.availability =
                                          //           //           value;
                                          //           //     });
                                          //           //   },
                                          //           // ),
                                          //           // Text(Txt.morning),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       flex: 1,
                                          //       child: Column(
                                          //         children: [
                                          //           Radio<Availability>(
                                          //             fillColor: MaterialStateColor
                                          //                 .resolveWith(
                                          //                     (states) =>
                                          //                         Colors
                                          //                             .green),
                                          //             focusColor: MaterialStateColor
                                          //                 .resolveWith(
                                          //                     (states) =>
                                          //                         Colors
                                          //                             .green),
                                          //             value: Availability
                                          //                 .day,
                                          //             groupValue:
                                          //             availabilitybloc.availability,
                                          //             onChanged: (value) {
                                          //               updateShiftAvailabaity(
                                          //                   2,
                                          //                   item.date
                                          //                       .toString());
                                          //               setState(() {
                                          //                 availabilitybloc.availability =
                                          //                     value;
                                          //               });
                                          //             },
                                          //           ),
                                          //           Text(Txt.day),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       flex: 1,
                                          //       child: Column(
                                          //         children: [
                                          //           Radio<Availability>(
                                          //             fillColor: MaterialStateColor
                                          //                 .resolveWith(
                                          //                     (states) =>
                                          //                         Colors
                                          //                             .green),
                                          //             focusColor: MaterialStateColor
                                          //                 .resolveWith(
                                          //                     (states) =>
                                          //                         Colors
                                          //                             .green),
                                          //             value: Availability
                                          //                 .afternoon,
                                          //             groupValue:
                                          //             availabilitybloc.availability,
                                          //             onChanged: (value) {
                                          //               updateShiftAvailabaity(
                                          //                   3,
                                          //                   item.date
                                          //                       .toString());
                                          //               setState(() {
                                          //                 availabilitybloc.availability =
                                          //                     value;
                                          //               });
                                          //             },
                                          //           ),
                                          //           Text(Txt.after_noon),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       flex: 1,
                                          //       child: Column(
                                          //         children: [
                                          //           Radio<Availability>(
                                          //             fillColor: MaterialStateColor
                                          //                 .resolveWith(
                                          //                     (states) =>
                                          //                         Colors
                                          //                             .green),
                                          //             focusColor: MaterialStateColor
                                          //                 .resolveWith(
                                          //                     (states) =>
                                          //                         Colors
                                          //                             .green),
                                          //             value: Availability
                                          //                 .night,
                                          //             groupValue:
                                          //             availabilitybloc.availability,
                                          //             onChanged: (value) {
                                          //               updateShiftAvailabaity(
                                          //                   4,
                                          //                   item.date
                                          //                       .toString());
                                          //               setState(() {
                                          //                 availabilitybloc.availability =
                                          //                     value;
                                          //               });
                                          //             },
                                          //           ),
                                          //           Text(Txt.night),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       flex: 1,
                                          //       child: Column(
                                          //         children: [
                                          //           Radio<Availability>(
                                          //             fillColor: MaterialStateColor
                                          //                 .resolveWith(
                                          //                     (states) =>
                                          //                         Colors
                                          //                             .green),
                                          //             focusColor: MaterialStateColor
                                          //                 .resolveWith(
                                          //                     (states) =>
                                          //                         Colors
                                          //                             .green),
                                          //             value: Availability
                                          //                 .sleepover,
                                          //             groupValue:
                                          //             availabilitybloc.availability,
                                          //             onChanged: (value) {
                                          //               setState(() {
                                          //                 availabilitybloc.availability =
                                          //                     value;
                                          //               });
                                          //               updateShiftAvailabaity(
                                          //                   0,
                                          //                   item.date
                                          //                       .toString());
                                          //             },
                                          //           ),
                                          //           const Text(Txt.sleep_over),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
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
              ),
            ),
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
    );
  }

  void updateShiftAvailabaity(String selectedShfit, String date) {
    if (null != availabilitybloc.token) {
      availabilitybloc.addUserAvailability(date, selectedShfit.toString());
    }
  }
}
