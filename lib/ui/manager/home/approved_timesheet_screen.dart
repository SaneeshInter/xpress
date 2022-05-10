import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/blocs/shift_timesheet_bloc.dart';
import 'package:xpresshealthdev/model/manager_timesheet.dart';
import 'package:xpresshealthdev/ui/user/home/my_booking_screen.dart';

import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../Widgets/approve_timesheet_list_widget.dart';
import '../../widgets/loading_widget.dart';

class ApprovedTimeSheetScreen extends StatefulWidget {
  const ApprovedTimeSheetScreen({Key? key}) : super(key: key);

  @override
  _ApprovedTimeSheetState createState() => _ApprovedTimeSheetState();
}

class _ApprovedTimeSheetState extends State<ApprovedTimeSheetScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime _selectedValue;
  var token;

  @override
  void didUpdateWidget(covariant ApprovedTimeSheetScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    observe();
    getData();
    super.initState();
  }

  Future<void> getData() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      setState(() {
        visibility = true;
      });
      timesheetBloc.fetchTimesheet(
        token!,
      );
    } else {
      print("TOKEN NOT FOUND");
    }
  }

  void observe() {
    timesheetBloc.timesheet.listen((event) {
      setState(() {
        visibility = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.colors[9],
        body: Stack(
          children: [
            LiquidPullToRefresh(

              onRefresh: () async {
                getData();
              },
              child: ListView(
                children: [
                  SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context, dividedBy: 35)),
                        child: Column(children: [
                          SizedBox(
                              height: screenHeight(context, dividedBy: 60)),
                          StreamBuilder(
                              stream: timesheetBloc.timesheet,
                              builder: (BuildContext context,
                                  AsyncSnapshot<ManagerTimeSheetResponse>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  return buildList(snapshot);
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                return Container();
                              })
                        ])),
                  )
                ],
              ),
            ),
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

  Widget buildList(AsyncSnapshot<ManagerTimeSheetResponse> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.response?.data?.timeSheetInfo?.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        TimeSheetInfo? timeSheetInfo =
            snapshot.data?.response?.data?.timeSheetInfo![index];

        return Column(
          children: [
            TimeSheetApproveListWidget(
              items: timeSheetInfo!,
              onTapView: () {},
              onTapCall: () {},
              onTapMap: () {},
              onTapBooking: () {
                print("Tapped");
                showBookingAlert(context, date: "Show Timesheet");
              },
              key: null,
            ),
            SizedBox(height: screenHeight(context, dividedBy: 100)),
          ],
        );
      },
    );
  }
}
