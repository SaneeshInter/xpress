import 'package:auto_size_text/auto_size_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import '../../../ui/manager/home/approved_timesheet_screen.dart';
import '../../../ui/manager/home/my_shifts_screen.dart';
import '../../../ui/widgets/loading_widget.dart';
import '../../../utils/network_utils.dart';

import '../../../Constants/strings.dart';
import '../../../blocs/manager_home_bloc.dart';
import '../../../model/manager_home_response.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../user/detail/home_card_item.dart';
import '../../widgets/buttons/home_button.dart';
import '../create_shift_screen_update.dart';
import 'manager_calendar_screen.dart';

class ManagerHomeScreen extends StatefulWidget {
  const ManagerHomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreentate createState() => _HomeScreentate();
}

class _HomeScreentate extends State<ManagerHomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool visibility = false;
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var token;
  double? currentPage = 0;
  late PageController pageController;
  final PageController ctrl = PageController(
    viewportFraction: .7,
  );

  @override
  void didUpdateWidget(covariant ManagerHomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    token = await TokenProvider().getToken();

    managerhomeBloc.fetchManagerHome(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
    pageController = PageController(initialPage: 0);
    pageCount = 3;
  }

  @override
  void dispose() {
    super.dispose();
    managerhomeBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.colors[9],
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          child: AutoSizeText(
                            Txt.important_update,
                            maxLines: 1,
                            style: TextStyle(
                              color: Constants.colors[1],
                              fontSize: 16.sp,
                              fontFamily: "SFProMedium",
                            ),
                          ),
                        ),
                      ),
                      horizontalList(),
                      gridView(),
                      equalSizeButtons()
                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  height: 70.h,
                  child: StreamBuilder(
                    stream: managerhomeBloc.visible,
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
              onPressed: () => sendingMails("manager@xpress.in"),
              label: Txt.send_mail,
              asset: "assets/images/icon/email.svg",
              textColors: Constants.colors[0],
              color1: Constants.colors[3],
              color2: Constants.colors[4]),
        ),
        SizedBox(width: screenHeight(context, dividedBy: 100)),
        Expanded(
          child: HomeButton(
              onPressed: () => dialCall("8606276916"),
              label: Txt.contact,
              asset: "assets/images/icon/phone.svg",
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
      child: Card(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            children: [
              Container(
                  child:
                      Image.asset('assets/images/icon/premium_home_icon.png')),
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalList() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 35.w,
      ),
      child: StreamBuilder(
          stream: managerhomeBloc.managerhomeStream,
          builder: (BuildContext context,
              AsyncSnapshot<ManagerHomeResponse> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const SizedBox();
          }),
    );
  }

  Widget buildList(AsyncSnapshot<ManagerHomeResponse> snapshot) {
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
                    return const SizedBox();
                  }
                },
              ),
            ),
            DotsIndicator(
              dotsCount: itemcount!,
              position: currentPage!,
              decorator: DotsDecorator(
                color: Colors.white, // Inactive color
                activeColor: HexColor("#04b654"),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
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
                print("ON TAP");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateShiftScreenUpdate()),
                );
              },
              child: HomeCardItem(
                  label: Txt.create_shifts,
                  asset:"assets/images/icon/shift.svg")),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManagerFindShiftCalendar()),
              );
            },
            child: HomeCardItem(
                label: Txt.view_booking,
                asset: "assets/images/icon/booking.svg"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ApprovedTimeSheetScreen()),
              );
            },
            child: HomeCardItem(
                label: Txt.approve_timesheets,
                asset: "assets/images/icon/availability.svg"),
          ),
        ],
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
