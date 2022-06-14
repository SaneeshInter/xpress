import 'dart:core';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/internet_file.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pdfx/pdfx.dart';

// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/strings.dart';
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
  late PdfController _pdfController;
  List<String> list = [];
  TextEditingController date = TextEditingController();

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

  // Future getImage(ImgSource source) async {
  //   var image = await ImagePickerGC.pickImage(
  //       enableCloseButton: true,
  //       closeIcon: Icon(
  //         Icons.close,
  //         color: Constants.colors[14],
  //         size: 12,
  //       ),
  //       context: context,
  //       source: source,
  //       barrierDismissible: true,
  //       cameraIcon: Icon(
  //         Icons.camera_alt,
  //         color: Constants.colors[14],
  //       ),
  //       galleryIcon: Icon(
  //         Icons.image,
  //         color: Constants.colors[14],
  //       ),
  //       //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
  //       cameraText: Text(
  //         Txt.frm_camera,
  //         style: TextStyle(color: Constants.colors[14]),
  //       ),
  //       galleryText: Text(
  //         Txt.frm_gallery,
  //         style: TextStyle(color: Constants.colors[14]),
  //       ));
  //   setState(() {
  //     _image = image;
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
                  final response = await getImage(ImageSource.camera);
                  if (response != null) {
                    _image = response;
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
                  final response = await getImageFromGallery();
                  if (response != null) {
                    _image = response;
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
    _pdfController = PdfController(
      document: PdfDocument.openData(InternetFile.get('https://github.com/rbcprolabs/packages.flutter/raw/fd0c92ac83ee355255acb306251b1adfeb2f2fd6/packages/native_pdf_renderer/example/assets/sample.pdf')),
    );
    observe();
    getToken();
  }

  Future<void> getToken() async {
    token = await TokenProvider().getToken();
    if (null != token) {} else {
      return;
    }
  }

  void observe() {
    profileBloc.userdocuments.listen((event) {
      print("event");
      print(event.response);
      var message = event.response?.status?.statusMessage;
      if (mounted) {
        setState(() {
          _image = null;
        });
      }
      showMessageAndPop(message, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as ScreenArguments;
    type = args.type;
    imageUri = args.imgUrl;
    date.text = args.expiry;
    print("type");
    print(type);
    print(imageUri);
    final FixedExtentScrollController itemController =
    FixedExtentScrollController();
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
        iconTheme: const IconThemeData(
          color: Colors.black,
          //change your color here
        ),
        backgroundColor: HexColor("#ffffff"),
        title: AutoSizeText(
          Txt.upload_docs,
          style: TextStyle(
              fontSize: 17,
              color: Constants.colors[1],
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              funcBottomSheet(context, "Image");
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, dividedBy: 35)),
                child: Column(children: [
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  if (null != imageUri &&
                      imageUri != "" &&
                      null == _image)
                    SizedBox(
                        height: 65.h,
                        width: 100.w,
                        child: imageUri != null
                            ?1==1?PdfView(
                          builders: PdfViewBuilders<DefaultBuilderOptions>(
                            options: const DefaultBuilderOptions(),
                            documentLoaderBuilder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                            pageLoaderBuilder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                            pageBuilder: _pageBuilder,
                          ),
                          controller: _pdfController,
                        )
                    : InteractiveViewer(
                          child:CachedNetworkImage(
                            imageUrl: imageUri,
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

                        )
                            : const SizedBox()),
                  if (null != _image)
                    SizedBox(
                        height: 65.h,
                        width: 100.w,
                        child: _image != null
                            ? InteractiveViewer(
                          child: Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ),
                        )
                            : const SizedBox()),
                  const SizedBox(
                    height: 20,
                  ),
                  if (type != "signature")
                    SizedBox(
                      width: 100.w,
                      height: 5.3.h,
                      child: TextInputFileds(
                          controlr: date,
                          onChange: () {},
                          validator: (date) {
                            if (validDate(date))
                              return null;
                            else
                              return Txt.select_date;
                          },
                          onTapDate: () {
                            selectDate(context, date);
                          },
                          hintText: Txt.expiry_date,
                          keyboadType: TextInputType.none,
                          isPwd: false),
                    ),
                  const SizedBox(
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
                            if (date.text != "" || type == "signature") {
                              profileBloc.uploadUserDoc(token,
                                  File(_image.path), type, date.text);
                            } else {
                              showAlertDialoge(context,
                                  title: Txt.expiry_date,
                                  message: Txt.expiry_date_req);
                            }
                          } else {
                            showAlertDialoge(context,
                                title: Txt.alert,
                                message: Txt.uplod_timesht);
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
                              const SizedBox(width: 10),
                              const Text(Txt.upload_docs),
                            ],
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  const SizedBox(
                    height: 10,
                  ),
                ])),
          ),
          SizedBox(
            width: 100.w,
            height: 70.h,
            child: StreamBuilder(
              stream: profileBloc.visible,
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
    );
  }
  PhotoViewGalleryPageOptions _pageBuilder(
      BuildContext context,
      Future<PdfPageImage> pageImage,
      int index,
      PdfDocument document,
      ) {
    return PhotoViewGalleryPageOptions(
      imageProvider: PdfPageImageProvider(
        pageImage,
        index,
        document.id,
      ),
      minScale: PhotoViewComputedScale.contained * 1,
      maxScale: PhotoViewComputedScale.contained * 2,
      initialScale: PhotoViewComputedScale.contained * 1.0,
      heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
    );
  }
}


