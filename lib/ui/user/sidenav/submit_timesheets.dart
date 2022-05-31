import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/shift_completed_bloc.dart';
import '../../../blocs/user_timesheet_bloc.dart';
import '../../../ui/user/sidenav/user_time_sheet_details.dart';

import '../../../model/user_get_timesheet.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/user_timesheet_list_item.dart';

class SubmitTimeShift extends StatefulWidget {
  const SubmitTimeShift({Key? key}) : super(key: key);

  @override
  _CompletedShiftState createState() => _CompletedShiftState();
}

class _CompletedShiftState extends State<SubmitTimeShift> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime _selectedValue;

  bool buttonVisibility = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var token;
  var _image;
  List<String> list = [];

  @override
  void didUpdateWidget(covariant SubmitTimeShift oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {
        usertimesheetBloc.userGetTimeSheet(token);
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
          color: Colors.red,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          Txt.frm_camera,
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          Txt.frm_gallery,
          style: TextStyle(color: Colors.blue),
        ));
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    observe();
    getData();

  }

  void observe() {
    usertimesheetBloc.timesheetstream.listen((event) {
      var data = event.response?.data;
      if (data?.timeSheetInfo != null) {
        if (data?.timeSheetInfo?.length != 0) {
          setState(() {
            buttonVisibility = true;
          });
        }
      }
    });
    completeBloc.uploadStatus.listen((event) {
      print("event");
      print(event.response);
      var message = event.response?.status?.statusMessage;
      setState(() {
        _image = null;
      });
      getData();
      showAlertDialoge(context, message: message!, title: Txt.uplod_timesht);
    });
  }

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
            Txt.submtd_timsht,
            style: TextStyle(
                fontSize: 17,
                color: Constants.colors[1],
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        backgroundColor: Constants.colors[9],
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                StreamBuilder(
                    stream: usertimesheetBloc.timesheetstream,
                    builder: (BuildContext context,
                        AsyncSnapshot<UserTimeSheetRespo> snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data?.response?.data;
                        if (data?.timeSheetInfo != null) {
                          if (data?.timeSheetInfo?.length != 0) {
                            return buildList(snapshot);
                          } else {
                            return Center(
                              child: Column(
                                children: [
                                  20.height,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(Txt.submtd_timsht,
                                          style: boldTextStyle(size: 20)),
                                      85.width,
                                      16.height,
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 32),
                                        child: Text(Txt.no_completd_shfts,
                                            style: primaryTextStyle(size: 15),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  150.height,
                                  Image.asset(
                                      'assets/images/error/empty_task.png',
                                      height: 250),
                                ],
                              ),
                            );
                          }
                        }
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return Container();
                    }),
              ]),
            ),
            StreamBuilder(
              stream: usertimesheetBloc.visible,
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
      ),
    );
  }

  Widget buildList(AsyncSnapshot<UserTimeSheetRespo> snapshot) {
    var data = snapshot.data?.response?.data;
    return ListView.builder(
      itemCount: data?.timeSheetInfo?.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        TimeSheetInfo items = data!.timeSheetInfo![index];
        return Column(
          children: [
            UserTimeSheetListWidget(
              onTapView: (item) {
                if (items is TimeSheetInfo) {
                  TimeSheetInfo data = items;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserTimeSheetDetails(item: item),
                      ));
                }
              },
              onTapCall: () {},
              onTapMap: () {},
              onTapBooking: () {},
              items: items,
              onCheckBoxClicked: (rowId, isSelect) {
                print(rowId);
                print(isSelect);
                if (isSelect) {
                  list.add(rowId.toString());
                } else {
                  list.remove(rowId.toString());
                }
              },
            ),
            SizedBox(height: screenHeight(context, dividedBy: 100)),
          ],
        );
      },
    );
  }
}
