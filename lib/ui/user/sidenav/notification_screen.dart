import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/shift_notification_bloc.dart';
import '../../../model/shift_list_response.dart';
import '../../../utils/colors_util.dart';
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
    return Scaffold(
      key: _scaffoldKey,
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
          style: TextStyle(
              fontSize: 17,
              color: Constants.colors[1],
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      backgroundColor: Constants.colors[2],
      body: SingleChildScrollView(
        child: Center(
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
                      padding: EdgeInsets.symmetric(horizontal: 32),
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
                showBookingAlert(context, date:Txt.sat_feb);
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
