import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/completed_timesheet_bloc.dart';
import '../../../model/approve_data.dart';
import '../../../model/manager_get_time.dart';
import '../../../model/manager_timesheet.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/utils.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/timesheet_details_list_widget.dart';

class CompletedTimeSheetDetails extends StatefulWidget {
  final TimeSheetInfo? item;

  const CompletedTimeSheetDetails({Key? key, this.item}) : super(key: key);

  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends State<CompletedTimeSheetDetails>
    with SingleTickerProviderStateMixin {
  var scrollController = ScrollController();

  @override
  void initState() {
    observe();
    getData();
    super.initState();
  }

  Future<void> getData() async {
    completedTimesheetBloc.token = await TokenProvider().getToken();
    completedTimesheetBloc.time_shhet_id = widget.item!.timeSheetId.toString();
    print(completedTimesheetBloc.token);
    if (null != completedTimesheetBloc.token) {
      completedTimesheetBloc.fetchTimesheetDetails();
    } else {
      print("TOKEN NOT FOUND");
    }
  }

  void observe() {
    completedTimesheetBloc.approvetimesheet.listen((event) {
      var message = event.response?.status?.statusMessage;
      showMessageAndPop(message, context);
    });
    completedTimesheetBloc.timesheetdetails.listen((event) {
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
          completedTimesheetBloc.approveTimeSheet();
        },
        label: const Text(Txt.approve),
        backgroundColor: Colors.green,
      ),
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
                                    child: imageUrl != null
                                        ? InteractiveViewer(
                                            child: CachedNetworkImage(
                                              imageUrl: imageUrl,
                                              imageBuilder: (context, imageProvider) => Container
                                                (
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
                Flexible(
                  fit: FlexFit.loose,
                  child: StreamBuilder(
                      stream: completedTimesheetBloc.timesheetdetails,
                      builder: (BuildContext context,
                          AsyncSnapshot<ManagerTimeDetailsResponse>
                              snapshot) {
                        if (!snapshot.hasData ||
                            null == snapshot.data ||
                            null ==
                                snapshot
                                    .data?.response?.data?.timeSheetDetails) {
                          return const SizedBox();
                        }
                        return buildList(snapshot);
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100.w,
            height: 70.h,
            child: StreamBuilder(
              stream: completedTimesheetBloc.visible,
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

  Widget buildList(AsyncSnapshot<ManagerTimeDetailsResponse> snapshot) {
    var list = snapshot.data?.response?.data?.timeSheetDetails;
    var length = list?.length;
    return ListView.builder(
      itemCount: length,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (null != list) {
          TimeSheetDetails? timeSheetDetails = list[index];
          return Column(
            children: [
              TimeSheetDetailsListWidget(
                items: timeSheetDetails,
                index: index,
                onTapBooking: () {
                  showBookingAlert(context, date: Txt.show_timsheet);
                },
                key: null,
                onCheckBoxClicked: (index, status) {
                  completedTimesheetBloc.approveData[index].status = status;
                },
                textChange: (comment, index) {
                  completedTimesheetBloc.approveData[index].comment = comment;
                },
              ),
              SizedBox(height: screenHeight(context, dividedBy: 100)),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void createApproveData(ManagerTimeDetailsResponse event) {
    var listItem = event.response?.data?.timeSheetDetails;
    if (null != listItem) {
      for (TimeSheetDetails item in listItem) {
        ApproveData data = ApproveData();
        data.timesheetId = completedTimesheetBloc.time_shhet_id;
        data.scheduleId = item.shiftRowId.toString();
        completedTimesheetBloc.approveData.add(data);
      }
    }
  }
}
