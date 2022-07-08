import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/user_timesheet_bloc.dart';
import '../../../model/user_get_timesheet.dart';
import '../../../model/user_time_sheet_details_respo.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/utils.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/user_timesheet_details_list_widget.dart';

class UserTimeSheetDetails extends StatefulWidget {
  final TimeSheetInfo? item;

  const UserTimeSheetDetails({Key? key, this.item}) : super(key: key);

  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends State<UserTimeSheetDetails> {
  var token;
  String? time_shhet_id = "";

  @override
  void initState() {
    getDataa();

    super.initState();
  }

  Future<void> getDataa() async {
    token = await TokenProvider().getToken();
    time_shhet_id = widget.item?.timeSheetId.toString();
    debugPrint(token.toString());
    if (null != token) {
      usertimesheetBloc.userGetTimeSheetDetails(token, time_shhet_id!);
    } else {
      debugPrint("TOKEN NOT FOUND");
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String? imageUrl = widget.item?.timeSheetLink;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/icon/arrow.svg',
            width: 5.w,
            height: 4.2.w,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
          //change your color here
        ),
        backgroundColor: HexColor("#ffffff"),
        title: AutoSizeText(
          Txt.timesht_details,
          style: TextStyle(fontSize: 17, color: Constants.colors[1], fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      backgroundColor: Constants.colors[9],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .4,
                    child: AutoSizeText(
                      Txt.time_sheet,
                      maxLines: 1,
                      style: TextStyle(
                        color: Constants.colors[1],
                        fontSize: 13.sp,
                        fontFamily: "SFProMedium",
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            child: imageUrl != null
                                ?
                            CachedNetworkImage(
                              width:double.infinity,
                              height:300,
                                    useOldImageOnUrlChange: true,
                                    imageUrl: imageUrl,
                                    imageBuilder: (context, imageProvider) => DecoratedBox(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Image.asset("assets/images/icon/loading_bar.gif"),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  )
                                // Image.network(
                                //                 imageUrl,
                                //                 fit: BoxFit.cover,
                                //               )
                                : const SizedBox()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          child: AutoSizeText(
                            Txt.shifts,
                            maxLines: 1,
                            style: TextStyle(
                              color: Constants.colors[1],
                              fontSize: 13.sp,
                              fontFamily: "SFProMedium",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight(context, dividedBy: 60)),
                StreamBuilder(
                    stream: usertimesheetBloc.timedetailststream,
                    builder: (BuildContext context, AsyncSnapshot<UserTimeSheetDetailsRespo> snapshot) {
                      if (snapshot.hasData) {
                        return buildList(snapshot);
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return const SizedBox();
                    }),
                SizedBox(
                  height: 5.w,
                ),
                SizedBox(
                  height: 10.w,
                ),
              ],
            ),
            Container(
              width: 100.w,
              height: 70.h,
              child: StreamBuilder(
                stream: usertimesheetBloc.visible,
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

  Widget buildList(AsyncSnapshot<UserTimeSheetDetailsRespo> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.response?.data?.timeSheetDetails?.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (null != snapshot.data?.response?.data?.timeSheetDetails) {
          TimeSheetDetails? timeSheetDetails = snapshot.data?.response?.data?.timeSheetDetails![index];

          return Column(
            children: [
              UserTimeSheetDetailsListWidget(
                items: timeSheetDetails!,
                onTapView: () {},
                onTapCall: () {},
                onTapMap: () {},
                onTapBooking: () {
                  debugPrint("Tapped");
                  showBookingAlert(context, date: Txt.show_timsheet);
                },
                key: null,
                onCheckBoxClicked: () {},
                onRejectCheckBoxClicked: () {},
              ),
              SizedBox(height: screenHeight(context, dividedBy: 100)),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
