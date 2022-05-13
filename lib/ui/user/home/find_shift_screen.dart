import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/model/user_getschedule_bydate.dart';

import '../../../Constants/sharedPrefKeys.dart';
import '../../../blocs/shift_list_bloc.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../datepicker/date_picker_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/shift_list_widget.dart';
import '../detail/shift_detail.dart';

class FindShiftScreen extends StatefulWidget {
  @override
  _FindShiftScreenState createState() => _FindShiftScreenState();
}

class _FindShiftScreenState extends State<FindShiftScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool visibility = false;
  var token;

  @override
  void initState() {
    super.initState();
    observe();
    getData(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    return Scaffold(
      key: _scaffoldKey,
      // drawer: Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: SideMenu(),
      // ),
      // appBar: AppBarCommon(
      //   _scaffoldKey,
      //   scaffoldKey: _scaffoldKey,
      // ),
      backgroundColor: Constants.colors[9],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, dividedBy: 35)),
                child: Column(children: [
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Constants.colors[3],
                    selectedTextColor: Colors.white,
                    width: 18.w,
                    height: 22.w,
                    deactivatedColor: Colors.blue,
                    monthTextStyle: TextStyle(color: Colors.transparent),
                    dateTextStyle: TextStyle(
                        color: Constants.colors[7],
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp),
                    dayTextStyle: TextStyle(
                        color: Constants.colors[7],
                        fontWeight: FontWeight.w500,
                        fontSize: 4.sp),
                    selectedDateStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp),
                    selectedDayStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 4.sp),
                    itemController: itemController,
                    onDateChange: (date, x) async {
                      getData(date);
                    },
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  StreamBuilder(
                      stream: bloc.shiftbydate,
                      builder: (BuildContext context,
                          AsyncSnapshot<UserGetScheduleByDate> snapshot) {
                        if (snapshot.hasData) {
                          return buildList(snapshot);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Column(
                          children: [
                            20.height,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Empty Shifts',
                                    style: boldTextStyle(size: 20)),
                                85.width,
                                16.height,
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  child: Text('There are no shift found.',
                                      style: primaryTextStyle(size: 15),
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                            150.height,
                            Image.asset('assets/images/error/empty_task.png',
                                height: 250),
                          ],
                        );
                      }),

                  // StreamBuilder(builder: (context,Asy))
                ])),
            Center(
              child: Visibility(
                visible: visibility,
                child: Container(
                  width: 100.w,
                  height: 80.h,
                  child: const Center(
                    child: LoadingWidget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<UserGetScheduleByDate> snapshot) {
    var items = snapshot.data?.response?.data?.items;
    if (null != items && items.isNotEmpty) {
      return ListView.builder(
        itemCount: snapshot.data?.response?.data?.items?.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var items = snapshot.data?.response?.data?.items?[index];
          if (null != items) {
            return Column(
              children: [
                ShiftListWidget(
                  items: items,
                  token: token,
                  onTapDelete: () {},
                  onTapViewMap: () {},
                  onTapView: (item) {
                    if (items is Items) {
                      Items data = items;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShiftDetailScreen(
                                  shift_id: data.rowId.toString(),
                                  isCompleted: false,
                                )),
                      );
                    }
                  },
                  onTapBook: (item) {
                    requestShift(items);
                  },
                  onTapEdit: () {
                    print("Tapped");
                  },
                  key: null,
                ),
                SizedBox(height: screenHeight(context, dividedBy: 100)),
              ],
            );
          } else {
            print("items.hospital");
            return Container();
          }
        },
      );
    } else {
      return Column(
        children: [
          20.height,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Empty Shifts', style: boldTextStyle(size: 20)),
              85.width,
              16.height,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text('There are no shift found.',
                    style: primaryTextStyle(size: 15),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
          150.height,
          Image.asset('assets/images/error/empty_task.png', height: 250),
        ],
      );
    }
  }

  void requestShift(Items items) {
    setState(() {
      visibility = true;
    });
    if (items is Items) {
      Items data = items;
      bloc.fetchuserJobRequest(token, data.rowId.toString());
    }
  }

  Future<void> getData(DateTime date) async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    token = shdPre.getString(SharedPrefKey.AUTH_TOKEN);
    if (null != token) {
      setState(() {
        visibility = true;
      });
      bloc.fetchgetUserScheduleByDate(token, date.toString());
    }
  }

  void observe() {
    bloc.jobrequest.listen((event) {
      setState(() {
        visibility = false;
      });
      String? message = event.response?.status?.statusMessage;
      showAlertDialoge(context, message: message!, title: "Request");
    });
    bloc.shiftbydate.listen((event) {
      setState(() {
        visibility = false;
      });
    });
  }
}
