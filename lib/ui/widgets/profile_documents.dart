import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:xpresshealthdev/blocs/profile_update_bloc.dart';
import 'package:xpresshealthdev/model/user_get_response.dart';
import 'package:xpresshealthdev/ui/user/detail/profile_doc_row.dart';
import 'package:xpresshealthdev/ui/user/detail/profile_question_row.dart';

import '../../main.dart';
import '../../resources/token_provider.dart';
import '../user/home/my_booking_screen.dart';

class ProfileDocumentsCard extends StatefulWidget {
  Items items;
  Function onRefresh;

  ProfileDocumentsCard({Key? key, required this.items, required this.onRefresh})
      : super(key: key);

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

  Future getImage(ImgSource source, var type, var imagefile, var expiry) async {
    Navigator.pushNamed(
      context,
      '/upload_screen',
      arguments: ScreenArguments(type, imagefile, expiry),
    ).then((value) => getData());
  }

  @override
  void initState() {
    super.initState();
    profilePicture = "";
    observe();
    getData();
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

    profileBloc.getProfileQuestions.listen((event) {

      print("Listen refresh");
      widget.onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    var items = widget.items;

    String? permissionToWorkInIreland = "No";
    if (items.permissionToWorkInIreland == 1) {
      permissionToWorkInIreland = "Yes";
    }

    String? doYouDrive = "No";
    if (items.doYouDrive == 1) {
      doYouDrive = "Yes";
    }

    String? haveYouGotCovid19Vaccination = "No";
    if (items.haveYouGotCovid19Vaccination == 1) {
      haveYouGotCovid19Vaccination = "Yes";
    }

    String? doYouConsentGardaVettingToBeCompleted = "No";
    if (items.doYouConsentGardaVettingToBeCompleted == 1) {
      doYouConsentGardaVettingToBeCompleted = "Yes";
    }

    String? tuberculosisVaccination = "No";
    if (items.tuberculosisVaccination == 1) {
      tuberculosisVaccination = "Yes";
    }

    String? hepatitisBAntibody = "No";
    if (items.hepatitisBAntibody == 1) {
      hepatitisBAntibody = "Yes";
    }

    String? idCardReceived = "No";
    if (items.idCardReceived == 1) {
      idCardReceived = "Yes";
    }

    return Column(
      children: [
        /// TOP PART APPOINTMENT
        Column(
          children: [
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage(ImgSource.Both, "signature",
                    widget.items.signatureSrc!, "");
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
                getImage(ImgSource.Both, "phd", widget.items.phdLink!,
                    widget.items.phdExpiry);
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
                getImage(ImgSource.Both, "qqqi", widget.items.qqqiLink!,
                    widget.items.qqqiExpiry);
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
                getImage(ImgSource.Both, "ipcc", widget.items.ipccLink!,
                    widget.items.ipccExpiry);
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
                getImage(ImgSource.Both, "ecs", widget.items.ecsLink!,
                    widget.items.ecsExpiry);
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
                getImage(ImgSource.Both, "pid", widget.items.ecsLink!,
                    widget.items.ecsExpiry);
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
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                child: ProfileQuestionRow(
                  label: "Do you drive : " + doYouDrive,
                  asset: "assets/images/icon/check.svg",
                  status: widget.items.doYouDrive!,
                  onChanged: (value) {
                    var status = 0;
                    bool isVal = value;
                    if (isVal) {
                      status = 1;
                    }

                    setState(() {
                      visibility = true;
                    });
                    profileBloc.profileQuestions(
                        token, "drive", status.toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                child: ProfileQuestionRow(
                  label: "Permission to work in ireland : " +
                      permissionToWorkInIreland,
                  asset: "assets/images/icon/check.svg",
                  status: widget.items.permissionToWorkInIreland!,
                  onChanged: (value) {
                    var status = 0;
                    bool isVal = value;
                    if (isVal) {
                      status = 1;
                    }

                    setState(() {
                      visibility = true;
                    });
                    profileBloc.profileQuestions(
                        token, "work_ireland", status.toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                child: ProfileQuestionRow(
                  label: "Have you got Covid19 vaccination : " +
                      haveYouGotCovid19Vaccination,
                  asset: "assets/images/icon/check.svg",
                  status: widget.items.haveYouGotCovid19Vaccination!,
                  onChanged: (value) {
                    var status = 0;
                    bool isVal = value;
                    if (isVal) {
                      status = 1;
                    }

                    setState(() {
                      visibility = true;
                    });

                    profileBloc.profileQuestions(
                        token, "covid_vaccine", status.toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                child: ProfileQuestionRow(
                  label: "Do you consent garda vetting to be completed: " +
                      doYouConsentGardaVettingToBeCompleted,
                  asset: "assets/images/icon/check.svg",
                  status: widget.items.doYouConsentGardaVettingToBeCompleted!,
                  onChanged: (value) {
                    var status = 0;
                    bool isVal = value;
                    if (isVal) {
                      status = 1;
                    }
                    profileBloc.profileQuestions(
                        token, "garda_vetting", status.toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                child: ProfileQuestionRow(
                  label: "Tuberculosis vaccination: " + tuberculosisVaccination,
                  asset: "assets/images/icon/check.svg",
                  status: widget.items.tuberculosisVaccination!,
                  onChanged: (value) {
                    var status = 0;
                    bool isVal = value;
                    if (isVal) {
                      status = 1;
                    }
                    profileBloc.profileQuestions(
                        token, "tuberculosis", status.toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                child: ProfileQuestionRow(
                  label: "Hepatitis B antibody: " + hepatitisBAntibody,
                  asset: "assets/images/icon/check.svg",
                  status: widget.items.hepatitisBAntibody!,
                  onChanged: (value) {
                    var status = 0;
                    bool isVal = value;
                    if (isVal) {
                      status = 1;
                    }
                    profileBloc.profileQuestions(
                        token, "hepatitis", status.toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                child: ProfileQuestionRow(
                  label: "Id card received: " + idCardReceived,
                  asset: "assets/images/icon/check.svg",
                  status: widget.items.idCardReceived!,
                  onChanged: (value) {
                    var status = 0;
                    bool isVal = value;
                    if (isVal) {
                      status = 1;
                    }
                    profileBloc.profileQuestions(
                        token, "id_card", status.toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),

        /// Bottom Section
      ],
    );
  }
}
