import 'package:auto_size_text/auto_size_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/manager/home/approved_timesheet_screen.dart';
import 'package:xpresshealthdev/ui/manager/home/create_shift_screen.dart';
import 'package:xpresshealthdev/ui/manager/home/my_shifts_screen.dart';
import 'package:xpresshealthdev/ui/widgets/loading_widget.dart';
import 'package:xpresshealthdev/utils/network_utils.dart';

import '../../../blocs/manager_home_bloc.dart';
import '../../../model/manager_home_response.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../user/detail/home_card_item.dart';
import '../../widgets/buttons/home_button.dart';

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

  void observe() {
    managerhomeBloc.managerhomeStream.listen((event) {
      setState(() {
        visibility = false;
      });
    });
  }

  Future getData() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      setState(() {
        visibility = true;
      });
      managerhomeBloc.fetchManagerHome(token);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    observe();
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
                            "Important Update",
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
              label: "Send Mail",
              asset: "assets/images/icon/email.svg",
              textColors: Constants.colors[0],
              color1: Constants.colors[3],
              color2: Constants.colors[4]),
        ),
        SizedBox(width: screenHeight(context, dividedBy: 100)),
        Expanded(
          child: HomeButton(
              onPressed: () => dialCall("8606276916"),
              label: "Contact",
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
            return Container();
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
                color: Colors.white, // Inactive color
                activeColor: HexColor("#04b654"),
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
                print("ON TAP");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateShiftScreen()),
                );
              },
              child: HomeCardItem(
                  label: "Create Shifts ",
                  asset: "assets/images/icon/availability.svg")),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManagerShiftsScreen()),
              );
            },
            child: HomeCardItem(
                label: "View\nMy Booking ",
                asset: "assets/images/icon/availability.svg"),
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
                label: "Approve Timesheets",
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
