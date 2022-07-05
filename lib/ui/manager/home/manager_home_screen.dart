import 'package:auto_size_text/auto_size_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/strings.dart';
import '../../../blocs/manager_home_bloc.dart';
import '../../../model/manager_home_response.dart';
import '../../../resources/token_provider.dart';
import '../../../ui/widgets/loading_widget.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
import '../../../utils/utils.dart';
import '../../manager_dashboard_screen.dart';
import '../../user/detail/home_card_item.dart';
import '../../widgets/buttons/home_button.dart';
import '../../widgets/my_scroll_behavior.dart';
import '../../widgets/shift_detail_card.dart';
import '../../widgets/shift_status_chip.dart';
import '../create_shift_screen_update.dart';

class ManagerHomeScreen extends StatefulWidget {
  const ManagerHomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreentate createState() => _HomeScreentate();
}

class _HomeScreentate extends State<ManagerHomeScreen> with WidgetsBindingObserver{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool visibility = false;
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  int currentStatus = 0;
  var token;
  double? currentPage = 0;
  late PageController pageController;
  final PageController ctrl = PageController(
    viewportFraction: .7,
  );
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {

    }
  }
  @override
  void didUpdateWidget(covariant ManagerHomeScreen oldWidget) {
    WidgetsBinding.instance.removeObserver(this);
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    token = await TokenProvider().getToken();
    managerhomeBloc.fetchManagerHome(token);
  }

  @override
  void initState() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement initState
    getData();
    pageController = PageController(initialPage: 0);
    pageCount = 3;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ctrl.dispose();
    managerhomeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: Constants.colors[9],

      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: RefreshIndicator(
          onRefresh: () async {
            await getData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
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


                      const SizedBox(
                        height: 30,
                      ),
                      equalSizeButtons()
                    ],
                  ),
                  SizedBox(
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
      ),
    );
  }

  Widget shiftDetails() {
    return managerhomeBloc.dashList.isNotEmpty?SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: AutoSizeText(
                  Txt.shift_status,
                  maxLines: 1,
                  style: TextStyle(
                    color: Constants.colors[1],
                    fontSize: 16.sp,
                    fontFamily: "SFProMedium",
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShiftStatusChip(
                  label: 'Daily',
                  selected: currentStatus == 0,
                  selectedColor: greenColor,
                  textColor: white,
                  onPressed: () {
                    currentStatus = 0;
                    setState(() {});
                  },
                ),
                ShiftStatusChip(
                  label: 'Weekly',
                  selected: currentStatus == 1,
                  selectedColor: greenColor,
                  textColor: white,
                  onPressed: () {
                    currentStatus = 1;
                    setState(() {});
                  },
                ),
                ShiftStatusChip(
                  label: 'Monthly',
                  selected: currentStatus == 2,
                  selectedColor: greenColor,
                  textColor: white,
                  onPressed: () {
                    currentStatus = 2;
                    setState(() {});
                  },
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShiftDetailCard(
              label: managerhomeBloc.dashList[currentStatus].pending,
                hint: "Pending", height: 45.w, svgPath: 'assets/images/icon/shift.svg',

            ),
            ShiftDetailCard(
              label:  managerhomeBloc.dashList[currentStatus].approved,
              hint: "Accepted", height: 45.w, svgPath: 'assets/images/icon/check.svg',

            ),

          ],
        ),
        ShiftDetailCard(
          label:  managerhomeBloc.dashList[currentStatus].total,
          hint: "Total Shifts", height: 45.w, svgPath: 'assets/images/icon/price-tag.svg',

        ),
      ]),
    ):SizedBox();
  }

  Widget equalSizeButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: HomeButton(
              onPressed: () => sendingMails("manager@health.in"),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            children: [
              Image.asset('assets/images/icon/premium_home_icon.png'),
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalList() {
    return StreamBuilder(
        stream: managerhomeBloc.managerhomeStream,
        builder: (BuildContext context,
            AsyncSnapshot<ManagerHomeResponse> snapshot) {

          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return SizedBox(
              height: 35.w,
              child: const Center(child: CircularProgressIndicator()));
        });
  }

  Widget buildList(AsyncSnapshot<ManagerHomeResponse> snapshot) {
    if (null != snapshot.data?.response?.data?.importantUpdates) {
      var itemCount = snapshot.data?.response?.data?.importantUpdates!.length;
      return Column(
        children: [
          SizedBox(
            height: 35.w,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: ctrl,
                    padEnds: false,
                    onPageChanged: (page) {
                      debugPrint("page $page");
                      setState(() {
                        currentPage = page.toDouble();
                      });
                    },
                    pageSnapping: true,
                    itemCount: itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      var list =
                          snapshot.data?.response?.data?.importantUpdates![index];
                      if (null != list) {
                        var name = list.title!;
                        var date = list.date!;
                        var description = list.description!;
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0.0,
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
                                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child: SizedBox(
                                      width: screenHeight(context, dividedBy: 2.2),
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
                                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child: SizedBox(
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
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
                DotsIndicator(
                  dotsCount: itemCount!,
                  position: currentPage!,
                  decorator: DotsDecorator(
                    color: Constants.colors[37], // Inactive color
                    activeColor: Constants.colors[36],
                  ),
                ),
              ],
            ),
          ),
          shiftDetails()
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  // Widget gridView() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 10.0),
  //     child: GridView.count(
  //       shrinkWrap: true,
  //       childAspectRatio: 2,
  //       primary: false,
  //       crossAxisCount: 2,
  //       children: [
  //         GestureDetector(
  //             onTap: () {
  //               debugPrint("ON TAP");
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const CreateShiftScreenUpdate(buttonTxt: "Create Shift",)),
  //               );
  //               // Navigator.push(
  //               //   context,
  //               //   MaterialPageRoute(
  //               //       builder: (context) => const CreateShiftScreenUpdate()),
  //               // );
  //             },
  //             child: const HomeCardItem(
  //                 label: Txt.create_shifts,
  //                 asset: "assets/images/icon/shift.svg")),
  //         GestureDetector(
  //           onTap: () {
  //             controller.jumpToTab(1);
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(builder: (context) => const ManagerFindShiftCalendar()),
  //             // );
  //           },
  //           child: const HomeCardItem(
  //               label: Txt.view_booking,
  //               asset: "assets/images/icon/booking.svg"),
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             controller.jumpToTab(3);
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //       builder: (context) => const ApprovedTimeSheetScreen()),
  //             // );
  //           },
  //           child: const HomeCardItem(
  //               label: Txt.approve_timesheets,
  //               asset: "assets/images/icon/availability.svg"),
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             controller.jumpToTab(3);
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //       builder: (context) => const ApprovedTimeSheetScreen()),
  //             // );
  //           },
  //           child: const HomeCardItem(
  //               label: Txt.time_sheets,
  //               asset: "assets/images/icon/availability.svg"),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
