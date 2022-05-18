import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/app_defaults.dart';
import '../../../Constants/sharedPrefKeys.dart';
import '../../../db/database.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../splash/user_or_manager.dart';
import '../home/profile_screen.dart';
import '../sidenav/completed_shifts.dart';
import '../sidenav/submit_timesheets.dart';

class SideMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SideMenuState();
  }
}

class _SideMenuState extends State<SideMenu> {
  String name = "";
  String profileImage = "";
  String empNo = "";
  String type = "";

  @override
  void initState() {
    super.initState();
    setProfileHeader();
  }

  Future<void> setProfileHeader() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    var firstName = shdPre.getString(SharedPrefKey.FIRST_NAME)!;
    var secondName = shdPre.getString(SharedPrefKey.LAST_NAME)!;
    name = firstName + " " + secondName;
    var image = shdPre.getString(SharedPrefKey.PROFILE_SRC);
    var empno = shdPre.getString(SharedPrefKey.EMPLOYEE_NO);
    var usertype = shdPre.getString(SharedPrefKey.USER_TYPE_NAME);
    print("setProfileHeader");
    print(image);
    setState(() {
      name = firstName + " " + secondName;
      profileImage = image!;
      empNo = empno!;
      type = usertype!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Constants.colors[3],
              Constants.colors[4],
            ]),
      ),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight(context, dividedBy: 16)),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.12,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Stack(
                                  children: [
                                    if (profileImage != "")
                                      Image.network(
                                        profileImage,
                                        fit: BoxFit.fitHeight,
                                        width: MediaQuery.of(
                                            context)
                                            .size
                                            .width *
                                            0.22,
                                        height: MediaQuery.of(
                                            context)
                                            .size
                                            .width *
                                            0.22,
                                      ),
                                    if (profileImage == "")
                                      Image.asset(
                                        'assets/images/icon/man_ava.png',
                                        fit: BoxFit.fitHeight, width: MediaQuery.of(
                                          context)
                                          .size
                                          .width *
                                          0.22,
                                        height: MediaQuery.of(
                                            context)
                                            .size
                                            .width *
                                            0.22,
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppDefaults.margin),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  name,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontFamily: "SFProMedium",
                                      fontWeight: FontWeight.w700),
                                ),
                                width: 45.w,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                type,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontFamily: "S",
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                empNo,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontFamily: "S",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Actions
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Profile ',
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/user.svg',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              pushNewScreen(
                context,
                screen: ProfileScreen(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );

              // pop(context);
              // Navigator.pushNamed(context, '/profile').then((_) {
              //   // This block runs when you have returned back to the 1st Page from 2nd.
              // });
            },
          ),
          ListTile(
            title: const Text(
              'Submitted Timesheet',
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/availability.svg',
                color: Colors.white,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
              pushNewScreen(
                context,
                screen: SubmitTimeShift(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          ListTile(
            title: const Text(
              'Completed Shifts',
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/shift.svg',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              pushNewScreen(
                context,
                screen: CompletedShift(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          ListTile(
            title: const Text(
              'Notification',
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/shift.svg',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // pushNewScreen(
              //   context,
              //   screen: NotificationScreen(),
              //   withNavBar: true, // OPTIONAL VALUE. True by default.
              //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
              // );
            },
          ),
          ListTile(
            title: const Text(
              'FAQs',
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/email.svg',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text(
              'Contact Us',
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/passport.svg',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/email.svg',
                color: Colors.white,
              ),
            ),
            onTap: () async {
              await logOut(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    var db = Db();
    db.clearDb();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    Navigator.pop(context);

    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => UserOrManager(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );
  }
}
