import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../services/fcm_service.dart';

import '../../Constants/sharedPrefKeys.dart';
import '../../Constants/strings.dart';
import '../../blocs/login_bloc.dart';
import '../../ui/manager_dashboard_screen.dart';
import '../../utils/constants.dart';
import '../../utils/network_utils.dart';
import '../../utils/utils.dart';
import '../../utils/validator.dart';
import '../dashboard_screen.dart';
import '../widgets/buttons/login_button.dart';
import '../widgets/input_text.dart';
import '../widgets/labeled_checkbox.dart';
import '../widgets/loading_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _loginResponse();
  }

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.colors[9],
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/icon/Bg2.png',
            width: 100.w,
            height: 50.h,
            fit: BoxFit.fill,
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  width: 90.w,
                  height: 75.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Form(
                        // autovalidateMode: AutovalidateMode.always,
                        key: formKey,
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                child: ColoredBox(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        logoImage(),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                                          child: AutoSizeText(
                                            Txt.login,
                                            textAlign: TextAlign.start,
                                            maxLines: 3,
                                            style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w800, fontFamily: "SFProBold"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 16.0, right: 16),
                                              child: TextInputFileds(
                                                controlr: email,
                                                onChange: () {},
                                                validator: (email) {
                                                  if (validEmail(email)) {
                                                    return null;
                                                  } else {
                                                    return Txt.enter_valid_email;
                                                  }
                                                },
                                                hintText: Txt.email,
                                                keyboadType: TextInputType.emailAddress,
                                                isPwd: false,
                                                onTapDate: () {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.w,
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 16.0, right: 16),
                                              child: TextInputFileds(
                                                controlr: pwd,
                                                onChange: () {},
                                                validator: (password) {
                                                  if (validPassword(password)) {
                                                    return null;
                                                  } else {
                                                    return Txt.enter_valid_password;
                                                  }
                                                },
                                                hintText: Txt.pwd,
                                                keyboadType: TextInputType.visiblePassword,
                                                isPwd: true,
                                                onTapDate: () {},
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          //  mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 6.0),
                                              //  alignment: Alignment.topLeft,
                                              //transformAlignment: Alignment.topLeft,
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty.resolveWith(getColor),
                                                value: isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value!;
                                                  });

                                                  //  widget.onCheckBoxClicked(widget.items.rowId.toString(), value);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: (){
                                                  launchLink('https://www.xpresshealth.ie/');
                                                },
                                                child: RichText(
                                                text: TextSpan(
                                                  text: "I Agree the ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 9.sp,
                                                    decoration: TextDecoration.none,
                                                    color: Constants.colors[29],
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(

                                                      text: 'Terms of Service',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 9.sp,
                                                        decoration: TextDecoration.underline,
                                                        color: Colors.blue,
                                                        decorationStyle: TextDecorationStyle.solid,
                                                        // fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                        text: ' and ',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 9.sp,
                                                          decoration: TextDecoration.none,
                                                          color: Constants.colors[29],
                                                        )),
                                                    TextSpan(
                                                        text: 'Privacy Policy',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 9.sp,
                                                          decoration: TextDecoration.underline,
                                                          decorationStyle: TextDecorationStyle.solid,
                                                          // fontStyle: FontStyle.italic,
                                                          color: Colors.blue,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        signUpBtn(),

                                        // Platform.isIOS ? AppleSignInButton(
                                        // //style: ButtonStyle.black,
                                        // type: ButtonType.continueButton,
                                        // onPressed: appleLogIn,):const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 0),
                  child: Text(
                    Txt.powered_by,
                    style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SFProMedium"),
                  ),
                ),
              ),
              StreamBuilder(
                stream: loginBloc.visible,
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
            ],
          ),
        ],
      ),
    );
  }

  Widget signUpBtn() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
            child: Stack(
              children: [
                LoginButton(
                    isEnabled: isChecked,
                    onPressed: () async {

                        FocusManager.instance.primaryFocus?.unfocus();
                        var validate = formKey.currentState?.validate();
                        if (null != validate) {
                          if (validate) {
                            if (isChecked) {
                            SharedPreferences shdPre = await SharedPreferences.getInstance();
                            bool isuser = shdPre.getBool("user")!;
                            var userType = "1";
                            if (isuser) {
                              userType = "0";
                            }

                            String? deviceId = await getDeviceId();
                            debugPrint("DEVICE Id : ");
                            debugPrint(deviceId.toString());

                            if (deviceId == null) {
                              return;
                            }

                            loginBloc.fetchLogin(email.text, pwd.text, userType, deviceId);
                          }
                            else {
                              showAlertDialoge(context,
                                  title: "Important", message: Txt.agree);
                            }
                        }
                      }
                    },
                    label: "Login"),
              ],
            ),
          )),
        ),
      ],
    );
  }

  Widget logoImage() {
    return Column(
      children: <Widget>[
        Center(
            child: Stack(
          children: [
            Visibility(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 0),
                child: SizedBox(
                    height: 20.w,
                    width: 50.w,
                    child: SvgPicture.asset(
                      'assets/images/icon/logo.svg',
                    )),
              ),
            ),
          ],
        )),
      ],
    );
  }

  void _loginResponse() {
    loginBloc.loginStream.listen((event) async {
      if (null != event.response) {
        var message = event.response?.status?.statusMessage;
        if (event.response?.status?.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          var token = event.response?.data?.token;
          var role = event.response?.data?.role;
          var firstname = event.response?.data?.firstName;
          var lastName = event.response?.data?.lastName;
          var employeeNo = event.response?.data?.employeeNo;
          var userType = event.response?.data?.userType;
          var profileSrc = event.response?.data?.profileSrc;
          if (null == token) {
            if (!mounted) return;
            showAlertDialoge(context, title: Txt.login_failed, message: message!);
            return;
          }
          if (null == role || null == firstname || null == lastName || null == employeeNo || null == userType || null == profileSrc) {
            return;
          }
          // if () {
          //   return;
          // }
          //
          // if () {
          //   return;
          // }
          //
          // if () {
          //   return;
          // }
          //
          // if () {
          //   return;
          // }
          //
          // if () {
          //   return;
          // }

          prefs.setString(SharedPrefKey.AUTH_TOKEN, token);

          prefs.setInt(SharedPrefKey.USER_TYPE, role);

          prefs.setString(SharedPrefKey.FIRST_NAME, firstname);

          prefs.setString(SharedPrefKey.LAST_NAME, lastName);

          prefs.setString(SharedPrefKey.EMPLOYEE_NO, employeeNo);

          prefs.setString(SharedPrefKey.USER_TYPE_NAME, userType);

          prefs.setString(SharedPrefKey.PROFILE_SRC, profileSrc);

          if (role == 0) {
            if (!mounted) return;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashBoard()),
              ModalRoute.withName('/'),
            );
          } else {
            if (!mounted) return;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ManagerDashBoard()),
              ModalRoute.withName('/'),
            );
          }
          FCM().getFCMToken();
        } else {
          if (!mounted) return;
          showAlertDialoge(context, title: Txt.login_failed, message: message!);
        }
      } else {
        if (!mounted) return;
        showAlertDialoge(context, title: Txt.login_failed, message: Txt.someting_went_wrong);
      }
    });
  }
}
