import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:xpresshealthdev/blocs/profile_update_bloc.dart';
import 'package:xpresshealthdev/ui/user/detail/profile_doc_row.dart';

import '../../resources/token_provider.dart';
import '../user/home/my_booking_screen.dart';
import 'package:xpresshealthdev/model/user_get_response.dart';

class ProfileDocumentsCard extends StatefulWidget {
  Items items;

  ProfileDocumentsCard({Key? key, required this.items}) : super(key: key);

  @override
  State<ProfileDocumentsCard> createState() => _ProfileDocumentsCardState();
}

class _ProfileDocumentsCardState extends State<ProfileDocumentsCard> {
  var token;
  var profilepic;
  var signature;
  var phd;
  var qqqi;
  var ipcc;
  var ecs;
  var pid;
  String profilePicture = "";
  String signaturePic = "";
  String phpdocument = "";
  String qqqidocument = "";

  String ipcccdocument = "";
  String ecsdocument = "";
  String piddocument = "";

  @override
  void didUpdateWidget(covariant ProfileDocumentsCard oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }



  Future getImage(ImgSource source, var type) async {
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
          style: TextStyle(color: Colors.green),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(color: Colors.green),
        ));




    if (image != null) {
      if (type == "profilepic") {
        setState(() {
          profilePicture = image.path;
        });
      }

      if (type == "signature") {
        setState(() {
          signaturePic = image.path;
        });
      }
      if (type == "phd") {
        setState(() {
          phpdocument = image.path;
        });
      }

      if (type == "qqqi") {
        setState(() {
          qqqidocument = image.path;
        });
      }

      if (type == "ipcc") {
        setState(() {
          ipcccdocument = image.path;
        });
      }

      if (type == "ecs") {
        setState(() {
          ecsdocument = image.path;
        });
      }

      if (type == "pid") {
        setState(() {
          piddocument = image.path;
        });
      }
      profileBloc.uploadUserDoc(token, File(image.path), type, "25/22/2022");
    }
  }

  @override
  void initState() {
    profilePicture = "";

    getData();
    observe();
    super.initState();
  }

  Future getData() async {
    token = await TokenProvider().getToken();
  }

  void observe() {
    profileBloc.userdocuments.listen((event) {
      setState(() {
        visibility = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// TOP PART APPOINTMENT
        Column(
          children: [
            const SizedBox(height: 10),
            // InkWell(
            //   onTap: () {
            //     getImage(ImgSource.Both, "profilepic");
            //   },
            //   child: Container(
            //     child: ProfileDocRow(
            //       label: "Profile Picture   ",
            //       asset: "assets/images/icon/check.svg",
            //       image: profilePicture,
            //       url: widget.items.profileSrc!,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "signature");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "Signature",
                  asset: "assets/images/icon/check.svg",
                  image: signaturePic,
                  url: widget.items.signatureSrc!,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "phd");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "People handling document",
                  asset: "assets/images/icon/check.svg",
                  image: phpdocument,
                  url: widget.items.phdLink!,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "qqqi");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "Level certification",
                  asset: "assets/images/icon/check.svg",
                  image: qqqidocument,
                  url: widget.items.qqqiLink!,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(
                    ImgSource.Both, "ipcc");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "Infection prevention control certificate",
                  asset: "assets/images/icon/check.svg",
                  image: ipcccdocument,
                  url: widget.items.ipccLink!,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "ecs");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "Employment contract signed",
                  asset: "assets/images/icon/check.svg",
                  image: ecsdocument,
                  url: widget.items.ecsLink!,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "pid");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "Passport Id",
                  asset: "assets/images/icon/check.svg",
                  image: piddocument,
                  url: widget.items.ecsLink!,
                ),
              ),
            ),
          ],
        ),

        /// Bottom Section
      ],
    );
  }
}
