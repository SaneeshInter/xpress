import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/strings.dart';

import '../../../../utils/constants.dart';
import '../../../Constants/sharedPrefKeys.dart';
import '../../../blocs/manager_view_detail.dart';
import '../../../model/manager_view_request.dart';
import '../../../ui/widgets/loading_widget.dart';
import '../../../utils/network_utils.dart' as network;
import '../../../utils/utils.dart';
import '../../bloc/no_data_screen.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../user/detail/drawable_custom_row.dart';
import '../../widgets/request_user_list.dart';

class ShiftDetailManagerScreen extends StatefulWidget {
  final String shiftId;

  const ShiftDetailManagerScreen({Key? key, required this.shiftId}) : super(key: key);

  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends State<ShiftDetailManagerScreen> {
  String? token;
  bool visibility = false;
  String? jobRequestRowId;
  bool visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    observe();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    managerViewRequestBloc.dispose();
  }

  Future getData() async {
    if (await isNetworkAvailable()) {
      SharedPreferences shdPre = await SharedPreferences.getInstance();
      token = shdPre.getString(SharedPrefKey.AUTH_TOKEN);
      debugPrint("token inn deta");
      debugPrint(token);
      debugPrint(widget.shiftId);
      managerViewRequestBloc.fetchManagerViewRequest(token!, widget.shiftId);
    } else {
      showInternetNotAvailable();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colors[9],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            StreamBuilder(
                stream: managerViewRequestBloc.managerViewRequest,
                builder: (context, AsyncSnapshot<ManagerViewRequestResponse> snapshot) {
                  if (snapshot.data?.response?.data != null) {
                    var data = snapshot.data?.response?.data;
                    if (null != data?.hospitalDetails) {
                      var hospitalDetail = data?.hospitalDetails![0];
                      var shiftDetails = data?.shiftDetails![0];
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                            child: Column(
                              children: [
                                if (null != hospitalDetail)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 30.h,
                                        child: SizedBox.fromSize(
                                            size: const Size.fromRadius(10),
                                            // Image radius
                                            child: Image.network(
                                              hospitalDetail.photo!,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ),
                                  ),
                                if (null != hospitalDetail)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: DecoratedBox(
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
                                            Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 14, top: 10),
                                                      child: Text(
                                                        hospitalDetail.hospitalName.toString(),
                                                        style: TextStyle(color: Colors.black, fontSize: 16.sp, fontFamily: "SFProMedium", fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                    CustomRow(
                                                      onPressed: () {},
                                                      label: Txt.address_dot + hospitalDetail.address.toString(),
                                                      asset: "assets/images/icon/location.svg",
                                                      textColors: Colors.black,
                                                      size: 9.sp,
                                                    ),
                                                    if (null != shiftDetails)
                                                      CustomRow(
                                                        onPressed: () {},
                                                        label: Txt.from +
                                                            convert24hrTo12hr(shiftDetails.timeFrom.toString()) +
                                                            Txt.to  +
                                                            convert24hrTo12hr(shiftDetails.timeTo.toString()),
                                                        asset: "assets/images/icon/time.svg",
                                                        textColors: Colors.black,
                                                        size: 9.sp,
                                                      ),
                                                    CustomRow(
                                                      onPressed: () {},
                                                      label: hospitalDetail.hospitalName.toString(),
                                                      asset: "assets/images/icon/ward.svg",
                                                      textColors: Colors.black,
                                                      size: 9.sp,
                                                    ),
                                                    CustomRow(
                                                      onPressed: () {},
                                                      label: hospitalDetail.email.toString(),
                                                      asset: "assets/images/icon/email.svg",
                                                      textColors: Colors.black,
                                                      size: 9.sp,
                                                    ),
                                                    CustomRow(
                                                      onPressed: () {},
                                                      label: hospitalDetail.phone.toString(),
                                                      asset: "assets/images/icon/price-tag.svg",
                                                      textColors: Colors.black,
                                                      size: 9.sp,
                                                    ),
                                                    if (null != shiftDetails)
                                                      CustomRow(
                                                        onPressed: () {},
                                                        label:Txt.post_code + (shiftDetails.poCode??"").toString(),
                                                        //shiftDetails.poCode.toString(),
                                                        asset: "assets/images/icon/price-tag.svg",
                                                        textColors: Colors.black,
                                                        size: 9.sp,
                                                      ),
                                                    const Padding(
                                                      padding: EdgeInsets.all(12.0),
                                                      child: Divider(
                                                        thickness: 1,
                                                        indent: 12,
                                                        endIndent: 12,
                                                      ),
                                                    ),
                                                    if (null != shiftDetails)
                                                      Html(
                                                        data: Txt.job_details_dot +
                                                            shiftDetails.jobDetails
                                                                .toString(),
                                                      ),
                                                    data!.shiftDetails![0].allowances!.isNotEmpty?
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: ListView.builder(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: data.shiftDetails![0].allowances?.length??0,
                                                        shrinkWrap: true,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          var val = data.shiftDetails![0].allowances![index];
                                                          return index==0?Column(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Row(
                                                                  children: const [
                                                                    Expanded(flex: 2, child: Text("Category",style: TextStyle(fontWeight: FontWeight.bold,color: black),)),
                                                                    Expanded(flex: 2, child: Text(" Allowance",style: TextStyle(fontWeight: FontWeight.bold,color: black),)),
                                                                    Expanded(flex: 1, child: Text("Price",textAlign: TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold,color: black),)),
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider(),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(flex: 2, child: Text(val.category_name ?? "")),
                                                                    Expanded(flex: 2, child: Text(val.allowance_name ?? "")),
                                                                    Expanded(flex: 1, child: Text(val.price ?? "",textAlign: TextAlign.end,)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ): Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Expanded(flex: 2, child: Text(val.category_name ?? "")),
                                                                Expanded(flex: 2, child: Text(val.allowance_name ?? "")),
                                                                Expanded(flex: 1, child: Text(val.price ?? "",textAlign: TextAlign.end,)),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ):SizedBox(),
                                                      // CustomRowz(
                                                      //   onPressed: () {},
                                                      //   label: Txt.job_details_dot + shiftDetails!.jobDetails.toString(),
                                                      //   asset: "assets/images/icon/check.svg",
                                                      //   textColors: Colors.black,
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
                          const Padding(
                            padding: EdgeInsets.all(16),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  Txt.users_request,
                                  style: TextStyle(fontSize: 11.sp, color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                itemCount: snapshot.data?.response?.data?.jobRequestDetails?.length??0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      RequestuserListWidget(
                                        onTapView: () {},
                                        onTapCall: () {},
                                        onTapMap: () {},
                                        onTapBooking: (JobRequestDetails item) {
                                          debugPrint("Tapped");
                                          acceptJobRequest(item);
                                        },
                                        item: snapshot.data!.response!.data!.jobRequestDetails![index],
                                      ),
                                      SizedBox(height: screenHeight(context, dividedBy: 100)),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
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
                  } else {
                    return const SizedBox();
                  }
                }),
            SizedBox(
              width: 100.w,
              height: 70.h,
              child: StreamBuilder(
                stream: managerViewRequestBloc.visible,
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

  void acceptJobRequest(JobRequestDetails item) {
    managerViewRequestBloc.fetchAcceptJobRequestResponse(token!, item.rowId.toString());
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

  void observe() {
    managerViewRequestBloc.acceptJobRequest.listen((event) {
      var message = event.response?.status?.statusMessage;
      showAlertDialoge(context, title:"STATUS" , message: message!);
      getData();
    });
  }
}
