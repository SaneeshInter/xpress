import 'dart:core';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import '../../../blocs/shift_completed_bloc.dart';
import '../../../ui/bloc/no_data_screen.dart';
import '../../../Constants/strings.dart';
import '../../../model/user_complted_shift.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../Widgets/buttons/build_button.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/timesheet_list_item.dart';

class CompletedShiftScreen extends StatefulWidget {
  const CompletedShiftScreen({Key? key}) : super(key: key);

  @override
  _CompletedShiftState createState() => _CompletedShiftState();
}

class _CompletedShiftState extends State<CompletedShiftScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didUpdateWidget(covariant CompletedShiftScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    completeBloc.token = await TokenProvider().getToken();
    if (null != completeBloc.token) {
      if (await isNetworkAvailable()) {
        completeBloc.fetchcomplete();
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

  // Future getImage(ImgSource source) async {
  //   var image = await ImagePickerGC.pickImage(
  //       enableCloseButton: true,
  //       closeIcon: Icon(
  //         Icons.close,
  //        color:Constants.colors[14],
  //         size: 12,
  //       ),
  //       context: context,
  //       source: source,
  //       barrierDismissible: true,
  //       cameraIcon: Icon(
  //         Icons.camera_alt,
  //           color:  Constants.colors[14]
  //       ), galleryIcon: Icon(
  //     Icons.image,color: Constants.colors[14],
  //   ),
  //
  //       cameraText: Text(
  //         Txt.frm_camera,
  //         style: TextStyle(color:Constants.colors[14]),
  //       ),
  //       galleryText: Text(
  //         Txt.frm_gallery,
  //         style: TextStyle(color: Constants.colors[14]),
  //       ));
  //   setState(() {
  //     completeBloc.image = image;
  //   });
  // }
  void funcBottomSheet(BuildContext context, String type) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final response = await getImage(ImageSource.gallery);
                  if (response != null) {
                    completeBloc.image = response;
                    setState(() {});
                  }
                },
                leading: const Icon(
                  Icons.camera_enhance_sharp,
                  color: black,
                ),
                title: const Text(
                  'Camera',
                  softWrap: true,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: black),
                title: const Text(
                  'Gallery',

                ),
                onTap: () async {
                  Navigator.pop(context);
                  final response = await getImage(ImageSource.gallery);
                  if (response != null) {
                    completeBloc.image = response;
                    setState(() {});
                  }
                },
              ),
            ],
          );
        });
  }
  @override
  void initState() {
    super.initState();
    observe();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  void observe() {
    completeBloc.allShift.listen((event) {
      var data = event.response?.data;
      if (data?.items != null) {
        print("data?.items?.length");
        print(data?.items?.length);
        if (data?.items?.length != 0) {
          setState(() {
            completeBloc.buttonVisibility = true;
          });
        } else {
          setState(() {
            completeBloc.buttonVisibility = false;
          });
        }
      }
    });
    completeBloc.uploadStatus.listen((event) {
      var message = event.response?.status?.statusMessage;
      setState(() {
        completeBloc.image = null;
      });
      getData();
      Fluttertoast.showToast(msg: '$message');
    });
  }

  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getData();
        },
        label: const Text(Txt.refresh),
        icon: const Icon(Icons.refresh),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Constants.colors[9],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, dividedBy: 35)),
                child: Column(children: [
                  StreamBuilder(
                      stream: completeBloc.allShift,
                      builder: (BuildContext context,
                          AsyncSnapshot<UserShoiftCompletedResponse> snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        if (!snapshot.hasData ||
                            null == snapshot.data?.response?.data?.items ||
                            snapshot.data?.response?.data?.items?.length == 0) {
                          return NoDataWidget(
                              tittle: Txt.empty,
                              description: Txt.no_shifts_working_hrs,
                              asset_image:
                                  "assets/images/error/empty_task.png");
                        }
                        return buildList(snapshot);
                      }),
                  SizedBox(
                    height: 10,
                  ),
                ])),
          ),
          StreamBuilder(
            stream: completeBloc.visible,
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
    );
  }

  Widget buildList(AsyncSnapshot<UserShoiftCompletedResponse> snapshot) {
    var data = snapshot.data?.response?.data;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeight(context, dividedBy: 60)),
          Container(
              child: completeBloc.image != null
                  ? Image.file(File(completeBloc.image.path))
                  : Container()),
          SizedBox(
            height: 20,
          ),
          if (completeBloc.buttonVisibility)
            DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: [10, 10],
              color: Colors.green,
              strokeWidth: 1,
              child: GestureDetector(
                onTap: () {
                  funcBottomSheet(context,"Image");
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
                      Text(Txt.uplaod_shift_doc),
                    ],
                  ),
                ),
              ),
            ),
          SizedBox(height: screenHeight(context, dividedBy: 60)),
          ListView.builder(
            itemCount: data?.items?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
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
                        completeBloc.list.add(rowId.toString());
                      } else {
                        completeBloc.list.remove(rowId.toString());
                      }
                    },
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 100)),
                ],
              );
            },
          ),
          if (completeBloc.buttonVisibility)
            BuildButton(
              label: Txt.upload_timesheets,
              onPressed: () {
                String shiftid = "";

                for (var item in completeBloc.list) {
                  shiftid = shiftid + item + ",";
                }
                print(shiftid);
                if (completeBloc.image != null) {
                  if (shiftid.isNotEmpty) {
                    completeBloc.uploadTimeSheet(
                        shiftid, File(completeBloc.image.path));
                  } else {
                    showAlertDialoge(context,
                        title: Txt.alert, message: Txt.select_shift);
                  }
                } else {
                  showAlertDialoge(context,
                      title: Txt.alert, message: Txt.uplod_timesht);
                }
              },
              key: null,
            ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
