import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/strings.dart';
import '../../../blocs/shift_confirmed_bloc.dart';
import '../../../model/filter_booking_list.dart';
import '../../../model/user_view_request_response.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../utils/validator.dart';
import '../../Widgets/buttons/submit_small.dart';
import '../../Widgets/my_booking_list_widget.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/input_text.dart';
import '../../widgets/loading_widget.dart';

class ConfirmedListWidget extends StatefulWidget {
  const ConfirmedListWidget({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ConfirmedListWidget> with WidgetsBindingObserver {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
  bool visible = false;

  @override
  void didUpdateWidget(covariant ConfirmedListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void cancelJob(Items items) {
    confirmBloc.userCancelJob(confirmBloc.token, items.rowId.toString());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getDataitems();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    observe();
    getDataitems();
    dateFrom.addListener(() {
      confirmBloc.checkAndUpdateTimeDifference(dateTo.text, dateFrom.text);
    });
    dateTo.addListener(() {
      confirmBloc.checkAndUpdateTimeDifference(dateTo.text, dateFrom.text);
    });
  }

  Future getDataitems() async {
    confirmBloc.token = await TokenProvider().getToken();
    if (null != confirmBloc.token) {
      if (await isNetworkAvailable()) {
        confirmBloc.fetchUserViewRequest(confirmBloc.token);
      } else {
        showInternetNotAvailable();
      }
    }
  }

  Future<void> showInternetNotAvailable() async {
    int response = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );
    if (response == 1) {
      getDataitems();
    }
  }

  void observe() {
    confirmBloc.workTime.listen((event) {});

    confirmBloc.userCancelJobRequest.listen((event) {
      String? message = event.response?.status?.statusMessage;
      getDataitems();
      Fluttertoast.showToast(msg: '$message');
    });
    confirmBloc.userWorkingHours.listen((event) {
      String? message = event.response?.status?.statusMessage;
      getDataitems();
      Fluttertoast.showToast(msg: '$message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint("onWillPop");
        return false;
      },
      child: Stack(
        children: [
          StreamBuilder(
              stream: confirmBloc.viewRequest,
              builder: (BuildContext context,
                  AsyncSnapshot<UserViewRequestResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.response?.data?.items?.length != 0) {
                    return bookingList(snapshot);
                  }
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const SizedBox();
              }),
          StreamBuilder(
            stream: confirmBloc.visible,
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

  Widget bookingList( AsyncSnapshot<UserViewRequestResponse> snapshot) {
    return Column(children: [buildList(snapshot)]);
  }

  showTimeUpdateAlert(BuildContext context, Items item) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 90.w,
                    color: Colors.red,
                    child: Material(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 11.w,
                              color: Constants.colors[20],
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(Txt.add_time_sheet,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SFProMedium",
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/icon/close.svg",
                                        height: 3.w,
                                        width: 3.w,
                                        color: Constants.colors[0],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Txt.start_time,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Constants.colors[22],
                                              fontSize: 11.sp,
                                              fontFamily: "SFProMedium",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextInputFileds(
                                              controlr: dateFrom,
                                              onChange: (text) {},
                                              validator: (dateTo) {
                                                if (validDate(dateTo)) {
                                                  return null;
                                                } else {
                                                  return Txt.select_time;
                                                }
                                              },
                                              onTapDate: () {
                                                selectTime(context, dateFrom);
                                              },
                                              hintText: Txt.timeFrom,
                                              keyboadType: TextInputType.none,
                                              isPwd: false),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Txt.end_time,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Constants.colors[22],
                                            fontSize: 11.sp,
                                            fontFamily: "SFProMedium",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextInputFileds(
                                          controlr: dateTo,
                                          validator: (dateTo) {
                                            if (validDate(dateTo)) {
                                              return null;
                                            } else {
                                              return Txt.select_time;
                                            }
                                          },
                                          onTapDate: () {
                                            FocusScope.of(context).unfocus();
                                            selectTime(context, dateTo);
                                          },
                                          hintText: Txt.timeTo,
                                          keyboadType: TextInputType.none,
                                          isPwd: false,
                                          onChange: (text) {
                                            debugPrint(text);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          StreamBuilder(
                            stream: confirmBloc.workTime,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if(!snapshot.hasData)
                              {
                                return const SizedBox();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, bottom: 16.0),
                                child: Text(
                                  Txt.working_hours + snapshot.data.toString(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Constants.colors[22],
                                    fontSize: 11.sp,
                                    fontFamily: "SFProMedium",
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 15.0, bottom: 15.0),
                            child: SizedBox(
                              width: 20.w,
                              child: SubmitButton(
                                  onPressed: () {
                                    var validate =
                                    formKey.currentState?.validate();
                                    if (null != validate) {
                                      if (validate) {
                                        if (mounted) {
                                          updateAndExit(item, context);
                                        }
                                      }
                                      // use the information provided
                                    }
                                  },
                                  label: Txt.submit,
                                  textColors: Constants.colors[0],
                                  color1: Constants.colors[3],
                                  color2: Constants.colors[4]),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void updateAndExit(Items item, BuildContext context) {
    confirmBloc.fetchUserWorkingHours(
      confirmBloc.token,
      item.shiftId.toString(),
      dateFrom.text,
      dateTo.text,
      confirmBloc.workingHour.toString(),
    );
    dateFrom.text = "";
    dateTo.text = "";
    confirmBloc.workingHour = "0";
    Navigator.pop(context);
  }

  Widget buildList(
      AsyncSnapshot<UserViewRequestResponse> snapshot) {
    var allList = getFilterList(snapshot);
    List<DateItems> list = allList.confirmed;
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          getDataitems();
        },
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child:list.isNotEmpty?
            ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int ind) {

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                      child: Text(getStringFromDate(getDateFromString(list[ind].date,"yyyy-MM-dd"),"EEE dd MMMM yyyy"),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'SFProBold',color: Constants.colors[25]),),
                    ),
                    ListView.builder(
                      itemCount: list[ind].list.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var items = list[ind].list[index];
                        return Column(
                          children: [
                            MyBookingListWidget(
                              items: items,
                              position: 12,
                              onTapView: (item) {
                                showTimeUpdateAlert(context, item);
                              },
                              onTapCancel: (item) {
                                cancelJob(items);
                              },
                              onTapCall: () {},
                              onTapMap: () {},
                              onTapBooking: () {},
                              key: null,
                            ),
                          ],
                        );
                      },
                    )
                  ],
                );
              },
            )

                : SizedBox(
              width: 100.w,
              child: Column(
                children: [
                  20.height,

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(Txt.empty_shifts, style: boldTextStyle(size: 20)),
                      100.width,
                      16.height,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(Txt.no_shift,
                            style: primaryTextStyle(size: 15),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  100.height,
                  Image.asset('assets/images/error/empty_task.png', height: 250),
                  const SizedBox(height: 250,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

FilterBookingList getFilterList(AsyncSnapshot<UserViewRequestResponse> snapshot) {
  FilterBookingList list = FilterBookingList();
  List<Items>? allList = snapshot.data?.response?.data?.items;
  if (null != allList) {
    for (var item in allList) {
      double afterWorkHours = getHoursAndMinutesToDouble(getDiffrenceBetweenTwoDates(getDateFromString('${item.date!} ${item.timeTo}',"yyyy-MM-dd HH:mm"), DateTime.now()));

      if (item.status == Txt.accepted) {
        if (item.status == "Accepted" && item.workingTimeStatus == 0 &&afterWorkHours < 0)
        if(list.confirmed.any((element) => element.date==item.date.toString())){
          list.confirmed[list.confirmed.indexWhere((element) => element.date==item.date.toString())].list.add(item);
        }else{
          list.confirmed.add(DateItems(item.date.toString(), [item]));
        }
      }
    }
  }
   list.confirmed.sort((b,a)=>getDateFromString(a.date,"yyyy-MM-dd").compareTo(getDateFromString(b.date,"yyyy-MM-dd")));
  return list;
}