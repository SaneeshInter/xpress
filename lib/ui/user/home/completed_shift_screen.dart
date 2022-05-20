import 'dart:core';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/blocs/shift_completed_bloc.dart';

import '../../../model/user_complted_shift.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../Widgets/buttons/build_button.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/timesheet_list_item.dart';
import '../common/app_bar.dart';
import '../common/side_menu.dart';

class CompletedShiftScreen extends StatefulWidget {
  const CompletedShiftScreen({Key? key}) : super(key: key);

  @override
  _CompletedShiftState createState() => _CompletedShiftState();
}

class _CompletedShiftState extends State<CompletedShiftScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime _selectedValue;
  bool visibility = false;
  bool buttonVisibility = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var token;
  var _image;
  List<String> list = [];

  @override
  void didUpdateWidget(covariant CompletedShiftScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {
        setState(() {
          visibility = true;
        });
        completeBloc.fetchcomplete(token);
      } else {
        showInternetNotAvailable();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    completeBloc.dispose();
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
          "From Camera",
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(color: Colors.blue),
        ));
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    observe();
  }

  void observe() {
    completeBloc.allShift.listen((event) {
      print("inside observer");
      setState(() {
        visibility = false;
      });

      var data = event.response?.data;
      print("data?.items?.length");
      print(data?.items?.length);
      if (data?.items != null) {
        print("data?.items?.length");
        print(data?.items?.length);
        // if (data?.items?.length != 0) {
        //   setState(() {
        //     buttonVisibility = true;
        //   });
        // }
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
      showAlertDialoge(context, message: message!, title: "Upload Timesheet");

      setState(() {
        visibility = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        // drawer: Drawer(
        //   child: SideMenu(),
        // ),
        // appBar: AppBarCommon(
        //   _scaffoldKey,
        //   scaffoldKey: _scaffoldKey,
        // ),
        backgroundColor: Constants.colors[9],
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context, dividedBy: 35)),
                  child: Column(children: [
                    SizedBox(height: screenHeight(context, dividedBy: 60)),
                    Container(
                        child: _image != null
                            ? Image.file(File(_image.path))
                            : Container()),
                    SizedBox(
                      height: 20,
                    ),
                    // if (buttonVisibility)
                      DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: [10, 10],
                        color: Colors.green,
                        strokeWidth: 1,
                        child: GestureDetector(
                          onTap: () {
                            print("On tap");
                            getImage(ImgSource.Both);
                          },
                          child: Container(
                            color: Colors.white,
                            width: 100.w,
                            height: 10.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icon/notification.svg',
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10),
                                Text("Upload Shift Document Photos"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: screenHeight(context, dividedBy: 60)),
                    StreamBuilder(
                        stream: completeBloc.allShift,
                        builder: (BuildContext context,
                            AsyncSnapshot<UserShoiftCompletedResponse>
                                snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data?.response?.data;
                            print("data?.items?.length");
                            print(data?.items?.length);
                            if (data?.items != null) {
                              if (data?.items?.length != 0) {
                                return buildList(snapshot);
                              } else {
                                return Column(
                                  children: [
                                    20.height,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Completed Shift',
                                            style: boldTextStyle(size: 20)),
                                        85.width,
                                        16.height,
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 32),
                                          child: Text(
                                              'There are no  completed shift found.',
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
                                );
                              }
                            }
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return Container();
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    // if (buttonVisibility)
                      BuildButton(
                        label: "Upload Timesheets",
                        onPressed: () {


                          String shiftid = "";
                          print("PRINT UPLOAD LISTS");
                          for (var item in list) {
                            shiftid = shiftid + item + ",";
                          }

                          print(shiftid);
                          if (_image != null) {
                            if (shiftid.isNotEmpty) {

                              setState(() {
                                visibility = true;
                              });
                              completeBloc.uploadTimeSheet(
                                  token, shiftid, File(_image.path));
                            } else {
                              showAlertDialoge(context,
                                  title: "Alert", message: "Select Shift");
                            }
                          } else {
                            showAlertDialoge(context,
                                title: "Alert", message: "Upload Timesheet");
                          }
                        },
                        key: null,
                      ),
                    SizedBox(
                      height: 20,
                    ),
                  ])),
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

  Widget buildList(AsyncSnapshot<UserShoiftCompletedResponse> snapshot) {
    var data = snapshot.data?.response?.data;
    return ListView.builder(
      itemCount: data?.items?.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var name = "Shift Reminder";
        var description = "Completed shift";
        var items = data?.items![index];
        return Column(
          children: [
            TimeSheetListWidget(
              onTapView: () {},
              onTapCall: () {},
              onTapMap: () {},
              onTapBooking: () {},
              items: items!,
              onCheckBoxClicked: (rowId, isSelect) {
                print(rowId);
                print(isSelect);
                if (isSelect) {
                  list.add(rowId.toString());
                } else {
                  list.remove(rowId.toString());
                }
                // String string = "";
                // for (var item in list) {
                //   string = string + item + ",";
                // }
                // print(string);
              },
            ),
            SizedBox(height: screenHeight(context, dividedBy: 100)),
          ],
        );
      },
    );
  }
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.red;
}
