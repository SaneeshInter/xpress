import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../blocs/shift_notification_bloc.dart';
import '../../../model/shift_list_response.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../widgets/notification_widget.dart';
import '../common/app_bar.dart';
import '../common/side_menu.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: SideMenu(),
        ),
        appBar: AppBarCommon(
          _scaffoldKey,
          scaffoldKey: _scaffoldKey,
        ),
        backgroundColor: Constants.colors[2],
        body: SingleChildScrollView(
          child: Center(
            child: Container(

                child: Column(children: [
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  Column(
                    children: [
                      20.height,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Notificaions', style: boldTextStyle(size: 20)),
                          85.width,
                          16.height,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Text('There are no notifications found.',
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
                  // StreamBuilder(
                  //     stream: notificationBloc.allShift,
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<SliftListRepso> snapshot) {
                  //       if (snapshot.hasData) {
                  //         return buildList(snapshot);
                  //       } else if (snapshot.hasError) {
                  //         return Text(snapshot.error.toString());
                  //       }
                  //       return Center(child: CircularProgressIndicator());
                  //     })
                ])),
          ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<SliftListRepso> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.response?.data?.category?.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var name = "Shift Reminder";
        var description = "Your shift at Beneavin Manor is in  1 hour";

        var category = snapshot.data?.response?.data?.category![index];
        if (category != null) {
          name = category.categoryname!;
          name = category.categoryname!;
        }

        return Column(
          children: [
            NotificationWidget(
              name: name,
              endTime: description,
              onTapView: () {},
              onTapCall: () {},
              onTapMap: () {},
              onTapBooking: () {
                print("Tapped");
                showBookingAlert(context, date: "Saturday 19th February 2022");
              },
              price: '100',
              startTime: '',
            ),
            SizedBox(height: screenHeight(context, dividedBy: 100)),
          ],
        );
      },
    );
  }
}
