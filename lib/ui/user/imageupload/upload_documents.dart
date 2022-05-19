import 'dart:core';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/profile_update_bloc.dart';
import '../../../main.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../utils/validator.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/input_text.dart';
import '../../widgets/loading_widget.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({Key? key}) : super(key: key);

  @override
  _UploadDocumentsState createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocumentsScreen> {
  var type;
  var imageUri;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime _selectedValue;
  bool visibility = false;
  bool buttonVisibility = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var token;
  var _image;
  List<String> list = [];
  TextEditingController date = new TextEditingController();

  @override
  void didUpdateWidget(covariant UploadDocumentsScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> showInternetNotAvailable() async {
    int respo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );
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
    observe();
    getToken();
  }

  Future<void> getToken() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      setState(() {
        visibility = false;
      });
    } else {
      return;
    }
  }

  void observe() {
    profileBloc.userdocuments.listen((event) {
      print("event");
      print(event.response);
      var message = event.response?.status?.statusMessage;
      setState(() {
        _image = null;
      });
      showAlertDialoge(context, message: message!, title: "Upload Documents");

      setState(() {
        visibility = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    type = args.type;
    imageUri = args.imgUrl;
    date.text = args.expiry;
    print("type");
    print(type);
    print(imageUri);
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    return SafeArea(
      child: Scaffold(
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
            "Upload Documents",
            style: TextStyle(
                fontSize: 17,
                color: Constants.colors[1],
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                getImage(ImgSource.Both);
              },
              icon: Image.asset(
                'assets/images/icon/add.png',
                width: 5.w,
                color: Colors.black,
                height: 5.w,
              ), //Image.asset('assets/images/icon/searchicon.svg',width: 20,height: 20,fit: BoxFit.contain,),
            ),
          ],
        ),
        key: _scaffoldKey,
        backgroundColor: Constants.colors[9],
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context, dividedBy: 35)),
                        child: Column(children: [
                          SizedBox(
                              height: screenHeight(context, dividedBy: 60)),
                          if (null != imageUri && null == _image)
                            Container(
                                height: 70.h,
                                width: 100.w,
                                child: imageUri != null
                                    ? InteractiveViewer(
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/icon/loading_bar.gif',
                                          image: imageUri,
                                          placeholderScale: 4,
                                        ),
                                      )
                                    : Container()),
                          if (null != _image)
                            SizedBox(
                                height: 70.h,
                                width: 100.w,
                                child: _image != null
                                    ? InteractiveViewer(
                                        child: Image.file(
                                          File(_image.path),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Container()),
                          SizedBox(
                            height: 20,
                          ),
                          if (type != "signature")
                          Container(
                            width: 100.w,
                            height: 5.3.h,
                            child: TextInputFileds(
                                controlr: date,
                                validator: (date) {
                                  if (validDate(date))
                                    return null;
                                  else
                                    return "select date";
                                },
                                onTapDate: () {
                                  selectDate(context, date);
                                },
                                hintText: "Expiry Date",
                                keyboadType: TextInputType.none,
                                isPwd: false),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (null != _image)
                            DottedBorder(
                              borderType: BorderType.RRect,
                              dashPattern: [10, 10],
                              color: Colors.green,
                              strokeWidth: 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (_image != null) {
                                    setState(() {
                                      visibility = true;
                                    });
                                    if (date.text != "" ||
                                        type == "signature") {
                                      profileBloc.uploadUserDoc(token,
                                          File(_image.path), type, date.text);
                                    } else {
                                      showAlertDialoge(context,
                                          title: "Expiry Date ",
                                          message: "Expiry date required");
                                    }
                                  } else {
                                    showAlertDialoge(context,
                                        title: "Alert",
                                        message: "Upload Timesheet");
                                  }
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
                                      Text("Upload  Documents"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                              height: screenHeight(context, dividedBy: 60)),
                          SizedBox(
                            height: 10,
                          ),
                        ])),
                  ),
                ],
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