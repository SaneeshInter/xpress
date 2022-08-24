import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/sharedPrefKeys.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/shift_notification_bloc.dart';
import '../../../model/notification_model.dart';
import '../../../model/user_notification_model.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/notification_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _NotificationState extends State<NotificationScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime _selectedValue;

  @override
  void didUpdateWidget(covariant NotificationScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    notificationBloc.fetchNotification();
    super.initState();
    clearNotification();
  }

  clearNotification() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    shdPre.setInt(SharedPrefKey.USER_NOTIFICATION_COUNT, 0);
  }

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController = FixedExtentScrollController();
    return Scaffold(
      // key: _scaffoldKey,
      // drawer: Drawer(
      //   child: SideMenu(),
      // ),
      // appBar: AppBarCommon(
      //   _scaffoldKey,
      //   scaffoldKey: _scaffoldKey,
      // ),
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
          //change your color here
        ),
        backgroundColor: HexColor("#ffffff"),
        title: AutoSizeText(
          Txt.notify,
          style: TextStyle(fontSize: 17, color: Constants.colors[1], fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      backgroundColor: Constants.colors[9],
      body: RefreshIndicator(
        onRefresh: () => notificationBloc.fetchNotification(),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth(context, dividedBy: 35)),
                child: Column(children: [
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  StreamBuilder(
                      stream: notificationBloc.allShift,
                      builder: (BuildContext context, AsyncSnapshot<UserNotificationModel> snapshot) {
                        if (snapshot.hasData) {
                          // return Text("fed");
                          debugPrint("asdsdf ${snapshot.data?.response?.data?.items?.length}");

                          return buildList(snapshot);
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Column(children: [
                              SizedBox(height: screenHeight(context, dividedBy: 60)),
                              Column(
                                children: [
                                  20.height,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(Txt.notify, style: boldTextStyle(size: 20)),
                                      85.width,
                                      16.height,
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 32),
                                        child: Text(Txt.no_notify, style: primaryTextStyle(size: 15), textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  150.height,
                                  Image.asset('assets/images/icon/bell.png', height: 250),
                                ],
                              ),
                            ]),
                          );
                        }
                        return const LoadingWidget();
                      })
                ])),
          ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<UserNotificationModel> snapshot) {
    List<NotificationModel> list = [];
    if (snapshot.data?.response?.data?.items?.length != 0) {
      for (var item in snapshot.data!.response!.data!.items!) {
        if (list.any((element) => DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(element.date.toString() !="null"?element.date:"2000-01-01 01:44:01")) ==DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(item.date.toString()!="null"?item.date.toString():"2000-01-01 01:44:01")))) {
          // print("Notification Date: ${item.date}");
          list[list.indexWhere((element) => DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(element.date.toString() !="null"?element.date:"2000-01-01 01:44:01")) ==DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(item.date.toString()!="null"?item.date.toString():"2000-01-01 01:44:01")) )].list.add(NotificationItemModel(
                title: item.notificationTypeName.toString(),
                image: item.hospitalImage.toString(),
                subtitle: item.shiftTitle.toString(),
                date: item.date.toString(),
                shiftid: item.shiftId.toString(),
              ));

        } else {
          list.add(NotificationModel(date: item.date.toString()!="null"?item.date.toString():"2000-01-01 01:44:01", list: [
            NotificationItemModel(
              title: item.notificationTypeName.toString(),
              image: item.hospitalImage.toString(),
              subtitle: item.shiftTitle.toString(),
              date: item.date.toString(),
              shiftid: item.shiftId.toString(),
            )
          ]));
        }
        list.sort((b,a)=>DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(a.date !="null"?a.date:"2000-01-01 01:44:01")).compareTo(DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(b.date !="null"?b.date:"2000-01-01 01:44:01"))));
      }
      ;
    }

    return (snapshot.data?.response?.data?.items?.length ?? 0) != 0
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int ind) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Text(getDateFromString(list[ind].date, "yyyy-MM-dd").isToday
                        ? "Today"
                        : getDateFromString(list[ind].date, "yyyy-MM-dd").isTomorrow
                        ? "Tomorrow"
                        : getDateFromString(list[ind].date, "yyyy-MM-dd").isYesterday
                        ? "Yesterday"
                        :
                      getStringFromDate(getDateFromString(list[ind].date, "yyyy-MM-dd"), "EEE dd MMMM yyyy"),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'SFProBold', color: Colors.grey),
                      //  list[ind].date
                    ),
                  ),
                  ListView.builder(
                    itemCount: list[ind].list.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      NotificationItemModel data = list[ind].list[index];
                      return NotificationWidget(
                        name: data.title,
                        date: data.date,
                        endTime: "",
                        type: "USER",
                        price: data.shiftid,
                        startTime: data.image,
                      );
                    },
                  ),
                ],
              );
            },
          )
        : Center(
            child: Column(children: [
              SizedBox(height: screenHeight(context, dividedBy: 60)),
              Column(
                children: [
                  20.height,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(Txt.notify, style: boldTextStyle(size: 20)),
                      85.width,
                      16.height,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(Txt.no_notify, style: primaryTextStyle(size: 15), textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  150.height,
                  Image.asset('assets/images/icon/bell.png', height: 250),
                ],
              ),
            ]),
          );
  }
}
