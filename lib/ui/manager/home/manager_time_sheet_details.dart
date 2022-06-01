import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/shift_timesheet_bloc.dart';
import '../../../model/approve_data.dart';
import '../../../model/manager_get_time.dart';
import '../../../model/manager_timesheet.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/utils.dart';
import '../../Widgets/buttons/book_button.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/timesheet_details_list_widget.dart';

class ManagerTimeSheetDetails extends StatefulWidget {
  final TimeSheetInfo? item;

  const ManagerTimeSheetDetails({Key? key, this.item}) : super(key: key);

  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends State<ManagerTimeSheetDetails> {
  @override
  void initState() {
    observe();
    getData();
    super.initState();
  }

  Future<void> getData() async {
    timesheetBloc.token = await TokenProvider().getToken();
    timesheetBloc.time_shhet_id = widget.item!.timeSheetId.toString();
    print(timesheetBloc.token);
    if (null != timesheetBloc.token) {
      timesheetBloc.fetchTimesheetDetails();
    } else {
      print("TOKEN NOT FOUND");
    }
  }

  void observe() {
    timesheetBloc.approvetimesheet.listen((event) {
      Navigator.pop(context);
      var message = event.response?.status?.statusMessage;
      showAlertDialoge(context,
          title: Txt.timesheet_updated, message: message!);
    });
    timesheetBloc.timesheetdetails.listen((event) {
      createApproveData(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    String? imageUrl = widget.item?.timeSheetLink;
    return Scaffold(
      backgroundColor: Constants.colors[9],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .4,
                    child: AutoSizeText(
                      Txt.time_sheet,
                      maxLines: 1,
                      style: TextStyle(
                        color: Constants.colors[1],
                        fontSize: 13.sp,
                        fontFamily: "SFProMedium",
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            height: 60.h,
                            child: imageUrl != null
                                ? InteractiveViewer(
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/images/icon/loading_bar.gif',
                                      image: imageUrl,
                                      placeholderScale: 1,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 10,
                                    color: Colors.red,
                                  )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          child: AutoSizeText(
                            Txt.shifts,
                            maxLines: 1,
                            style: TextStyle(
                              color: Constants.colors[1],
                              fontSize: 13.sp,
                              fontFamily: "SFProMedium",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight(context, dividedBy: 60)),
                StreamBuilder(
                    stream: timesheetBloc.timesheetdetails,
                    builder: (BuildContext context,
                        AsyncSnapshot<ManagerTimeDetailsResponse> snapshot) {
                      if (!snapshot.hasData ||
                          null == snapshot.data ||
                          null ==
                              snapshot.data?.response?.data?.timeSheetDetails) {
                        return Container();
                      }
                      return buildList(snapshot);
                    }),
                SizedBox(
                  height: 10.w,
                ),
              ],
            ),
            Container(
              width: 100.w,
              height: 70.h,
              child: StreamBuilder(
                stream: timesheetBloc.visible,
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!) {
                      return const Center(child: LoadingWidget());
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ManagerTimeDetailsResponse> snapshot) {
    var length = snapshot.data?.response?.data?.timeSheetDetails?.length;

    return Column(
      children: [
        ListView.builder(
          itemCount: length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (null != snapshot.data?.response?.data?.timeSheetDetails) {
              TimeSheetDetails? timeSheetDetails =
                  snapshot.data?.response?.data?.timeSheetDetails![index];
              return Column(
                children: [
                  TimeSheetDetailsListWidget(
                    items: timeSheetDetails!,
                    index: index,
                    onTapBooking: () {
                      print("Tapped");
                      showBookingAlert(context, date: Txt.show_timsheet);
                    },
                    key: null,
                    onCheckBoxClicked: (index, status) {
                      timesheetBloc.approveData[index].status = status;
                    },
                    textChange: (comment, index) {
                      timesheetBloc.approveData[index].comment = comment;
                    },
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 100)),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(
          height: 5.w,
        ),
        if (length != 0)
          Center(
            child: BookButton(
              label: Txt.approve,
              onPressed: () {
                timesheetBloc.approveTimeSheet();
              },
              key: null,
            ),
          ),
      ],
    );
  }

  void createApproveData(ManagerTimeDetailsResponse event) {
    var listItem = event.response?.data?.timeSheetDetails;
    for (TimeSheetDetails item in listItem!) {
      ApproveData data = ApproveData();
      data.timesheetId = timesheetBloc.time_shhet_id;
      data.scheduleId = item.shiftRowId.toString();
      timesheetBloc.approveData.add(data);
    }
  }
}
