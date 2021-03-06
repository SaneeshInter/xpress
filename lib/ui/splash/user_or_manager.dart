import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/strings.dart';
import '../../Constants/toast.dart';
import '../../ui/Login/login_screen.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';


class UserOrManager extends StatelessWidget {
   UserOrManager({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ToastMsg toastMsg = ToastMsg();

  bool isLoading = false;
  // TextEditingController email = TextEditingController();
  // TextEditingController pwd = TextEditingController();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          body: DecoratedBox(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/icon/Bg1.png"),
                    fit: BoxFit.fill)),
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        logoImage(),
                        userButton(context),
                        managerButton(context),
                        SizedBox(
                          height: screenWidth(context, dividedBy: 6),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 25, top: 0),
                          child: Text(
                            "Powered By Xpress Health",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: "SFProMedium"),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget managerButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
                child: Stack(
                  children: [
                    Visibility(
                      visible: !visible,
                      child: Container(
                        color: Colors.transparent,
                        height: commonButtonHeight(context),
                        width: screenWidth(context, dividedBy: 1),
                        child: ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('user', false);
                            Future.delayed(Duration.zero,(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(
                                      color: Colors.white, width: 2.0))),
                          child: Text('Manager', style: TextStyle(fontSize: 12.sp)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Visibility(
                          visible: visible,
                          child: Center(
                            child: Container(
                                margin: const EdgeInsets.only(top: 0, bottom: 0),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Constants.colors[3]),
                                )),
                          )),
                    ),
                  ],
                ),
              )),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget userButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
                child: Stack(
                  children: [
                    Visibility(
                      visible: !visible,
                      child: SizedBox(
                        height: commonButtonHeight(context),
                        width: screenWidth(context, dividedBy: 1),
                        child: ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('user', true);
                            debugPrint('Button Clicked');
                            Future.delayed(Duration.zero,(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            });

                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Constants.colors[10],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(
                                      color: Colors.white, width: 2.0))),
                          child: Text(Txt.user, style: TextStyle(fontSize: 12.sp)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Visibility(
                          visible: visible,
                          child: Center(
                            child: Container(
                                margin: const EdgeInsets.only(top: 0, bottom: 0),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Constants.colors[3]),
                                )),
                          )),
                    ),
                  ],
                ),
              )),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget logoImage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Stack(
                  children: [
                    Visibility(
                      visible: true,
                      child: Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: 65.w,
                          child: SvgPicture.asset(
                            'assets/images/icon/whitelogo.svg',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Visibility(
                          visible: visible,
                          child: Center(
                            child: Container(
                                margin: const EdgeInsets.only(top: 0, bottom: 0),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Constants.colors[3]),
                                )),
                          )),
                    ),
                  ],
                ),
              )),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}



