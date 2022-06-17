import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/widgets/double_back_to_close.dart';
import 'package:xpresshealthdev/ui/widgets/logout_warning.dart';
import '../Constants/AppColors.dart';
import '../Constants/strings.dart';
import '../ui/manager/home/approved_timesheet_screen.dart';
import '../ui/manager/home/manager_home_screen.dart';
import '../utils/constants.dart';

import 'manager/home/completed_approvel.dart';
import 'manager/home/manager_calendar_screen.dart';

class ManagerDashBoard extends StatefulWidget {
  const ManagerDashBoard({Key? key}) : super(key: key);

  @override
  State<ManagerDashBoard> createState() => _ManagerDashBoardWidgetState();
}

class _ManagerDashBoardWidgetState extends State<ManagerDashBoard> {
  static  final List<Widget> _widgetOptions = <Widget>[
    const ManagerHomeScreen(),
    const ManagerFindShiftCalendar(),
    // ManagerShiftsScreen(),
    const ApprovedTimeSheetScreen(),
    const CompletedApprovelScreen(),
  ];
  late PersistentTabController controller;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }


  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color:Constants.colors[1],
          ),
          backgroundColor: white,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    'assets/images/icon/logo.svg',
                    fit: BoxFit.contain,
                    height: 8.w,
                  )),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showDialog( builder: (BuildContext context) { return  const LogoutWarning(); }, context: context);
              },
              icon: SvgPicture.asset(
                'assets/images/icon/logout.svg',
                width: 5.w,
                color: Colors.black,
                height: 5.w,
              ),
            ),
          ],
        ),
        body: PersistentTabView(
          context,
          controller: controller,
          screens: _widgetOptions,
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle:
              NavBarStyle.style3, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: (Txt.home),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.shift),
      title: (Txt.shifts),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    // PersistentBottomNavBarItem(
    //   icon: Icon(CupertinoIcons.calendar),
    //   title: (Txt.view_shift),
    //   iconSize: 6.w,
    //   activeColorPrimary: Constants.colors[6],
    //   inactiveColorPrimary: CupertinoColors.systemGrey,
    // ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.calendar_badge_plus),
      title: (Txt.time_sheets),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.calendar_badge_plus),
      title: (Txt.approved),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];


}

