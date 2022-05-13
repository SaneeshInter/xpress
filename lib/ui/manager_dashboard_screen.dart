import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/manager/home/approved_timesheet_screen.dart';
import 'package:xpresshealthdev/ui/manager/home/manager_home_screen.dart';

//import 'package:xpresshealthdev/ui/manager/home/manager_calendar_screen.dart';
import 'package:xpresshealthdev/ui/user/sidenav/notification_screen.dart';
import 'package:xpresshealthdev/utils/constants.dart';

import '../utils/colors_util.dart';

import 'manager/home/create_shift_screen.dart';
import 'manager/home/manager_calendar_screen.dart';
import 'manager/home/my_shifts_screen.dart';
import 'user/home/my_shift_calendar.dart';

class ManagerDashBoard extends StatefulWidget {
  const ManagerDashBoard({Key? key}) : super(key: key);

  @override
  State<ManagerDashBoard> createState() => _ManagerDashBoardWidgetState();
}

class _ManagerDashBoardWidgetState extends State<ManagerDashBoard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    ManagerHomeScreen(),
    //CreateShiftScreen(shiftItem: null),
    ManagerfindshiftCalendar(),

    ManagerShiftsScreen(),
    ApprovedTimeSheetScreen()
  ];

  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.3,
              0.6,
              0.9,
              0.12,
            ],
            colors: [
              HexColor("#04b654"),
              HexColor("#049e95"),
              HexColor("#049e95"),
              HexColor("#058dbf"),
            ],
          )),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200,
                child: Container(
                  height: 50,
                  width: 50,
                ),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/images/icon/menu.svg',
              fit: BoxFit.contain,
              width: 5.w,
              height: 4.2.w,
            )),
        bottomOpacity: 0.0,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color:Constants.colors[1],
          //change your color here
        ),
        backgroundColor: HexColor("#ffffff"),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
            icon: SvgPicture.asset(
              'assets/images/icon/notification.svg',

              width: 5.w,
              color: Colors.black,
              height: 5.w,
            ), //Image.asset('assets/images/icon/searchicon.svg',width: 20,height: 20,fit: BoxFit.contain,),
          ),
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style3, // Choose the nav bar style with this property.
      ),
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Home"),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.shift),
      title: ("Create Shift"),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.calendar),
      title: ("View Shift"),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.calendar_badge_plus),
      title: ("Apporve TimeSheets"),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
