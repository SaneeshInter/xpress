import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

class _CreateShiftState extends State<ManagerTimeSheetDetails> with SingleTickerProviderStateMixin {
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
    print(timesheetBloc.token);
    if (null != timesheetBloc.token) {
      timesheetBloc.fetchTimesheetDetails();
    } else {
      print("TOKEN NOT FOUND");
    }
  }

  void observe() {
    timesheetBloc.approvetimesheet.listen((event) {
      var message = event.response?.status?.statusMessage;
      showMessageAndPop(message, context);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          timesheetBloc.approveTimeSheet();
        },
        label: const Text(Txt.approve),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      mainAxisSize: MainAxisSize.min,
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
                                child: SizedBox(
                                    height: 60.h,
                                    child: imageUrl != null
                                        ? InteractiveViewer(
                                            child: CachedNetworkImage(
                                              useOldImageOnUrlChange: false,
                                              imageUrl: imageUrl,
                                              imageBuilder: (context, imageProvider) => Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) => Image.asset("assets/images/icon/loading_bar.gif"),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    child: TabBar(unselectedLabelColor: Colors.black, indicatorSize: TabBarIndicatorSize.tab, labelColor: Colors.black, controller: _tabController, tabs: [
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(Txt.pending),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(Txt.completed),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    child: StreamBuilder(
                        stream: timesheetBloc.timesheetdetails,
                        builder: (BuildContext context, AsyncSnapshot<ManagerTimeDetailsResponse> snapshot) {
                          if (!snapshot.hasData || null == snapshot.data || null == snapshot.data?.response?.data?.timeSheetDetails) {
                            return Container();
                          }
                          return TabBarView(controller: _tabController, children: [
                            bookingList(0, snapshot),
                            bookingList(1, snapshot),
                          ]);
                        }),
                  ),
                ),
              ],
            ),
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
    );
  }

  Widget bookingList(int position, AsyncSnapshot<ManagerTimeDetailsResponse> snapshot) {
    return buildList(snapshot, position);
  }

  FilterShiftList getFilterList(AsyncSnapshot<ManagerTimeDetailsResponse> snapshot, int position) {
    FilterShiftList list = FilterShiftList();

    List<TimeSheetDetails>? allList = snapshot.data?.response?.data?.timeSheetDetails;
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

  Widget buildList(AsyncSnapshot<ManagerTimeDetailsResponse> snapshot, int position) {
    var allList = getFilterList(snapshot, position);
    var list = [];
    if (position == 0) {
      list = allList.pending;
    }
    if (position == 1) {
      list = allList.completed;
    }
    var length = list.length;
    return ListView.builder(
      itemCount: length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        TimeSheetDetails? timeSheetDetails = list[index];
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
                  timesheetBloc.approveData[index].status = status;
                },
                textChange: (comment, index) {
                  timesheetBloc.approveData[index].comment = comment;
                },
              ),
            SizedBox(height: screenHeight(context, dividedBy: 100)),
          ],
        );
      },
    );
  }

  void createApproveData(ManagerTimeDetailsResponse event) {
    var listItem = event.response?.data?.timeSheetDetails;
    if (null != listItem) {
      for (TimeSheetDetails item in listItem) {
        ApproveData data = ApproveData();
        data.timesheetId = timesheetBloc.time_shhet_id;
        data.scheduleId = item.shiftRowId.toString();
        timesheetBloc.approveData.add(data);
      }
    }
  }
}
