import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/blocs/shift_user_details.dart';
import 'package:xpresshealthdev/model/user_get_shift_details.dart';
import 'package:xpresshealthdev/ui/user/detail/shift_rows.dart';

import '../../../Constants/sharedPrefKeys.dart';
import '../../../ui/widgets/loading_widget.dart';
import '../../../utils/constants.dart';
import '../../Widgets/buttons/call_button.dart';
import '../../Widgets/buttons/submit_button.dart';
import '../common/app_bar.dart';
import '../common/side_menu.dart';
import 'drawable_custom_row.dart';

class ShiftDetailScreen extends StatefulWidget {

  final String shift_id;
  const ShiftDetailScreen({Key? key, required this.shift_id}) : super(key: key);

  @override
  State<ShiftDetailScreen> createState() => _ShiftDetailScreenState();
}


class _ShiftDetailScreenState extends State<ShiftDetailScreen> {
  String? token;

  @override
  void initState() {
    // TODO: implement initState
    getDataz();
    super.initState();
  }

  Future getDataz() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    token = shdPre.getString(SharedPrefKey.AUTH_TOKEN);
    print("token inn deta");
    print(token);
    print(widget.shift_id);
    usershiftdetailsBloc.fetchGetUserShiftDetailsResponse(
        token!, widget.shift_id);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    getDataz();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SideMenu(),
      ),
      appBar: AppBarCommon(
        _scaffoldKey,
        scaffoldKey: _scaffoldKey,
      ),
      backgroundColor: Constants.colors[9],
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: usershiftdetailsBloc.usershiftdetailsStream,
            builder:
                (context, AsyncSnapshot<GetUserShiftDetailsResponse> snapshot) {
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
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30.h,
                                  child: SizedBox.fromSize(
                                      size: Size.fromRadius(10), // Image radius
                                      child: Image.network(
                                        hospitalDetail.photo!,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            ),
                          if (null != hospitalDetail)
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
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
                                      Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 14, top: 10),
                                                child: Text(
                                                  "At. " +
                                                      hospitalDetail
                                                          .hospitalName
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontFamily: "SFProMedium",
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
                                                      "AM To " +
                                                      shiftDetails.timeFrom
                                                          .toString() +
                                                      " PM",
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
                                                onPressed: () {},
                                                label: hospitalDetail.email
                                                    .toString(),
                                                asset:
                                                "assets/images/icon/email.svg",
                                                textColors: Colors.black,
                                                size: 9.sp,
                                              ),
                                              CustomRow(
                                                onPressed: () {},
                                                label: hospitalDetail.phone
                                                    .toString(),
                                                asset:
                                                "assets/images/icon/price-tag.svg",
                                                textColors: Colors.black,
                                                size: 9.sp,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(12.0),
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
                                                  asset:
                                                  "assets/images/icon/check.svg",
                                                  textColors: Colors.black,
                                                ),

                                              // if (null != shiftDetails)
                                              //   CustomRowz(
                                              //     onPressed: () {},
                                              //     label: "Date : " +
                                              //         shiftDetails.date
                                              //             .toString(),
                                              //     asset:
                                              //     "assets/images/icon/check.svg",
                                              //     textColors: Colors.black,
                                              //   ),
                                              // if (null != shiftDetails)
                                              //   CustomRow(
                                              //     onPressed: () {},
                                              //     label: "From : " +
                                              //         shiftDetails.timeFrom
                                              //             .toString() +
                                              //         "AM To : " +
                                              //         shiftDetails.timeFrom
                                              //             .toString() +
                                              //         " PM",
                                              //     asset:
                                              //     "assets/images/icon/check.svg",
                                              //     textColors: Colors.black,
                                              //     size: 9.sp,
                                              //   ),
                                              // if (null != shiftDetails)
                                              //   CustomRowz(
                                              //     onPressed: () {},
                                              //     label: "Price : " +
                                              //         shiftDetails.price
                                              //             .toString(),
                                              //     asset:
                                              //     "assets/images/icon/check.svg",
                                              //     textColors: Colors.black,
                                              //   ),
                                              // if (null != shiftDetails)
                                              //   CustomRowz(
                                              //     onPressed: () {},
                                              //     label: "Category : " +
                                              //         shiftDetails.category
                                              //             .toString(),
                                              //     asset:
                                              //     "assets/images/icon/check.svg",
                                              //     textColors: Colors.black,
                                              //   ),
                                              // if (null != shiftDetails)
                                              //   CustomRowz(
                                              //     onPressed: () {},
                                              //     label: "UserType : " +
                                              //         shiftDetails.userType
                                              //             .toString(),
                                              //     asset:
                                              //     "assets/images/icon/check.svg",
                                              //     textColors: Colors.black,
                                              //   ),
                                              // if (null != shiftDetails)
                                              //   CustomRowz(
                                              //     onPressed: () {},
                                              //     label: "Shift ype : " +
                                              //         shiftDetails.type
                                              //             .toString(),
                                              //     asset:
                                              //     "assets/images/icon/check.svg",
                                              //     textColors: Colors.black,
                                              //   ),
                                              // SizedBox(
                                              //   height: 3.h,
                                              // ),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 8.0),
                                              //
                                              // ),
                                              SizedBox(
                                                height: 3.h,
                                              ),


                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
      ),
    );
  }
}


