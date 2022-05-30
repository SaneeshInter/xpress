import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/strings.dart';

import '../../../Constants/app_defaults.dart';
import '../../../Constants/sharedPrefKeys.dart';
import '../../../db/database.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../splash/user_or_manager.dart';

import '../home/profile_screen.dart';
import '../sidenav/completed_shifts.dart';
import '../sidenav/contact_us_screen.dart';
import '../sidenav/faqs_screen.dart';

import '../sidenav/notification_screen.dart';
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Constants.colors[34],
              Constants.colors[35],
            ]),
      ),
      child: ListView(

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
                              borderRadius:
                              BorderRadius.circular(
                                  MediaQuery.of(
                                      context)
                                      .size
                                      .width *
                                      0.22),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Stack(
                                  children: [
                                    if (profileImage == "" ||
                                        null == profileImage)
                                      Image.asset(
                                        'assets/images/icon/man_ava.png',
                                        fit: BoxFit.fill,
                                      ),
                                    if (profileImage != "" &&
                                        null != profileImage)
                                      Image.network(
                                        profileImage,
                                        fit: BoxFit.fill,
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
                               Txt.emp_no + empNo,
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
          Divider(
            endIndent:20 ,
            indent: 20,
            thickness: 0.5,
            color: Constants.colors[0],
          ),

          ListTile(
            title: const Text(
             Txt.home,
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/home.svg',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);

            },
          ),
          ListTile(
            title: const Text(
            Txt.my_profile  ,
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
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );


            },
          ),
          ListTile(
            title: const Text(
              Txt.submtd_timsht,
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

              Navigator.pop(context);
              pushNewScreen(
                context,
                screen: SubmitTimeShift(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),

          ListTile(
            title: const Text(
             Txt.notify ,
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset('assets/images/icon/notification.svg', color: Colors.white,),
            ),
            onTap: () {
              Navigator.pop(context);
              pushNewScreen(
                context,
                screen: NotificationScreen(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          ListTile(
            title: const Text(
              Txt.completed_shifts,
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/Order Completed.svg',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              pushNewScreen(
                context,
                screen: CompletedShift(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          ListTile(
            title: const Text(
             Txt.faqs,
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset('assets/images/icon/conversation.svg', color: Colors.white,),
            ),
            onTap: () {
              Navigator.pop(context);
              pushNewScreen(
                context,
                screen: FaqsShitsScreen(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),

          ListTile(
            title: const Text(
             Txt.contact_us ,
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child:  SvgPicture.asset('assets/images/icon/contact-book.svg', color: Colors.white,),
            ),
            onTap: () {
              Navigator.pop(context);
              pushNewScreen(
                context,
                screen: ContactScreen(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          ListTile(
            title: const Text(
             Txt.log_out,
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              width: 5.w,
              height: 5.w,
              child: SvgPicture.asset(
                'assets/images/icon/turn-off.svg',
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
      (route) => false,
    );
  }
}
