import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/app_defaults.dart';
import '../../../blocs/profile_update_bloc.dart';
import '../../../model/user_get_response.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/buttons/drawable_button.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_detail.dart';
import '../../widgets/profile_documents.dart';
import '../common/app_bar.dart';
import '../common/side_menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ProfileState extends State<ProfileScreen> {
  var token;
  var _image;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool visibility = false;

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {
        setState(() {
          visibility = true;
        });
        profileBloc.getUserInfo(token);
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

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        closeIcon: Icon(
          Icons.close,
          color: Colors.black,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.black,
        ),
        //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          "From Camera",
          style: TextStyle(color: Colors.black),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(color: Colors.blue),
        ));
  }

  @override
  void initState() {
    super.initState();
    getData();
    observe();
  }

  void observe() {
    profileBloc.getProfileStream.listen((event) {
      setState(() {
        visibility = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // drawer: Drawer(
      //   child: SideMenu(),
      // ),
      // appBar: AppBarCommon(
      //   _scaffoldKey,
      //   scaffoldKey: _scaffoldKey,
      // ),
      backgroundColor: Constants.colors[9],
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Visibility(
                visible: !visibility,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder<UserGetResponse>(
                      stream: profileBloc.getProfileStream,
                      builder:
                          (context, AsyncSnapshot<UserGetResponse> snapshot) {
                        var data = snapshot.data?.userResponse?.data;
                        String? firstName = data?.items?[0].firstName;
                        String? lastName = data?.items?[0].lastName;
                        String? employeeNo = data?.items?[0].employeeNo;
                        String? hourlyRate =
                            data?.items?[0].hourlyRate.toString();
                        Items? item = data?.items?[0];
                        String fullName =
                            firstName.toString() + " " + lastName.toString();

                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Constants.colors[4],
                                          Constants.colors[3],
                                        ]),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(
                                  AppDefaults.padding,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.12,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: Image.network(
                                                'https://i.imgur.com/PJpPD6S.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: AppDefaults.margin),
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
                                                    fontFamily: "SFProMedium",
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Staff Nurses',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11.sp,
                                                  fontFamily: "S",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(height: 5),
                                            if (employeeNo != null)
                                              Text(
                                                employeeNo,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    fontFamily: "S",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            if (hourlyRate != null)
                                              Text(
                                                hourlyRate,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Constants.colors[8],
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            DrawableButton(
                                              onPressed: () {},
                                              label: "Edit",
                                              asset:
                                                  "assets/images/icon/swipe-to-right.svg",
                                              backgroundColor:
                                                  Constants.colors[4],
                                              textColors: Constants.colors[0],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppDefaults.margin),
                                    // Actions
                                  ],
                                ),
                              ),
                              if (null != item) ProfileDetailCard(items: item),
                              GestureDetector(
                                  onTap: () => getImage(ImgSource.Both),
                                  child: ProfileDocumentsCard()),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              Center(
                child: Visibility(
                  visible: visibility,
                  child: Container(
                    width: 100.w,
                    height: 80.h,
                    child: const Center(
                      child: LoadingWidget(),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
