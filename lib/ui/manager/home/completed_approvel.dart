import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Constants/strings.dart';
import '../../../blocs/manager_completed_approvel.dart';
import '../../../model/manager_timesheet.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../Widgets/approve_timesheet_list_widget.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/loading_widget.dart';
import 'completed_time_sheet_details.dart';

class CompletedApprovelScreen extends StatefulWidget {
  const CompletedApprovelScreen({Key? key}) : super(key: key);

  @override
  _CompletedApprovelScreenState createState() =>
      _CompletedApprovelScreenState();
}

class _CompletedApprovelScreenState extends State<CompletedApprovelScreen> {
  @override
  void didUpdateWidget(covariant CompletedApprovelScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    compeletedApprovelBloc.token = await TokenProvider().getToken();
    if (null != compeletedApprovelBloc.token) {
      if (await isNetworkAvailable()) {
        compeletedApprovelBloc.completedApprovel();
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    return Scaffold(
      backgroundColor: Constants.colors[9],
      body: Stack(
        children: [
          RefreshIndicator(
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
                        SizedBox(height: screenHeight(context, dividedBy: 60)),
                        StreamBuilder(
                            stream: compeletedApprovelBloc.timesheet,
                            builder: (BuildContext context,
                                AsyncSnapshot<ManagerTimeSheetResponse>
                                    snapshot) {
                              if (!snapshot.hasData ||
                                  null == snapshot.data ||
                                  null ==
                                      snapshot.data?.response?.data
                                          ?.timeSheetInfo) {
                                return const SizedBox();
                              }
                              return buildList(snapshot);
                            })
                      ])),
                )
              ],
            ),
          ),
          Center(
            child: StreamBuilder(
              stream: compeletedApprovelBloc.visible,
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
          ),
        ],
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
            if (null != timeSheetInfo)
              TimeSheetApproveListWidget(
                items: timeSheetInfo,
                onTapView: (items) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CompletedTimeSheetDetails(
                              item: items,
                            )),
                  ).then((value) => getData());
                },
                onTapCall: () {},
                onTapMap: () {},
                onTapBooking: () {
                  print("Tapped");
                  showBookingAlert(context, date: Txt.show_timsheet);
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
