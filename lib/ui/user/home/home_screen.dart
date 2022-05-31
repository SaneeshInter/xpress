import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/model/user_home_response.dart';
import 'package:xpresshealthdev/ui/user/detail/home_card_item.dart';
import 'package:xpresshealthdev/ui/user/home/availability_list_screen.dart';

import '../../../Constants/AppColors.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/shift_homepage_bloc.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/buttons/drawable_button.dart';
import '../../widgets/buttons/home_button.dart';
import '../../widgets/loading_widget.dart';
import '../detail/shift_detail.dart';
import 'completed_shift_screen.dart';
import 'my_booking_screen.dart';
import 'my_shift_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreentate createState() => _HomeScreentate();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreentate extends State<HomeScreen> {
  final PageController ctrl = PageController(
    viewportFraction: .7,
  );
  double? currentPage = 0;
  bool visibility = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var token;
  var shiftDetails;
  late PageController pageController;

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {
        homepageBloc.fetchUserHomepage(token);
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
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    pageCount = 3;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.colors[9],
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<UserHomeResponse>(
                    stream: homepageBloc.userhomeStream,
                    builder:
                        (context, AsyncSnapshot<UserHomeResponse> snapshot) {
                      var data = snapshot.data?.response?.data;
                      if (data != null) {
                        if (data.latestShift!.length != 0) {
                          shiftDetails = data.latestShift![0];
                        }
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (null != shiftDetails)
                                AutoSizeText(
                                  Txt.next_shift,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "SFProMedium",
                                  ),
                                ),
                              if (null == shiftDetails)
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showMaterialBanner(MaterialBanner(
                                          padding: EdgeInsets.all(20),
                                          leading: Icon(Icons.info_outline,
                                              color: Colors.white),
                                          backgroundColor: appColorPrimary,
                                          content: Text(
                                              Txt.you_have_no_shifts_booked,
                                              style: primaryTextStyle(
                                                  color: Colors.white)),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(Txt.cancel,
                                                  style: secondaryTextStyle(
                                                      size: 16,
                                                      color: Colors.white
                                                          .withOpacity(0.5))),
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentMaterialBanner();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(Txt.done,
                                                  style: primaryTextStyle(
                                                      color: Colors.white)),
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentMaterialBanner();
                                              },
                                            ),
                                          ],
                                        ));
                                      },
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              Txt.there_are_no_shifts_booked,
                                              style: TextStyle(
                                                color: Constants.colors[1],
                                                fontSize: 12.sp,
                                                fontFamily: "SFProMedium",
                                              ),
                                            ),
                                            Icon(Icons.info_outline,
                                                color: Colors.black)
                                          ],
                                        ),
                                      )),
                                ),
                              if (null != shiftDetails)
                                SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 100)),
                              if (null != shiftDetails)
                                Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 0.0,
                                      child: GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 22, 5, 22),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 10, 0.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Container(
                                                    height: 18.w,
                                                    width: 18.w,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Constants.colors[4],
                                                            Constants.colors[3],
                                                          ]),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          AutoSizeText(
                                                            getDateString(
                                                                shiftDetails!
                                                                    .date!,
                                                                "d"),
                                                            textAlign: TextAlign
                                                                .center,
                                                            minFontSize: 0,
                                                            stepGranularity:
                                                                0.2,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15.sp,
                                                                fontFamily:
                                                                    "SFProBold",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                          AutoSizeText(
                                                            getDateString(
                                                                shiftDetails!
                                                                    .date!,
                                                                "yy MMM"),
                                                            minFontSize: 2,
                                                            stepGranularity: 1,
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.sp,
                                                                fontFamily:
                                                                    "SFProMedium",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth(context,
                                                    dividedBy: 2),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    AutoSizeText(
                                                      shiftDetails!.hospital!,
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Constants
                                                              .colors[11],
                                                          fontSize: 16.sp,
                                                          fontFamily:
                                                              "SFProMedium",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 1.w,
                                                    ),
                                                    AutoSizeText(
                                                      getDateString(shiftDetails.date, "MMMd") +
                                                      " "+  getDateString(shiftDetails.date, "yyyy") +" | " +
                                                          shiftDetails
                                                              .timeFrom! +" "+
                                                          shiftDetails.timeTo! ,

                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontSize: 10.sp,
                                                          fontFamily: "S",
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      height: 2.w,
                                                    ),
                                                    Row(
                                                      children: [
                                                        DrawableButton(
                                                          onPressed: () {},
                                                          label: shiftDetails!
                                                              .type!,
                                                          asset:
                                                              "assets/images/icon/swipe-to-right.svg",
                                                          backgroundColor:
                                                              Constants
                                                                  .colors[2],
                                                          textColors: Constants
                                                              .colors[4],
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        DrawableButton(
                                                          onPressed: () {},
                                                          label: shiftDetails!
                                                              .category!,
                                                          asset:
                                                              "assets/images/icon/ward.svg",
                                                          backgroundColor:
                                                              Constants
                                                                  .colors[2],
                                                          textColors: Constants
                                                              .colors[6],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  transformAlignment:
                                                      Alignment.centerRight,
                                                  child: SvgPicture.asset(
                                                      'assets/images/icon/righarrow.svg')),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          LatestShift late = shiftDetails;
                                          var shiftId = late.rowId.toString();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShiftDetailScreen(
                                                      shift_id: shiftId,
                                                      isCompleted: false,
                                                    )),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        height: screenHeight(context,
                                            dividedBy: 100)),
                                    equalSizeButtons(),
                                    SizedBox(
                                        height: screenHeight(context,
                                            dividedBy: 100)),
                                  ],
                                ),
                              imageCard(),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: AutoSizeText(
                                    Txt.important_update,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontFamily: "SFProMedium",
                                    ),
                                  ),
                                ),
                              ),
                              horizontalList(snapshot),
                              gridView(),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ),
            StreamBuilder(
              stream: homepageBloc.visible,
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
          ],
        ),
      ),
    );
  }

  Widget equalSizeButtons() {
    LatestShift late = shiftDetails;
    var shiftId = late.rowId.toString();
    print("shiftId");
    print(shiftId);
    return Row(
      children: <Widget>[
        Expanded(
          child: HomeButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShiftDetailScreen(
                            shift_id: shiftId,
                            isCompleted: false,
                          )),
                );
              },
              label: Txt.shift_details,
              asset: "assets/images/icon/availability.svg",
              textColors: Constants.colors[0],
              color1: Constants.colors[3],
              color2: Constants.colors[4]),
        ),
        SizedBox(width: screenHeight(context, dividedBy: 100)),
        Expanded(
          child: HomeButton(
              onPressed: () {
                print("HomeButton");
                LatestShift late = shiftDetails;
                final Event event = Event(
                  title: late.jobTitle!,
                  description: late.jobDetails!,
                  location: late.hospital!,
                  startDate: DateTime.parse(late.date!),
                  endDate: DateTime.parse(late.date!),
                  iosParams: IOSParams(
                    reminder: Duration(
                        /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                  ),
                  androidParams: AndroidParams(
                    emailInvites: [], // on Android, you can add invite emails to your event.
                  ),
                );
                print(event.location);
                print(event.endDate);
                Add2Calendar.addEvent2Cal(event);
              },
              label: Txt.calendar,
              asset: "assets/images/icon/availability.svg",
              textColors: Constants.colors[0],
              color1: Constants.colors[6],
              color2: Constants.colors[5]),
        ),
      ],
    );
  }

  Widget imageCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          children: [
            Container(
                width: 93.w,
                child: Image.asset('assets/images/icon/premium_home_icon.png')),
          ],
        ),
      ),
    );
  }

  Widget horizontalList(AsyncSnapshot<UserHomeResponse> snapshot) {
    return Column(
      children: [
        Container(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 35.w,
            ),
            child: buildList(snapshot),
          ),
        ),
      ],
    );
  }

  Widget buildList(AsyncSnapshot<UserHomeResponse> snapshot) {
    if (null != snapshot.data?.response?.data?.importantUpdates) {
      var itemcount = snapshot.data?.response?.data?.importantUpdates!.length;
      return Container(
        height: 35.w,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: ctrl,
                padEnds: false,
                onPageChanged: (page) {
                  print("page");
                  print(page);
                  setState(() {
                    currentPage = page.toDouble();
                  });
                },
                pageSnapping: true,
                itemCount: itemcount,
                itemBuilder: (BuildContext context, int index) {
                  var list =
                      snapshot.data?.response?.data?.importantUpdates![index];
                  if (null != list) {
                    var name = list.title!;
                    var date = list.date!;
                    var description = list.description!;
                    return Container(
                      child: Card(
                        elevation: 0.0,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  name,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontFamily: "SFProMedium",
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child: Container(
                                      width:
                                          screenHeight(context, dividedBy: 2.2),
                                      child: AutoSizeText(
                                        description,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8.sp,
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child: SizedBox(
                                      width:
                                          screenHeight(context, dividedBy: 2.2),
                                      child: AutoSizeText(
                                        date,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8.sp,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            DotsIndicator(
              dotsCount: itemcount!,
              position: currentPage!,
              decorator: DotsDecorator(
                color: Constants.colors[37], // Inactive color
                activeColor: Constants.colors[36],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget gridView() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 2,
        primary: false,
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: () {
              // widget.onTapMap;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AvailabilityListScreen(),
                ),
              );
            },
            child: HomeCardItem(
                label: Txt.my_availability,
                asset: "assets/images/icon/availability.svg"),
          ),
          GestureDetector(
            onTap: () {
              // widget.onTapMap;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedShiftScreen(),
                ),
              );
            },
            child: HomeCardItem(
                label: Txt.submit_timesheets,
                asset: "assets/images/icon/Page-1.svg"),
          ),
          GestureDetector(
            onTap: () {
              // widget.onTapMap;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FindshiftCalendar(),
                ),
              );
            },
            child: HomeCardItem(
                label: Txt.find_shift, asset: "assets/images/icon/shift.svg"),
          ),
          GestureDetector(
            onTap: () {
              // widget.onTapMap;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyBookingScreen(),
                ),
              );
            },
            child: HomeCardItem(
                label: Txt.my_booking, asset: "assets/images/icon/booking.svg"),
          )
        ],
      ),
    );
  }

  getDate(String s) {
    return;
  }


}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
