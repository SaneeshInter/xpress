import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/shift_timesheet_bloc.dart';
import '../../../model/approve_data.dart';
import '../../../model/filter_shift_list.dart';
import '../../../model/manager_get_time.dart';
import '../../../model/manager_timesheet.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/utils.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/timesheet_details_list_widget.dart';

class ManagerTimeSheetDetails extends StatefulWidget {
  final TimeSheetInfo? item;

  const ManagerTimeSheetDetails({Key? key, this.item}) : super(key: key);

  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends State<ManagerTimeSheetDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var scrollController = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    observe();
    getData();

    super.initState();
  }

  Future<void> getData() async {
    timesheetBloc.token = await TokenProvider().getToken();
    timesheetBloc.time_shhet_id = widget.item!.timeSheetId.toString();
    debugPrint(timesheetBloc.token.toString());
    if (null != timesheetBloc.token) {
      timesheetBloc.fetchTimesheetDetails();
    } else {
      debugPrint("TOKEN NOT FOUND");
    }
  }

  void observe() {
    timesheetBloc.approveTimeSheets.listen((event) {
      var message = event.response?.status?.statusMessage;
      if (mounted) {
        showMessageAndPop(message, context);
      }
    });
    timesheetBloc.timeSheetDetails.listen((event) {
      createApproveData(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    String? imageUrl = widget.item?.timeSheetLink??"";
    return Scaffold(
      backgroundColor: Constants.colors[9],
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     timesheetBloc.approveTimeSheet(timesheetBloc.approveData);
      //   },
      //   label: const Text(Txt.approve),
      //   backgroundColor: Colors.green,
      // ),
      body: Stack(
        children: [
          NestedScrollView(
            controller: scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: SizedBox(
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
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                    height: 60.h,
                                    child: imageUrl != ""
                                        ? InteractiveViewer(
                                            child: CachedNetworkImage(
                                              useOldImageOnUrlChange: false,
                                              imageUrl: imageUrl,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      "assets/images/icon/loading_bar.gif"),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          )
                                        : Container(
                                            height: 10,
                                            color: Colors.red,
                                          )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 10),
                                child: SizedBox(
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
                      ],
                    ),
                  ]),
                ),
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                PreferredSize(
                  preferredSize: const Size.fromHeight(65),
                  child: Container(
                    color: Constants.colors[0],
                    child: TabBar(
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.black,
                        controller: _tabController,
                        tabs: const [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(Txt.pending),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(Txt.completed),
                            ),
                          ),
                        ]),
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.loose,
                  child: StreamBuilder(
                      stream: timesheetBloc.timeSheetDetails,
                      builder: (BuildContext context,
                          AsyncSnapshot<ManagerTimeDetailsResponse> snapshot) {
                        if (!snapshot.hasData ||
                            null == snapshot.data ||
                            null ==
                                snapshot
                                    .data?.response?.data?.timeSheetDetails) {
                          return Container();
                        }
                        return TabBarView(
                            controller: _tabController,
                            children: [
                              bookingList(0, snapshot),
                              bookingList(1, snapshot),
                            ]);
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
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
    );
  }

  Widget bookingList(
      int position, AsyncSnapshot<ManagerTimeDetailsResponse> snapshot) {
    return buildList(snapshot, position);
  }

  FilterShiftList getFilterList(
      AsyncSnapshot<ManagerTimeDetailsResponse> snapshot, int position) {
    FilterShiftList list = FilterShiftList();

    List<TimeSheetDetails>? allList =
        snapshot.data?.response?.data?.timeSheetDetails;
    if (null != allList) {
      for (var item in allList) {
        if (item.time_sheet_detail_status == 0) {
          list.pending.add(item);
        } else {
          list.completed.add(item);
        }
      }
    }
    return list;
  }

  Widget buildList(
      AsyncSnapshot<ManagerTimeDetailsResponse> snapshot, int position) {
    List<ApproveData> approveData = [];
    var allList = getFilterList(snapshot, position);
    var list = [];
    if (position == 0) {
      list = allList.pending;
    }
    if (position == 1) {
      list = allList.completed;
    }
    var length = list.length;
    return length!=0?
    ListView.builder(
      itemCount: length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {


        TimeSheetDetails? timeSheetDetails = list[index];
        approveData.add(ApproveData(
          scheduleId: timeSheetDetails?.shiftRowId.toString(),
          timesheetId: timesheetBloc.time_shhet_id,
          status: timeSheetDetails?.time_sheet_detail_status.toString(),
        ));
        if (index == length - 1) {
          return Column(
            children: [
              if (null != timeSheetDetails)
                TimeSheetDetailsListWidget(
                  items: timeSheetDetails,
                  index: index,
                  onTapBooking: () {
                    showBookingAlert(context, date: Txt.show_timsheet);
                  },
                  key: null,
                  onCheckBoxClicked: (index, status) {
                      debugPrint("dsjfkdsnjfk ${approveData[index].status} ${ timesheetBloc.approveData[index].status}   $status");
                    timesheetBloc.approveData[index].status = status;
                    approveData[index].status = status;
                  },
                  textChange: (comment, index) {
                    timesheetBloc.approveData[index].comment = comment;
                    approveData[index].comment = comment;
                    approveData[index].status = timesheetBloc.approveData[index].status;
                  },
                ),
              SizedBox(height: screenHeight(context, dividedBy: 100)),
              if (position == 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: GestureDetector(
                    onTap: () {
                      timesheetBloc.approveTimeSheet(approveData);
                    },
                    child: Container(
                      width: 80.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Constants.colors[3],
                                Constants.colors[4],
                              ]),
                          color: Constants.colors[3],
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "PROCESSED",
                        style: TextStyle(
                            fontSize: 12.5.sp,
                            color: Constants.colors[0],
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: MaterialButton(shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)),
              //     minWidth: double.infinity,
              //     onPressed: () {
              //       timesheetBloc.approveTimeSheet(approveData);
              //     },
              //     color: Colors.green,
              //     child: const Text(
              //       "Submit", style: TextStyle(color: white),),),
              // ),
            ],
          );
        } else {
          return Column(
            children: [
              if (null != timeSheetDetails)
                TimeSheetDetailsListWidget(
                  items: timeSheetDetails,
                  index: index,
                  onTapBooking: () {
                    showBookingAlert(context, date: Txt.show_timsheet);
                  },
                  key: null,
                  onCheckBoxClicked: (index, status) {
                    debugPrint("dsjfkdsnjfk ${approveData[index].status} ${ timesheetBloc.approveData[index].status}   $status");
                    timesheetBloc.approveData[index].status = status;
                    approveData[index].status = status;
                  },
                  textChange: (comment, index) {
                    debugPrint("dsjfkdsnjfk ${approveData[index].status} ${ timesheetBloc.approveData[index].status}   ");
                    timesheetBloc.approveData[index].comment = comment;
                    approveData[index].comment = comment;
                    approveData[index].status = timesheetBloc.approveData[index].status;
                  },
                ),
              SizedBox(height: screenHeight(context, dividedBy: 100)),
            ],
          );
        }
      },
    ):
    Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.height,
            Text("No Data Found",
                style: boldTextStyle(size: 20)),
            16.height,
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32),
              child: Text(position==0?"No Pending Timesheet":"No Completed Timesheet",
                  style: primaryTextStyle(size: 15),
                  textAlign: TextAlign.center),
            ),
            50.height,
            Image.asset('assets/images/error/empty_task.png',height: 250,),

          ],
        ),
      ),
    );
  }

  void createApproveData(ManagerTimeDetailsResponse event) {
    var listItem = event.response?.data?.timeSheetDetails;
    if (null != listItem) {
      timesheetBloc.approveData.clear();
      for (TimeSheetDetails item in listItem) {
        ApproveData data = ApproveData();
        data.timesheetId = timesheetBloc.time_shhet_id;
        data.scheduleId = item.shiftRowId.toString();
        timesheetBloc.approveData.add(data);
      }
    }
  }
}
