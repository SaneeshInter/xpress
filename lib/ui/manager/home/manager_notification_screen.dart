import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/sharedPrefKeys.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/manager_notification_bloc.dart';
import '../../../model/user_notification_model.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/notification_widget.dart';

class ManagerNotificationScreen extends StatefulWidget {
  const ManagerNotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _NotificationState extends State<ManagerNotificationScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime _selectedValue;

  @override
  void didUpdateWidget(covariant ManagerNotificationScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    managerNotificationBloc.fetchNotification();
    super.initState();
    clearNotification();
  }
  clearNotification() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    shdPre.setInt(SharedPrefKey.USER_NOTIFICATION_COUNT,0);
  }
  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
    FixedExtentScrollController();
    return Scaffold(

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
          style: TextStyle(
              fontSize: 17,
              color: Constants.colors[1],
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      backgroundColor: Constants.colors[2],
      body: RefreshIndicator(
        onRefresh: () => managerNotificationBloc.fetchNotification(),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, dividedBy: 35)),
                child: Column(children: [
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  StreamBuilder(
                      stream: managerNotificationBloc.allShift,
                      builder: (BuildContext context,
                          AsyncSnapshot<UserNotificationModel> snapshot) {
                        if (snapshot.hasData) {
                          // return Text("fed");
                          debugPrint("asdsdf ${snapshot.data?.response?.data?.items?.length}");

                          return buildList(snapshot);
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Column(children: [
                              SizedBox(
                                  height: screenHeight(context, dividedBy: 60)),
                              Column(
                                children: [
                                  20.height,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(Txt.notify,
                                          style: boldTextStyle(size: 20)),
                                      85.width,
                                      16.height,
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 32),
                                        child: Text(Txt.no_notify,
                                            style: primaryTextStyle(size: 15),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  150.height,
                                  Image.asset('assets/images/icon/bell.png',
                                      height: 250),
                                ],
                              ),
                            ]),
                          );
                        }
                        return  const LoadingWidget();
                      })
                ])),
          ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<UserNotificationModel> snapshot) {
    return (snapshot.data?.response?.data?.items?.length ?? 0)!=0? ListView.builder(
      itemCount: snapshot.data?.response?.data?.items?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var name = "Shift Reminder";
        var description = "Your shift at Beneavin Manor is in  1 hour";

        debugPrint("asdsdf ${snapshot.data?.response?.data?.items?.length}");
        var notification = snapshot.data?.response?.data?.items?[index];
        // if (notification != null) {
        name = notification?.notificationTypeName??" ";
        description = notification?.shiftTitle??"";
        // }

        return NotificationWidget(
          name: name,
          date: notification?.date??"",
          endTime: "",
          price: notification?.shiftId.toString()??"",
          startTime: notification?.hospitalImage??"", type: 'MANAGER',

        );
      },
    ):Center(
      child: Column(children: [
        SizedBox(
            height: screenHeight(context, dividedBy: 60)),
        Column(
          children: [
            20.height,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Txt.notify,
                    style: boldTextStyle(size: 20)),
                85.width,
                16.height,
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32),
                  child: Text(Txt.no_notify,
                      style: primaryTextStyle(size: 15),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            150.height,
            Image.asset('assets/images/icon/bell.png',
                height: 250),
          ],
        ),
      ]),
    );
  }
}