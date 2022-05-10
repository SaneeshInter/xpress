import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/blocs/user_timesheet_bloc.dart';

import '../../../../utils/constants.dart';
import '../../../model/user_get_timesheet.dart';
import '../../../model/user_time_sheet_details_respo.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/utils.dart';
import '../../user/home/my_booking_screen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/user_timesheet_details_list_widget.dart';

class UserTimeSheetDetails extends StatefulWidget {
  final TimeSheetInfo? item;

  const UserTimeSheetDetails({Key? key, this.item}) : super(key: key);

  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends State<UserTimeSheetDetails> {
  var token;
  String? time_shhet_id = "";

  @override
  void initState() {
    observe();
    getDataa();

    super.initState();
  }

  Future<void> getDataa() async {
    token = await TokenProvider().getToken();
    time_shhet_id = widget.item?.timeSheetId.toString();
    print(token);
    if (null != token) {
      setState(() {
        visibility = true;
      });
      // timesheetBloc.fetchTimesheetDetails(token!, time_shhet_id!);
      usertimesheetBloc.userGetTimeSheetDetails(token, time_shhet_id!);
    } else {
      print("TOKEN NOT FOUND");
    }
  }

  void observe() {
    usertimesheetBloc.timedetailststream.listen((event) {
      // setState(() {
      //   visibility = false;
      // });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String? imageUrl = widget.item?.timeSheetLink;
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
        iconTheme: IconThemeData(
          color: Colors.black,
          //change your color here
        ),
        backgroundColor: HexColor("#ffffff"),
        title: AutoSizeText(
          "Timesheet Details",
          style: TextStyle(
              fontSize: 17,
              color: Constants.colors[1],
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
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
                  width: MediaQuery.of(context).size.width,
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
                          width: MediaQuery.of(context).size.width * .4,
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
                    stream: usertimesheetBloc.timedetailststream,
                    builder: (BuildContext context,
                        AsyncSnapshot<UserTimeSheetDetailsRespo> snapshot) {
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

  Widget buildList(AsyncSnapshot<UserTimeSheetDetailsRespo> snapshot) {
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
              UserTimeSheetDetailsListWidget(
                items: timeSheetDetails!,
                onTapView: () {},
                onTapCall: () {},
                onTapMap: () {},
                onTapBooking: () {
                  print("Tapped");
                  showBookingAlert(context, date: "Show Timesheet");
                },
                key: null,
                onCheckBoxClicked: () {},
                onRejectCheckBoxClicked: () {},
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
