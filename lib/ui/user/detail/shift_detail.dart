import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/strings.dart';

import '../../../Constants/sharedPrefKeys.dart';
import '../../../blocs/shift_list_bloc.dart';
import '../../../blocs/shift_user_details.dart';
import '../../../model/user_get_shift_details.dart';
import '../../../ui/user/detail/shift_rows.dart';
import '../../../ui/widgets/buttons/call_button.dart';
import '../../../ui/widgets/loading_widget.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
import '../../../utils/utils.dart';
import '../../bloc/no_data_screen.dart';
import '../../widgets/buttons/book_button_green.dart';
import 'drawable_custom_row.dart';

class ShiftDetailScreen extends StatefulWidget {
  final String shift_id;
  final bool isCompleted;

  const ShiftDetailScreen(
      {Key? key, required this.shift_id, required this.isCompleted})
      : super(key: key);

  @override
  State<ShiftDetailScreen> createState() => _ShiftDetailScreenState();
}

class _ShiftDetailScreenState extends State<ShiftDetailScreen> {
  @override
  void initState() {
    super.initState();
    observe();
    getDataz();
  }

  void requestShift() {
    bloc.fetchuserJobRequest(widget.shift_id.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getDataz() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    bloc.token = shdPre.getString(SharedPrefKey.AUTH_TOKEN);
    usershiftdetailsBloc.token = shdPre.getString(SharedPrefKey.AUTH_TOKEN);
    usershiftdetailsBloc.fetchGetUserShiftDetailsResponse(widget.shift_id);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    const newRouteName = "/ShiftDetailScreen";
    bool isNewRouteSameAsCurrent = false;
    Navigator.popUntil(context, (route) {
      if (route.settings.name == newRouteName) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.colors[9],
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: StreamBuilder(
                  stream: usershiftdetailsBloc.usershiftdetailsStream,
                  builder: (context,
                      AsyncSnapshot<GetUserShiftDetailsResponse> snapshot) {
                    if (snapshot.data?.response?.data != null) {
                      var data = snapshot.data?.response?.data;

                      var hospitalDetail = data?.hospitalDetails?[0]??HospitalDetails();
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
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          SizedBox(
                                            width:
                                                MediaQuery.of(context).size.width,
                                            height: 30.h,
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(10),
                                              // Image radius
                                              child:CachedNetworkImage(
                                                imageUrl: hospitalDetail.photo!,
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) => Image.asset("assets/images/icon/loading_bar.gif"),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                                          // hospitalDetail
                                                          //         .latitude =
                                                          //     "27.2046";
                                                          // hospitalDetail
                                                          //         .longitude =
                                                          //     "77.4977";
                                                          if(null!=hospitalDetail
                                                              .latitude && null!= hospitalDetail
                                                              .longitude && "" != hospitalDetail
                                                              .latitude && ""!= hospitalDetail
                                                              .longitude)
                                                            {
                                                              navigateTo(
                                                                  double.parse(
                                                                      hospitalDetail
                                                                          .latitude!),
                                                                  double.parse(
                                                                      hospitalDetail
                                                                          .longitude!));
                                                            }else{
                                                            Fluttertoast.showToast(msg: 'Location not found');
                                                          }

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
                                                                  Txt.view_map,
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
                                      decoration: const BoxDecoration(
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
                                                    label: Txt.address_dot +
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
                                                      label:Txt.from +
                                                          convert24hrTo12hr( shiftDetails.timeFrom
                                                              .toString())  +
                                                          Txt.to+
                                                          convert24hrTo12hr ( shiftDetails.timeTo
                                                              .toString()),
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
                                                  const Padding(
                                                    padding: EdgeInsets.all(
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
                                                      label:Txt.job_details_dot +
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
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: [
                                              if (shiftDetails?.if_requested == -1)
                                                BookButtonGreen(
                                                    onPressed: () async {
                                                      // use the information provided
                                                      requestShift();
                                                    },
                                                    label: Txt.book_this_shift),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15.0),
                                            child: CallButtons(onPressed: () {
                                              dialCall(usershiftdetailsBloc
                                                  .hospitalNumber);
                                            }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16),
                          ),
                        ],
                      );
                    } else {
                      return const  NoDataWidget(
                          tittle: Txt.notfound,
                          description: Txt.noshift,
                          asset_image:
                          "assets/images/error/empty_task.png");
                    }
                  }),
            ),
            StreamBuilder(
              stream: usershiftdetailsBloc.visible,
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
      ),
    );
  }

  void observe() {
    bloc.jobrequest.listen((event) {
      String? message = event.response?.status?.statusMessage;
      getDataz();
      //Fluttertoast.showToast(msg: '$message');
    });

    usershiftdetailsBloc.usershiftdetailsStream.listen((event) {
      var hospitalDetail = event.response?.data?.hospitalDetails?[0]??HospitalDetails();
      if (null != hospitalDetail) {
        usershiftdetailsBloc.hospitalNumber = hospitalDetail.phone??"";
      }
    });
  }
}
