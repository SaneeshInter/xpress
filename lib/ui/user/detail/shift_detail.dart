import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xpresshealthdev/blocs/shift_user_details.dart';
import 'package:xpresshealthdev/model/user_get_shift_details.dart';
import 'package:xpresshealthdev/ui/user/detail/shift_rows.dart';
import 'package:xpresshealthdev/ui/widgets/buttons/call_button.dart';
import 'package:xpresshealthdev/utils/network_utils.dart';

import '../../../Constants/sharedPrefKeys.dart';
import '../../../blocs/shift_list_bloc.dart';
import '../../../model/user_complted_shift.dart';
import '../../../ui/widgets/loading_widget.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../Widgets/buttons/book_button.dart';
import '../../Widgets/buttons/submit_button.dart';
import '../../widgets/buttons/login_button.dart';
import '../common/app_bar.dart';
import '../common/side_menu.dart';
import 'drawable_custom_row.dart';

class ShiftDetailScreen extends StatefulWidget {
  final String shift_id;
  final bool isCompleted;

  const ShiftDetailScreen({Key? key, required this.shift_id,required this.isCompleted}) : super(key: key);

  @override
  State<ShiftDetailScreen> createState() => _ShiftDetailScreenState();
}

class _ShiftDetailScreenState extends State<ShiftDetailScreen> {
  String? token;
  bool visibility = false;
  String hospitalNumber = "";

  @override
  void initState() {
    super.initState();
    observe();
    getDataz();
  }

  void requestShift() {
    setState(() {
      visibility = true;
    });
    bloc.fetchuserJobRequest(token!, widget.shift_id.toString());
  }



  @override
  void dispose() {
    super.dispose();
    // usershiftdetailsBloc.dispose();
  }

  Future getDataz() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    token = shdPre.getString(SharedPrefKey.AUTH_TOKEN);
    print("token inn deta");
    print(token);
    print(widget.shift_id);
    print("widget.isCompleted");
    print(widget.isCompleted);
    usershiftdetailsBloc.fetchGetUserShiftDetailsResponse(
        token!, widget.shift_id);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.colors[9],
      body: SingleChildScrollView(
        child: Stack(
          children: [
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
            StreamBuilder(
                stream: usershiftdetailsBloc.usershiftdetailsStream,
                builder: (context,
                    AsyncSnapshot<GetUserShiftDetailsResponse> snapshot) {
                  if (snapshot.data?.response?.data != null) {
                    var data = snapshot.data?.response?.data;
                    var hospitalDetail = data?.hospitalDetails![0];
                    var shiftDetails = data?.shiftDetails![0];
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 10),
                          child: Column(
                            children: [
                              if (null != hospitalDetail)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30.h,
                                          child: SizedBox.fromSize(
                                              size: Size.fromRadius(10),
                                              // Image radius
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                'assets/images/icon/loading_bar.gif',
                                                image: hospitalDetail.photo!,
                                                placeholderScale: 1,
                                                fit: BoxFit.cover,
                                              ),

                                        ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            color: Colors.black,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  if (null != shiftDetails)
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                          shiftDetails.date
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 9.sp,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                "SFProMedium",
                                                          )),
                                                    ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        hospitalDetail
                                                                .latitude =
                                                            "27.2046";
                                                        hospitalDetail
                                                                .longitude =
                                                            "77.4977";
                                                        navigateTo(
                                                            double.parse(
                                                                hospitalDetail
                                                                    .latitude!),
                                                            double.parse(
                                                                hospitalDetail
                                                                    .longitude!));
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0),
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/images/icon/google_map.svg",
                                                              height: 4.w,
                                                              width: 4.w,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0),
                                                            child: Text(
                                                                "View Location Map",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      9.sp,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "SFProMedium",
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (null != hospitalDetail)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Stack(children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 14, top: 10),
                                                  child: Text(
                                                    hospitalDetail.hospitalName
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.sp,
                                                        fontFamily:
                                                            "SFProMedium",
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                CustomRow(
                                                  onPressed: () {},
                                                  label: "Address: " +
                                                      hospitalDetail.address
                                                          .toString(),
                                                  asset:
                                                      "assets/images/icon/location.svg",
                                                  textColors: Colors.black,
                                                  size: 9.sp,
                                                ),
                                                if (null != shiftDetails)
                                                  CustomRow(
                                                    onPressed: () {},
                                                    label: "From " +
                                                        shiftDetails.timeFrom
                                                            .toString() +
                                                        " To " +
                                                        shiftDetails.timeFrom
                                                            .toString(),
                                                    asset:
                                                        "assets/images/icon/time.svg",
                                                    textColors: Colors.black,
                                                    size: 9.sp,
                                                  ),
                                                CustomRow(
                                                  onPressed: () {},
                                                  label: hospitalDetail
                                                      .hospitalName
                                                      .toString(),
                                                  asset:
                                                      "assets/images/icon/ward.svg",
                                                  textColors: Colors.black,
                                                  size: 9.sp,
                                                ),
                                                CustomRow(
                                                  onPressed: () {
                                                    sendingMails(
                                                        hospitalDetail.email!);
                                                  },
                                                  label: hospitalDetail.email
                                                      .toString(),
                                                  asset:
                                                      "assets/images/icon/email.svg",
                                                  textColors: Colors.black,
                                                  size: 9.sp,
                                                ),
                                                if (null !=
                                                        hospitalDetail.phone &&
                                                    hospitalDetail
                                                        .phone!.isNotEmpty)
                                                  CustomRow(
                                                    onPressed: () {
                                                      dialCall(hospitalDetail
                                                          .phone!);
                                                    },
                                                    label: hospitalDetail.phone
                                                        .toString(),
                                                    asset:
                                                        "assets/images/icon/price-tag.svg",
                                                    textColors: Colors.black,
                                                    size: 9.sp,
                                                  ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    indent: 12,
                                                    endIndent: 12,
                                                  ),
                                                ),
                                                if (null != shiftDetails)
                                                  CustomRowz(
                                                    onPressed: () {},
                                                    label: " Job Details: " +
                                                        shiftDetails.jobDetails
                                                            .toString(),
                                                    asset: "",
                                                    textColors: Colors.black,
                                                  ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              if (!widget.isCompleted)
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Row(
                                  children: [
                                    LoginButton(
                                        onPressed: () async {
                                          // use the information provided
                                          requestShift();
                                        },
                                        label: "Book This Shift"),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: CallButtons(onPressed: () {
                                        print("call");
                                        print(hospitalNumber);
                                        dialCall(hospitalNumber);
                                      }),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      width: 100.w,
                      height: 80.h,
                      child: const Center(
                        child: LoadingWidget(),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  void observe() {
    usershiftdetailsBloc.usershiftdetailsStream.listen((event) {
      var hospitalDetail = event.response?.data?.hospitalDetails![0];
      if(mounted)

      setState(() {
        visibility = false;
        if (null != hospitalDetail) {
          hospitalNumber = hospitalDetail.phone!;
        }
      });
    });
  }
}
