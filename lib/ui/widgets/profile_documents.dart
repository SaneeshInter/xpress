import 'package:flutter/material.dart';
import '../../blocs/profile_update_bloc.dart';
import '../../model/user_get_response.dart';
import '../../ui/user/detail/profile_doc_row.dart';
import '../../ui/user/detail/profile_question_row.dart';

import '../../Constants/strings.dart';
import '../../resources/token_provider.dart';

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

  Future getImage( var type, var imagefile, var expiry) async {
    // Navigator.pushNamed(
    //   context,
    //   '/upload_screen',
    //   arguments: ScreenArguments(type, imagefile, expiry),
    // ).then((value) {
    //   observe();
    //   widget.onRefresh();
    //    getData();
    // });
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


    profileBloc.getProfileQuestions.listen((event) {
      debugPrint("Listen refresh");
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
                // getImage( "profilepic",
                getImage( "signature",
                    widget.items.signatureSrc!, "");
              },
              child: ProfileDocRow(
                label:Txt.signature ,
                asset: "assets/images/icon/check.svg",
                image: signaturePic,
                url: widget.items.signatureSrc!,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage( "phd", widget.items.phdLink!,
                    widget.items.phdExpiry);
              },
              child: ProfileDocRow(
                label:Txt.p_h_d ,
                asset: "assets/images/icon/check.svg",
                image: phpdocument,
                url: widget.items.phdLink!,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage( "qqqi", widget.items.qqqiLink!,
                    widget.items.qqqiExpiry);
              },
              child: ProfileDocRow(
                label: Txt.level,
                asset: "assets/images/icon/check.svg",
                image: qqqidocument,
                url: widget.items.qqqiLink!,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage( "ipcc", widget.items.ipccLink!,
                    widget.items.ipccExpiry);
              },
              child: ProfileDocRow(
                label: Txt.infection,
                asset: "assets/images/icon/check.svg",
                image: ipcccdocument,
                url: widget.items.ipccLink!,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage( "ecs", widget.items.ecsLink!,
                    widget.items.ecsExpiry);
              },
              child: ProfileDocRow(
                label: Txt.employe,
                asset: "assets/images/icon/check.svg",
                image: ecsdocument,
                url: widget.items.ecsLink!,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getImage( "pid", widget.items.pidLink!,
                    widget.items.pidExpiry);
              },
              child: ProfileDocRow(
                label:Txt.pass_id ,
                asset: "assets/images/icon/check.svg",
                image: piddocument,
                url: widget.items.pidLink!,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: ProfileQuestionRow(
                label: Txt.drive + doYouDrive,
                asset: "assets/images/icon/check.svg",
                status: widget.items.doYouDrive!,
                onChanged: (value) {
                  var status = 0;
                  bool isVal = value;
                  if (isVal) {
                    status = 1;
                  }


                  profileBloc.profileQuestions(
                      token, "drive", status.toString());
                },
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: ProfileQuestionRow(
                label: Txt.ireland +
                    permissionToWorkInIreland,
                asset: "assets/images/icon/check.svg",
                status: widget.items.permissionToWorkInIreland!,
                onChanged: (value) {
                  var status = 0;
                  bool isVal = value;
                  if (isVal) {
                    status = 1;
                  }


                  profileBloc.profileQuestions(
                      token, "work_ireland", status.toString());
                },
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: ProfileQuestionRow(
                label:Txt.covid+
                    haveYouGotCovid19Vaccination,
                asset: "assets/images/icon/check.svg",
                status: widget.items.haveYouGotCovid19Vaccination!,
                onChanged: (value) {
                  var status = 0;
                  bool isVal = value;
                  if (isVal) {
                    status = 1;
                  }



                  profileBloc.profileQuestions(
                      token, "covid_vaccine", status.toString());
                },
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: ProfileQuestionRow(
                label:Txt.garda_vetting+
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
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: ProfileQuestionRow(
                label:  Txt.tuberculosis+ tuberculosisVaccination,
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
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: ProfileQuestionRow(
                label:Txt.hepatits + hepatitisBAntibody,
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
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: ProfileQuestionRow(
                label:Txt.id_card + idCardReceived,
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
            const SizedBox(height: 10),
          ],
        ),

        /// Bottom Section
      ],
    );
  }
}
