import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:xpresshealthdev/blocs/profile_update_bloc.dart';
import 'package:xpresshealthdev/ui/user/detail/profile_doc_row.dart';

import '../../resources/token_provider.dart';
import '../user/home/my_booking_screen.dart';

class ProfileDocumentsCard extends StatefulWidget {
  const ProfileDocumentsCard({
    Key? key,
  }) : super(key: key);

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
      if (type == "people_handling_document") {
        setState(() {
          phpdocument = image.path;
        });
      }
      if (type == "qqqi_level5_certification") {
        setState(() {
          qqqidocument = image.path;
        });
      }

      if (type == "infection_prevention_control_certificate") {
        setState(() {
          ipcccdocument = image.path;
        });
      }
      if (type == "employment_contract_signed") {
        setState(() {
          ecsdocument = image.path;
        });
      }
      if (type == "passport_id_card") {
        setState(() {
          piddocument = image.path;
        });
      }
      profileBloc.fetchUserDocuments(
          token, File(image.path), type, "25/22/2022");
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
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "profilepic");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "Profile Picture   ",
                  asset: "assets/images/icon/check.svg",
                  image: profilePicture,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "signature");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "Signature",
                  asset: "assets/images/icon/check.svg",
                  image: signaturePic,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "people_handling_document");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "people_handling_document",
                  asset: "assets/images/icon/check.svg",
                  image: phpdocument,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "qqqi_level5_certification");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "qqqi_level5_certification",
                  asset: "assets/images/icon/check.svg",
                  image: qqqidocument,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "infection_prevention_control_certificate");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "infection_prevention_control_certificate",
                  asset: "assets/images/icon/check.svg",
                  image: ipcccdocument,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "employment_contract_signed");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "employment_contract_signed",
                  asset: "assets/images/icon/check.svg",
                  image: ecsdocument,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "passport_id_card");
              },
              child: Container(
                child: ProfileDocRow(
                  label: "passport_id_card",
                  asset: "assets/images/icon/check.svg",
                  image: piddocument,
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
