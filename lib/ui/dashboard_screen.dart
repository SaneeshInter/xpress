
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../ui/widgets/double_back_to_close.dart';

import '../Constants/AppColors.dart';
import '../Constants/sharedPrefKeys.dart';
import '../Constants/strings.dart';
import '../ui/user/common/side_menu.dart';
import '../ui/user/home/availability_list_screen.dart';
import '../ui/user/home/completed_shift_screen.dart';
import '../ui/user/home/home_screen.dart';
import '../ui/user/home/my_booking_screen.dart';
import '../ui/user/home/my_shift_calendar.dart';
import '../utils/colors_util.dart';
import '../utils/constants.dart';
late PersistentTabController userController;
class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardWidgetState();
}



class _DashBoardWidgetState extends State<DashBoard> {
  int notificationCount = 0;
  int pageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    userController = PersistentTabController(initialIndex: 0);
    getNotificationCount();
  }

  getNotificationCount() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    notificationCount = shdPre.getInt(SharedPrefKey.USER_NOTIFICATION_COUNT) ?? 0;
    setState(() {});
  }



  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(

    ),
    const FindShiftCalendar(),
    const MyBookingScreen(),
    const AvailabilityListScreen(),
    const CompletedShiftScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.


  @override
  Widget build(BuildContext context) {
    // _controller = PersistentTabController(initialIndex: 0);
    return DoubleBack(
      context: context,
      index: _selectedIndex,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const Drawer(
          child: SideMenu(),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/images/icon/menu.svg',
              width: 5.w,
              height: 4.2.w,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          bottomOpacity: 0.0,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.black,
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
                const newRouteName = "/NotificationScreen";
                bool isNewRouteSameAsCurrent = false;
                Navigator.popUntil(context, (route) {
                  if (route.settings.name == newRouteName) {
                    isNewRouteSameAsCurrent = true;
                  }
                  return true;
                });

                if (!isNewRouteSameAsCurrent) {
                  Navigator.pushNamed(context, newRouteName);
                }

              },
              icon: Badge(
                badgeContent:  Text(notificationCount.toString(),style: const TextStyle(color: white,fontSize: 10),),
                child: SvgPicture.asset(
                  'assets/images/icon/notification.svg',

                  width: 5.w,
                  color: Colors.black,
                  height: 5.w,
                ),
              ), //Image.asset('assets/images/icon/searchicon.svg',width: 20,height: 20,fit: BoxFit.contain,),
            ),
          ],
        ),
        body: PersistentTabView(
          context,
          controller: userController,
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
          onItemSelected: (index) {
            _selectedIndex=index;
            debugPrint(index.toString());
            setState(() {});
          },

          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,



          // itemAnimationProperties: const ItemAnimationProperties(
          //   duration: Duration(milliseconds: 200),
          //   curve: Curves.ease,
          // ),
          // screenTransitionAnimation: const ScreenTransitionAnimation(
          //   animateTabTransition: true,
          //   curve: Curves.ease,
          //   duration: Duration(milliseconds: 200),
          // ),
          navBarStyle:
              NavBarStyle.style3, // Choose the nav bar style with this property.
        ),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.work_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.work_outline_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.widgets_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.widgets_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
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
      iconSize: 6.w,
      title: (Txt.find_shift),
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.calendar),
      title: (Txt.booking),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.calendar_badge_plus),
      title: (Txt.availability),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.calendar_badge_plus),
      title: (Txt.time_sheet),
      iconSize: 6.w,
      activeColorPrimary: Constants.colors[6],
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
