import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../ui/user/home/profile_edit.dart';
import '../../../utils/utils.dart';

import '../../../Constants/app_defaults.dart';
import '../../../Constants/sharedPrefKeys.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/profile_update_bloc.dart';
import '../../../model/user_get_response.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/buttons/drawable_button.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_detail.dart';
import '../../widgets/profile_documents.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ProfileState extends State<ProfileScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    profileBloc.dispose();
  }

  Future getData() async {
    profileBloc.token = await TokenProvider().getToken();
    if (null != profileBloc.token) {
      if (await isNetworkAvailable()) {
        profileBloc.getUserInfo();
      } else {
        showInternetNotAvailable();
      }
    }
  }

  Future<void> showInternetNotAvailable() async {
    int respo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );
    if (respo == 1) {
      getData();
    }
  }



  @override
  void initState() {
    super.initState();
    observe();
    getData();
  }

  void observe() {
    profileBloc.getProfileStream.listen(
      (event) async {
        print("observe");
        var datatItem = event.response?.data?.items;
        if (null != datatItem && datatItem.isNotEmpty) {
          var items = datatItem[0];
          var firstname = items.firstName;
          print(firstname);
          var lastName = items.lastName;
          var employeeNo = items.employeeNo;
          var userType = items.userType;
          var profileSrc = items.profileSrc;
          final prefs = await SharedPreferences.getInstance();
          prefs.setString(SharedPrefKey.FIRST_NAME, firstname!);
          prefs.setString(SharedPrefKey.LAST_NAME, lastName!);
          prefs.setString(SharedPrefKey.EMPLOYEE_NO, employeeNo!);
          prefs.setString(SharedPrefKey.USER_TYPE_NAME, userType!);
          prefs.setString(SharedPrefKey.PROFILE_SRC, profileSrc!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/icon/arrow.svg',
            width: 5.w,
            height: 4.2.w,
          ),
          onPressed: () {
            pop(context);
          },
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          //change your color here
        ),
        backgroundColor: HexColor("#ffffff"),
        title: AutoSizeText(
          Txt.profile,
          style: TextStyle(
              fontSize: 17,
              color: Constants.colors[1],
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      backgroundColor: Constants.colors[9],
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<UserGetResponse>(
                    stream: profileBloc.getProfileStream,
                    builder:
                        (context, AsyncSnapshot<UserGetResponse> snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data?.response?.data;
                        String? firstName = data?.items?[0].firstName;
                        String? lastName = data?.items?[0].lastName;
                        String? employeeNo = data?.items?[0].employeeNo;
                        String? profileImage = "";
                        profileImage = data?.items?[0].profileSrc;
                        String? categroy = data?.items?[0].userType;
                        String? hourlyRate =
                            data?.items?[0].hourlyRate.toString();
                        Items? item = data?.items?[0];
                        String? fullName = "$firstName $lastName";
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (null != data)
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Constants.colors[31],
                                          Constants.colors[32],
                                        ]),
                                    borderRadius:
                                        BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(
                                  AppDefaults.padding,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.12,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.22),
                                            child: AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: Stack(
                                                children: [
                                                  if (profileImage ==
                                                          "" ||
                                                      null ==
                                                          profileImage)
                                                    Image.asset(
                                                      'assets/images/icon/man_ava.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  if (profileImage !=
                                                          "" &&
                                                      null !=
                                                          profileImage)
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
                                        const SizedBox(
                                            width: AppDefaults.margin),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            if (fullName != null)
                                              Text(
                                                fullName,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                    fontFamily:
                                                        "SFProMedium",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            const SizedBox(height: 5),
                                            if (null != categroy)
                                              Text(
                                                categroy,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.sp,
                                                    fontFamily: "S",
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            const SizedBox(height: 5),
                                            if (employeeNo != null)
                                              Text(
                                                Txt.emp_no + employeeNo,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10.sp,
                                                    fontFamily: "S",
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            if (hourlyRate != null)
                                              Text(
                                               " ${hourlyRate=="null"?"0":hourlyRate}${Txt.hr}",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Constants
                                                        .colors[33],
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            DrawableButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ProfileEditScreen()),
                                                );
                                              },
                                              label: Txt.edit,
                                              asset:
                                                  "assets/images/icon/edit.svg",
                                              backgroundColor:
                                                  Constants.colors[4],
                                              textColors:
                                                  Constants.colors[0],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: AppDefaults.margin),
                                    // Actions
                                  ],
                                ),
                              ),
                            const SizedBox(height: 10),
                            if (null != item)
                              ProfileDetailCard(items: item, onPressed: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ProfileEditScreen()),
                                ).then((value) => getData());

                              },),
                            Column(
                              children: [
                                if (null != item)
                                  ProfileDocumentsCard(
                                    items: item,
                                    onRefresh: () {
                                      debugPrint("Refresh item");
                                      getData();
                                    },
                                  ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
              ),
            ),
            SizedBox(
              width: 100.w,
              height: 70.h,
              child: StreamBuilder(
                stream: profileBloc.visible,
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
