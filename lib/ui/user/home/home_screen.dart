import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/model/user_home_response.dart';
import 'package:xpresshealthdev/ui/user/detail/home_card_item.dart';

import '../../../blocs/shift_homepage_bloc.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
import '../../../utils/utils.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/buttons/drawable_button.dart';
import '../../widgets/buttons/home_button.dart';
import '../../widgets/loading_widget.dart';
import '../common/app_bar.dart';
import '../detail/shift_detail.dart';
import '../common/side_menu.dart';
import 'availability_screen.dart';
import 'completed_shift_screen.dart';
import 'find_shift_screen.dart';
import 'my_booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreentate createState() => _HomeScreentate();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreentate extends State<HomeScreen> {
  bool visibility = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var token;

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
        setState(() {
          visibility = true;
        });
        homepageBloc.fetchUserHomepage(token);
      }else {

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
    observe();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: SideMenu(),
      ),
      appBar: AppBarCommon(
        _scaffoldKey,
        scaffoldKey: _scaffoldKey,
      ),
      backgroundColor: Constants.colors[9],
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<UserHomeResponse>(
                    stream: homepageBloc.userhomeStream,
                    builder:
                        (context, AsyncSnapshot<UserHomeResponse> snapshot) {
                      var data = snapshot.data?.response?.data;
                      if (data != null) {
                        var shiftDetails = null;
                        if (data.latestShift!.length != 0) {
                          shiftDetails = data.latestShift![0];
                        }

                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                'Next Shift',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "SFProMedium",
                                ),
                              ),
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
                                                  height: 20.w,
                                                  width: 20.w,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
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
                                                          '18',
                                                          textAlign:
                                                              TextAlign.center,
                                                          minFontSize: 0,
                                                          stepGranularity: 0.2,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  "SFProBold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                        AutoSizeText(
                                                          'Jan,21',
                                                          minFontSize: 2,
                                                          stepGranularity: 1,
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 9.sp,
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
                                                    height: 5,
                                                  ),
                                                  AutoSizeText(
                                                    "From " +
                                                        shiftDetails.date! +
                                                        "  From " +
                                                        shiftDetails.timeFrom! +
                                                        " To " +
                                                        shiftDetails.timeTo!,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 12.sp,
                                                        fontFamily: "S",
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      DrawableButton(
                                                        onPressed: () {},
                                                        label:
                                                            shiftDetails!.type!,
                                                        asset:
                                                            "assets/images/icon/swipe-to-right.svg",
                                                        backgroundColor:
                                                            Constants.colors[2],
                                                        textColors:
                                                            Constants.colors[4],
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      DrawableButton(
                                                        onPressed: () {},
                                                        label: shiftDetails!
                                                            .hospital!,
                                                        asset:
                                                            "assets/images/icon/ward.svg",
                                                        backgroundColor:
                                                            Constants.colors[2],
                                                        textColors:
                                                            Constants.colors[6],
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
                                    "Important Update",
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
                              horizontalIndiCator(),
                              gridView(),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget equalSizeButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: HomeButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShiftDetailScreen(shift_id: '190',)),
                );
              },
              label: "Shift Details",
              asset: "assets/images/icon/availability.svg",
              textColors: Constants.colors[0],
              color1: Constants.colors[3],
              color2: Constants.colors[4]),
        ),
        SizedBox(width: screenHeight(context, dividedBy: 100)),
        Expanded(
          child: HomeButton(
              onPressed: () {},
              label: "Add to Calender",
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
                child:
                    Image.asset('assets/images/icon/premium_home_icon.png')),
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
              maxHeight: 110,
            ),
            child: buildList(snapshot),
          ),
        ),
      ],
    );
  }

  Widget buildList(AsyncSnapshot<UserHomeResponse> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.response?.data?.importantUpdates!.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        var list = snapshot.data?.response?.data?.importantUpdates![index];

        if (null != list) {
          var name = list.title!;
          var date = list.date!;
          var description = list.description!;
          return Card(
            elevation: 0.0,
            child: Container(
              width: 65.w,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container(
                          width: screenHeight(context, dividedBy: 2.2),
                          child: AutoSizeText(
                            description,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8.sp,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container(
                          width: screenHeight(context, dividedBy: 2.2),
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
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget horizontalIndiCator() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 0.0),
      child: SizedBox(
        height: 15,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.blue
                        .withOpacity(selectedIndex == index ? 1 : 0.5)),
                margin: EdgeInsets.all(5),
                width: 10,
                height: 10,
              ),
            );
          },
        ),
      ),
    );
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
                MaterialPageRoute(builder: (context) => AvailabilityScreen(),),
              );
            },
            child: HomeCardItem(
                label: "My\nAvailability ",
                asset: "assets/images/icon/availability.svg"),
          ),
          GestureDetector( onTap: () {
            // widget.onTapMap;

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompletedShiftScreen(),),
            );
          },
            child: HomeCardItem(
                label: "Submit\nTimeSheets ",
                asset: "assets/images/icon/availability.svg"),
          ),
          GestureDetector(onTap: () {
            // widget.onTapMap;

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FindShiftScreen(),),
            );
          },
            child: HomeCardItem(
                label: "Find Shift",
                asset: "assets/images/icon/availability.svg"),
          ),
          GestureDetector(onTap: () {
            // widget.onTapMap;

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyBookingScreen(),),
            );
          },
            child: HomeCardItem(
                label: "My\nBooking",
                asset: "assets/images/icon/availability.svg"),
          )
        ],
      ),
    );
  }

  getDate(String s) {
    return;
  }

  void observe() {
    homepageBloc.userhomeStream.listen((event) {
      setState(() {
        visibility = false;
      });
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
