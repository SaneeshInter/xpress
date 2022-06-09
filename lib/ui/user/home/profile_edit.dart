import 'dart:core';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/validator.dart';
import '../../../Constants/strings.dart';
import '../../../blocs/profile_update_bloc.dart';
import '../../../model/country_list.dart';
import '../../../model/gender_list.dart';
import '../../../model/visa_type_list.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
import '../../../utils/utils.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/buttons/login_button.dart';
import '../../widgets/input_text.dart';
import '../../widgets/loading_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  _CreateShiftState createState() => _CreateShiftState();
}

List<GenderList> genderList = [];

class _CreateShiftState extends State<ProfileEditScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController date = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController ppsnumber = TextEditingController();
  TextEditingController bank_iban = TextEditingController();
  TextEditingController bank_bic = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController bank_details = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController home_address = TextEditingController();
  TextEditingController visa_type = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    profileBloc.getDropDownValues();

    listner();
    observerResponse();
  }

  @override
  void dispose() {
    super.dispose();
    profileBloc.dispose();
  }

  Future getData() async {
    profileBloc.token = await TokenProvider().getToken();
    if (null != profileBloc.token) {
      if (await isNetworkAvailable()) {
        profileBloc.getUserInfo();
      } else {
        showInternetNotAvailable();
      }
    }
  }

  Future<void> showInternetNotAvailable() async {
    int response = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );
    if (response == 1) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/icon/arrow.svg',
            width: 5.w,
            height: 4.2.w,
          ),
          onPressed: () {
            pop(context);
          },
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: HexColor("#ffffff"),
        title: AutoSizeText(
          Txt.profile_update,
          style: TextStyle(
              fontSize: 17,
              color: Constants.colors[1],
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      backgroundColor: Constants.colors[9],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Form(
                              key: formKey,
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.22,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.22,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius
                                                                .circular(MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.22),
                                                            child: AspectRatio(
                                                              aspectRatio:
                                                                  1 / 1,
                                                              child: Stack(
                                                                children: [
                                                                  if (profileBloc
                                                                              .profileImage ==
                                                                          "" ||
                                                                      null ==
                                                                          profileBloc
                                                                              .profileImage)
                                                                    Image.asset(
                                                                      'assets/images/icon/man_ava.png',
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  if (profileBloc
                                                                              .profileImage !=
                                                                          "" &&
                                                                      null !=
                                                                          profileBloc
                                                                              .profileImage)
                                                                    Image
                                                                        .network(
                                                                      profileBloc
                                                                          .profileImage,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.22,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.22,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  65, 70, 0, 0),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                  child:
                                                                      AspectRatio(
                                                                    aspectRatio:
                                                                        1 / 1,
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/images/icon/edittool.png'),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: TextInputFileds(
                                                          controlr: first_name,
                                                          onTapDate: () {},
                                                          onChange: () {},
                                                          validator: (name) {
                                                            if (validfirstname(
                                                                name))
                                                              return null;
                                                            else {
                                                              return Txt
                                                                  .enter_fst_name;
                                                            }
                                                          },
                                                          hintText:
                                                              Txt.first_name,
                                                          keyboadType:
                                                              TextInputType
                                                                  .text,
                                                          isPwd: false)),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: TextInputFileds(
                                                      controlr: last_name,
                                                      onChange: () {},
                                                      validator: (name) {
                                                        if (validlastname(name))
                                                          return null;
                                                        else {
                                                          return Txt
                                                              .enter_lst_name;
                                                        }
                                                      },
                                                      hintText: Txt.last_name,
                                                      keyboadType:
                                                          TextInputType.text,
                                                      isPwd: false,
                                                      onTapDate: () {},
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: 50.w,
                                                      child: StreamBuilder(
                                                        stream: profileBloc
                                                            .countryStream,
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                    List<
                                                                        CountryList>>
                                                                snapshot) {
                                                          if (null ==
                                                                  snapshot
                                                                      .data ||
                                                              snapshot.data
                                                                      ?.length ==
                                                                  0) {
                                                            return Container();
                                                          }

                                                          return DropdownButtonFormField(
                                                            value: profileBloc
                                                                .nationalityId,
                                                            decoration:
                                                                InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(5)),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Constants
                                                                            .colors[28],
                                                                      ),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                5.0)),
                                                                        borderSide: BorderSide(
                                                                            color: Constants.colors[
                                                                                28],
                                                                            width:
                                                                                1)),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            3.0),
                                                                    labelText: Txt
                                                                        .nationality,
                                                                    labelStyle: TextStyle(
                                                                        fontSize:
                                                                            10.sp)),
                                                            items: snapshot.data
                                                                ?.map((item) {
                                                              return DropdownMenuItem(
                                                                child: new Text(
                                                                  item.countryName!,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          8.sp,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                                value:
                                                                    item.rowId,
                                                              );
                                                            }).toList(),
                                                            onChanged: (Object?
                                                                value) {
                                                              if (value
                                                                  is int?) {
                                                                profileBloc
                                                                        .nationalityId =
                                                                    value!;
                                                              }
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          child: StreamBuilder(
                                                            stream: profileBloc
                                                                .genderStream,
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        List<
                                                                            GenderList>>
                                                                    snapshot) {
                                                              if (null ==
                                                                      snapshot
                                                                          .data ||
                                                                  snapshot.data
                                                                          ?.length ==
                                                                      0) {
                                                                return Container();
                                                              }

                                                              return DropdownButtonFormField(
                                                                value: profileBloc
                                                                    .genderId,
                                                                decoration:
                                                                    InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5)),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Constants.colors[28]),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              5.0)),
                                                                      borderSide: BorderSide(
                                                                          color: Constants.colors[
                                                                              28],
                                                                          width:
                                                                              1)),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3.0),
                                                                  labelText: Txt
                                                                      .gender,
                                                                ),
                                                                items: snapshot
                                                                    .data
                                                                    ?.map(
                                                                        (item) {
                                                                  return DropdownMenuItem(
                                                                    child:
                                                                        new Text(
                                                                      item.gender!,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize: 8
                                                                              .sp,
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    value: item
                                                                        .rowId,
                                                                  );
                                                                }).toList(),
                                                                onChanged:
                                                                    (Object?
                                                                        value) {
                                                                  if (value
                                                                      is int?) {
                                                                    profileBloc
                                                                            .genderId =
                                                                        value!;
                                                                  }
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: 50.w,
                                                          child: StreamBuilder(
                                                            stream: profileBloc
                                                                .visatypeStream,
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        List<
                                                                            VisaTypeList>>
                                                                    snapshot) {
                                                              if (null ==
                                                                      snapshot
                                                                          .data ||
                                                                  snapshot.data
                                                                          ?.length ==
                                                                      0) {
                                                                return Container();
                                                              }

                                                              return DropdownButtonFormField(
                                                                value: profileBloc
                                                                    .visatypeId,
                                                                decoration:
                                                                    InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5)),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              8.0)),
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              1)),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3.0),
                                                                  labelText: Txt
                                                                      .visatype,
                                                                ),
                                                                items: snapshot
                                                                    .data
                                                                    ?.map(
                                                                        (item) {
                                                                  return DropdownMenuItem(
                                                                    child:
                                                                        new Text(
                                                                      item.type!,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize: 8
                                                                              .sp,
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    value: item
                                                                        .rowId,
                                                                  );
                                                                }).toList(),
                                                                onChanged:
                                                                    (Object?
                                                                        value) {
                                                                  if (value
                                                                      is VisaTypeList) {
                                                                    profileBloc
                                                                            .visatypeId =
                                                                        value
                                                                            .rowId!;
                                                                  }
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              TextInputFileds(
                                                  controlr: phonenumber,
                                                  onTapDate: () {},
                                                  onChange: () {},
                                                  validator: (number) {
                                                    if (validphonenumber(
                                                        number))
                                                      return null;
                                                    else
                                                      return Txt.enter_phn_no;
                                                  },
                                                  hintText: Txt.phone_number,
                                                  keyboadType:
                                                      TextInputType.number,
                                                  isPwd: false),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              TextInputFileds(
                                                  controlr: date,
                                                  onChange: () {},
                                                  validator: (dob) {
                                                    if (validDate(dob))
                                                      return null;
                                                    else
                                                      return Txt.select_dob;
                                                  },
                                                  onTapDate: () {
                                                    _selectDate(context, date);
                                                    print("values");
                                                  },
                                                  hintText: Txt.dob,
                                                  keyboadType:
                                                      TextInputType.none,
                                                  isPwd: false),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child: TextInputFileds(
                                                        controlr: home_address,
                                                        onTapDate: () {},
                                                        onChange: () {},
                                                        validator: (address) {
                                                          if (validadress(
                                                              address))
                                                            return null;
                                                          else
                                                            return Txt
                                                                .enter_address;
                                                        },
                                                        hintText: Txt.address,
                                                        keyboadType:
                                                            TextInputType
                                                                .visiblePassword,
                                                        isPwd: false),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child: TextInputFileds(
                                                        onChange: () {},
                                                        controlr: email,
                                                        onTapDate: () {},
                                                        validator: (number) {
                                                          if (validEmail(
                                                              number))
                                                            return null;
                                                          else
                                                            return Txt
                                                                .enter_mail;
                                                        },
                                                        hintText: Txt.email,
                                                        keyboadType:
                                                            TextInputType.text,
                                                        isPwd: false),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child: TextInputFileds(
                                                        controlr: ppsnumber,
                                                        onChange: () {},
                                                        validator:
                                                            (permission) {
                                                          if (validppsnumber(
                                                              permission))
                                                            return null;
                                                          else
                                                            return Txt
                                                                .enter_pps_no;
                                                        },
                                                        onTapDate: () {},
                                                        hintText:
                                                            Txt.pps_number,
                                                        keyboadType:
                                                            TextInputType.text,
                                                        isPwd: false),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child: TextInputFileds(
                                                        onChange: () {},
                                                        controlr: bank_iban,
                                                        validator: (number) {
                                                          if (validbankiban(
                                                              number))
                                                            return null;
                                                          else
                                                            return Txt
                                                                .enter_bank_iban;
                                                        },
                                                        onTapDate: () {},
                                                        hintText: Txt.bankiban,
                                                        keyboadType:
                                                            TextInputType.text,
                                                        isPwd: false),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child: TextInputFileds(
                                                        controlr: bank_bic,
                                                        onChange: () {},
                                                        validator: (number) {
                                                          if (validbankbic(
                                                              number))
                                                            return null;
                                                          else
                                                            return Txt
                                                                .enter_bic;
                                                        },
                                                        onTapDate: () {},
                                                        hintText: Txt.bankbic,
                                                        keyboadType:
                                                            TextInputType.text,
                                                        isPwd: false),
                                                  ),
                                                ],
                                              ),
                                              signUpBtn(),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: StreamBuilder(
              stream: profileBloc.visible,
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
          )
        ],
      ),
    );
  }

  Widget signUpBtn() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Stack(
              children: [
                LoginButton(
                    onPressed: () async {
                      var validate = formKey.currentState?.validate();
                      if (null != validate) {
                        if (validate) {
                          if (null != profileBloc.token) {
                            if (mounted) {
                              print("after validation");
                              profileBloc.ProfileUser(
                                  profileBloc.token,
                                  first_name.text,
                                  last_name.text,
                                  date.text,
                                  profileBloc.genderId.toString(),
                                  profileBloc.nationalityId.toString(),
                                  home_address.text,
                                  "NO",
                                  profileBloc.visatypeId.toString(),
                                  phonenumber.text,
                                  email.text,
                                  ppsnumber.text,
                                  bank_iban.text,
                                  bank_bic.text);
                            }
                          }
                        }
                        // use the information provided
                      }
                    },
                    label: Txt.submit),
              ],
            ),
          )),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  void listner() {
    profileBloc.getProfileStream.listen((event) {
      print("Profile Stream");
      if (null != event.response?.data?.items?[0]) {
        var item = event.response?.data?.items?[0];
        if (null != item) {
          if (item.genderId != 0) {
            setState(() {
              profileBloc.genderId = item.genderId!;
            });
          }
          if (null != item.visaTypeId && item.visaTypeId != "") {
            setState(() {
              profileBloc.visatypeId = int.parse(item.visaTypeId!);
            });
          }

          if (item.nationalityId != 0) {
            setState(() {
              profileBloc.nationalityId = item.nationalityId!;
            });
          }
          profileBloc.profileImage = item.profileSrc!;
          first_name.text = item.firstName!;
          last_name.text = item.lastName!;
          date.text = item.dob!;
          email.text = item.email!;
          phonenumber.text = item.phoneNumber!;
          ppsnumber.text = item.ppsNumber!;
          bank_iban.text = item.bankIban!;
          bank_bic.text = item.bankBic!;
          ppsnumber.text = item.ppsNumber!;
          home_address.text = item.homeAddress!;
        }
      }
    });
  }

  void observerResponse() {
    profileBloc.profileStream.listen((event) {
      var message = event.response?.status?.statusMessage.toString();

      if (event.response?.status?.statusCode == 200) {
        showMessageAndPop(message, context);

      } else {
        showAlertDialoge(context, title: Txt.invalid, message: message!);
      }
    });
  }
}

_selectDate(BuildContext context, TextEditingController dateController) async {
  final DateTime? newDate = await showDatePicker(
    context: context,
    initialDatePickerMode: DatePickerMode.day,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2025),
    helpText: Txt.select_date,
    fieldHintText: "dd-MM-yyyy",
  );
  if (newDate != null) {
    print(newDate);
    var dates = DateFormat('dd-MM-yyyy').format(newDate);
    dateController.text = dates;
  }
}
