import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants.dart';
import '../../../blocs/shift_timesheet_bloc.dart';
import '../../../model/manager_get_time.dart';
import '../../../model/manager_timesheet.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/utils.dart';
import '../../Widgets/buttons/build_button.dart';
import '../../user/home/my_booking_screen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/timesheet_details_list_widget.dart';

class ManagerTimeSheetDetails extends StatefulWidget {
  final TimeSheetInfo? item;

  const ManagerTimeSheetDetails({Key? key, this.item}) : super(key: key);

  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends State<ManagerTimeSheetDetails> {
  var token;
  var time_shhet_id = "85";

  @override
  void initState() {
    observe();
    getDataa();

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    timesheetBloc.dispose();
  }
  Future<void> getDataa() async {
    token = await TokenProvider().getToken();
    print(token);
    if (null != token) {
      setState(() {
        visibility = true;
      });
      timesheetBloc.fetchTimesheetDetails(token!, time_shhet_id);
    } else {
      print("TOKEN NOT FOUND");
    }
  }

  void observe() {
    timesheetBloc.timesheetdetails.listen((event) {
      setState(() {
        visibility = false;
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .4,
                    child: AutoSizeText(
                      "Time Sheet",
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: imageUrl != null
                              ? Image.network(
                            imageUrl,
                            fit: BoxFit.fill,
                          )
                              : Container()),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 10),
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .4,
                          child: AutoSizeText(
                            "Shifts",
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
                      if (snapshot.hasData) {
                        return buildList(snapshot);
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return Container();
                    }),
                SizedBox(
                  height: 5.w,
                ),
                Center(
                  child: Container(
                    child: BuildButton(
                      label: "Approve ",
                      onPressed: () {
                        showAlertDialoge(context, message: "Feacture",
                            title: "This feacture is under development");
                      },
                      key: null,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.w,
                ),

              ],
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

  Widget buildList(AsyncSnapshot<ManagerTimeDetailsResponse> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.response?.data?.timeSheetDetails?.length,
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
                onTapView: () {},
                onTapCall: () {},
                onTapMap: () {},
                onTapBooking: () {
                  print("Tapped");
                  showBookingAlert(context, date: "Show Timesheet");
                },
                key: null,
                onCheckBoxClicked: () {}, onRejectCheckBoxClicked: (){},
              ),
              SizedBox(height: screenHeight(context, dividedBy: 100)),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
