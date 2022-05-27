import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../blocs/login_bloc.dart';
import '../../ui/manager_dashboard_screen.dart';
import '../../utils/utils.dart';
import '../../Constants/sharedPrefKeys.dart';
import '../../Constants/strings.dart';
import '../../utils/constants.dart';
import '../../utils/validator.dart';
import '../dashboard_screen.dart';
import '../widgets/buttons/login_button.dart';
import '../widgets/input_text.dart';
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

  @override
  void initState() {
    // TODO: implement initState
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .5,
            fit: BoxFit.fill,
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 70.h,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        logoImage(),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20.0, 0, 0, 0),
                                          child: AutoSizeText(
                                            Txt.login,
                                            textAlign: TextAlign.start,
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: "SFProBold"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 16),
                                              child: Container(
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
                                                  keyboadType: TextInputType
                                                      .emailAddress,
                                                  isPwd: false,
                                                  onTapDate: () {},
                                                ),
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
                                              padding:
                                                  const EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 16),
                                              child: Container(
                                                child: TextInputFileds(
                                                  controlr: pwd,
                                                  onChange: () {},
                                                  validator: (password) {
                                                    if (validPassword(
                                                        password))
                                                      return null;
                                                    else {
                                                      return Txt.enter_valid_password;
                                                    }
                                                  },
                                                  hintText: Txt.pwd,
                                                  keyboadType: TextInputType
                                                      .visiblePassword,
                                                  isPwd: true,
                                                  onTapDate: () {},
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        signUpBtn(),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        // Platform.isIOS ? AppleSignInButton(
                                        // //style: ButtonStyle.black,
                                        // type: ButtonType.continueButton,
                                        // onPressed: appleLogIn,):Container(),
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
                  padding: EdgeInsets.only(bottom: 25, top: 0),
                  child: Text(
                    Txt.powered_by,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: "SFProMedium"),
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
                      return Container();
                    }
                  } else {
                    return Container();
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
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Stack(
              children: [
                LoginButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      var validate = formKey.currentState?.validate();
                      if (null != validate) {
                        if (validate) {
                          SharedPreferences shdPre =
                              await SharedPreferences.getInstance();
                          bool isuser = shdPre.getBool("user")!;
                          var userType = "1";
                          if (isuser) {
                            userType = "0";
                          }
                          loginBloc.fetchLogin(email.text, pwd.text, userType);
                        }
                      }
                    },
                    label: "Login"),
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
        Center(
            child: Stack(
          children: [
            Visibility(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 0, right: 0, bottom: 0),
                child: Container(
                    height: MediaQuery.of(context).size.width / 5,
                    width: MediaQuery.of(context).size.width / 2,
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
            showAlertDialoge(context, title: Txt.login_failed, message: message!);
            return;
          }
          if (null == role) {
            return;
          }
          if (null == firstname) {
            return;
          }

          if (null == lastName) {
            return;
          }

          if (null == employeeNo) {
            return;
          }

          if (null == userType) {
            return;
          }

          if (null == profileSrc) {
            return;
          }

          prefs.setString(SharedPrefKey.AUTH_TOKEN, token);

          prefs.setInt(SharedPrefKey.USER_TYPE, role);

          prefs.setString(SharedPrefKey.FIRST_NAME, firstname);

          prefs.setString(SharedPrefKey.LAST_NAME, lastName);

          prefs.setString(SharedPrefKey.EMPLOYEE_NO, employeeNo);

          prefs.setString(SharedPrefKey.USER_TYPE_NAME, userType);

          prefs.setString(SharedPrefKey.PROFILE_SRC, profileSrc);

          if (role == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashBoard()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ManagerDashBoard()),
            );
          }
        } else {
          showAlertDialoge(context, title: Txt.login_failed, message: message!);
        }
      } else {
        showAlertDialoge(context,
            title: Txt.login_failed,
            message: Txt.someting_went_wrong);
      }
    });
  }
}
