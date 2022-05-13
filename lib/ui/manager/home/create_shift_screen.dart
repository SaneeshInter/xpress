import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/blocs/createshift_manager_bloc.dart';
import 'package:xpresshealthdev/dbmodel/allowance_category_model.dart';
import 'package:xpresshealthdev/model/allowance_model.dart';
import 'package:xpresshealthdev/model/schedule_categegory_list.dart';
import 'package:xpresshealthdev/model/schedule_hospital_list.dart';
import 'package:xpresshealthdev/model/shift_type_list.dart';
import 'package:xpresshealthdev/model/viewbooking_response.dart';
import 'package:xpresshealthdev/utils/validator.dart';

import '../../../Constants/sharedPrefKeys.dart';
import '../../../Constants/strings.dart';
import '../../../Constants/toast.dart';
import '../../../blocs/shift_dropdown.dart';
import '../../../dbmodel/allowance_mode.dart';
import '../../../model/user_type_list.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../widgets/allowance_bottom_sheet.dart';
import '../../widgets/buttons/login_button.dart';
import '../../widgets/input_text.dart';
import '../../widgets/input_text_description.dart';
import '../../widgets/loading_widget.dart';

class CreateShiftScreen extends StatefulWidget {
  final Items? shiftItem;

  const CreateShiftScreen({Key? key, this.shiftItem}) : super(key: key);

  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends State<CreateShiftScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var row_id = -1;
  var typeId = 1;
  var categoryId = 1;
  var usertypeId = 1;
  var shiftType = 1;
  var hospitalId = 1;
  var allowanceCategroyId = 1;
  var allowanceId = 1;
  var allowanceCategroy = "Food Item";
  var allowance = "Break Fast";
  var shiftItem;
  ToastMsg toastMsg = ToastMsg();
  bool isLoading = false;
  TextEditingController location = new TextEditingController();
  TextEditingController jobtitle = new TextEditingController();
  TextEditingController jobDescri = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController dateFrom = new TextEditingController();
  TextEditingController dateTo = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController allowanceprice = new TextEditingController();

  TextEditingController job_title = new TextEditingController();
  TextEditingController resourceType = new TextEditingController();
  TextEditingController type = new TextEditingController();
  TextEditingController user_type = new TextEditingController();
  TextEditingController category = new TextEditingController();
  TextEditingController hospital = new TextEditingController();
  TextEditingController assigned_to = new TextEditingController();
  TextEditingController shift = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController controller = TextEditingController();
  bool visible = false;
  var buttonText = "Create Shift";
  var token;



  Future getData(String date, String shifttype) async {
    managerBloc.getUserListByDate(token!, date, shifttype);
  }




  Future getToken() async {
    token = await TokenProvider().getToken();
  }

  @override
  void initState() {
    getToken();
    observerResponse();
    dropdownBloc.addItem();
    managerBloc.getDropDownValues();
    row_id = -1;
    if (widget.shiftItem != null) {
      var item = widget.shiftItem;
      print("item.category");
      print(item?.category);
      if (item != null) {
        jobtitle.text = item.jobTitle!;
        row_id = item.rowId!;
        date.text = item.date!;
        dateTo.text = item.timeTo!;
        dateFrom.text = item.timeFrom!;
        jobDescri.text = item.jobDetails!;
        category.text = item.category!;
        buttonText = "Edit Shift";
        if (item.type == "Premium") {
          setState(() {
            typeId = 2;
          });
        } else {
          setState(() {
            typeId = 1;
          });
        }
        if (item.categoryId != 0) {
          setState(() {
            categoryId = item.categoryId!;
          });
        }
        if (item.userTypeId != 0) {
          setState(() {
            usertypeId = item.userTypeId!;
          });
        }
        if (item.hospitalId != 0) {
          setState(() {
            hospitalId = item.hospitalId!;
          });
        }
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    managerBloc.dispose();
    dropdownBloc.dispose();
;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.colors[9],
      body: SingleChildScrollView(
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
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18, right: 18),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              AutoSizeText(
                                                buttonText,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "SFProMedium",
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: 50.w,
                                                          child: StreamBuilder(
                                                            stream: managerBloc
                                                                .typeStream,
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        List<
                                                                            ShiftTypeList>>
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
                                                                value: typeId,
                                                                decoration:
                                                                    InputDecoration(
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5)),
                                                                          borderSide:
                                                                              BorderSide(color: Colors.grey),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8.0)),
                                                                            borderSide: BorderSide(
                                                                                color: Colors
                                                                                    .grey,
                                                                                width:
                                                                                    1)),
                                                                        contentPadding:
                                                                            EdgeInsets.all(
                                                                                3.0),
                                                                        labelText:
                                                                            "Type",
                                                                        labelStyle:
                                                                            TextStyle(fontSize: 10.sp)),
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
                                                                          fontSize: 10
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
                                                                      is ShiftTypeList) {
                                                                    print(
                                                                        "value");
                                                                    print(value
                                                                        .type);
                                                                    print(value
                                                                        .rowId);

                                                                    typeId = value
                                                                        .rowId!;
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
                                                            stream: managerBloc
                                                                .categoryStream,
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        List<
                                                                            ScheduleCategoryList>>
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
                                                                value:
                                                                    categoryId,
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
                                                                  labelStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              10.sp),
                                                                  labelText:
                                                                      "Category",
                                                                ),
                                                                items: snapshot
                                                                    .data
                                                                    ?.map(
                                                                        (item) {
                                                                  return DropdownMenuItem(
                                                                    child:
                                                                        new Text(
                                                                      item.category!,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize: 10
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
                                                                      is ScheduleCategoryList) {
                                                                    categoryId =
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
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: 50.w,
                                                          child: StreamBuilder(
                                                            stream: managerBloc
                                                                .usertypeStream,
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        List<
                                                                            UserTypeList>>
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
                                                                decoration:
                                                                    InputDecoration(
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5.0)),
                                                                          borderSide:
                                                                              BorderSide(color: Colors.grey),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8.0)),
                                                                            borderSide: BorderSide(
                                                                                color: Colors
                                                                                    .grey,
                                                                                width:
                                                                                    1)),
                                                                        contentPadding:
                                                                            EdgeInsets.all(
                                                                                3.0),
                                                                        labelText:
                                                                            "User Type",
                                                                        labelStyle:
                                                                            TextStyle(fontSize: 10.sp)),
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
                                                                          fontSize: 10
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
                                                                      is UserTypeList) {
                                                                    usertypeId =
                                                                        value
                                                                            .rowId!;
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
                                                            stream: managerBloc
                                                                .hospitalStream,
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        List<
                                                                            HospitalList>>
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
                                                                value:
                                                                    hospitalId,
                                                                decoration:
                                                                    InputDecoration(
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5)),
                                                                          borderSide:
                                                                              BorderSide(color: Colors.grey),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8.0)),
                                                                            borderSide: BorderSide(
                                                                                color: Colors
                                                                                    .grey,
                                                                                width:
                                                                                    1)),
                                                                        contentPadding:
                                                                            EdgeInsets.all(
                                                                                3.0),
                                                                        labelText:
                                                                            "Hospital",
                                                                        labelStyle:
                                                                            TextStyle(fontSize: 10.sp)),
                                                                items: snapshot
                                                                    .data
                                                                    ?.map(
                                                                        (item) {
                                                                  return DropdownMenuItem(
                                                                    child:
                                                                        new Text(
                                                                      item.name!,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize: 10
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
                                                                      is HospitalList) {
                                                                    hospitalId =
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
                                              Column(
                                                children: [
                                                  Container(
                                                    child: TextInputFileds(
                                                        controlr: jobtitle,
                                                        validator: (jobtitle) {
                                                          if (validJob(
                                                              jobtitle))
                                                            return null;
                                                          else
                                                            return "enter job title";
                                                        },
                                                        hintText: Txt.jobtitle,
                                                        keyboadType:
                                                            TextInputType.text,
                                                        isPwd: false,
                                                        onTapDate: () {}),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: 50.w,
                                                          child: StreamBuilder(
                                                            stream: managerBloc
                                                                .shifttypeStream,
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        List<
                                                                            ShiftTypeList>>
                                                                    snapshot) {
                                                              print(
                                                                  "snapshot.data?.length");
                                                              print(snapshot
                                                                  .data
                                                                  ?.length);
                                                              if (null ==
                                                                      snapshot
                                                                          .data ||
                                                                  snapshot.data
                                                                          ?.length ==
                                                                      0) {
                                                                return Container();
                                                              }

                                                              return DropdownButtonFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5.0)),
                                                                          borderSide:
                                                                              BorderSide(color: Colors.grey),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8.0)),
                                                                            borderSide: BorderSide(
                                                                                color: Colors
                                                                                    .grey,
                                                                                width:
                                                                                    1)),
                                                                        contentPadding:
                                                                            EdgeInsets.all(
                                                                                3.0),
                                                                        labelText:
                                                                            "Shift Type",
                                                                        labelStyle:
                                                                            TextStyle(fontSize: 10.sp)),
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
                                                                          fontSize: 10
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
                                                                      is UserTypeList) {
                                                                    shiftType =
                                                                        value
                                                                            .rowId!;
                                                                    print("PRINT THE RESPONSES");
                                                                   getData(date.text , shiftType.toString());
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
                                                          height: 5.3.h,
                                                          child:
                                                              TextInputFileds(
                                                                  controlr:
                                                                      date,
                                                                  validator:
                                                                      (date) {
                                                                    if (validDate(
                                                                        date))
                                                                      return null;
                                                                    else
                                                                      return "select date";
                                                                  },
                                                                  onTapDate:
                                                                      () {
                                                                    selectDate(
                                                                        context,
                                                                        date);
                                                                    var dates =
                                                                        date.text;
                                                                    if (token !=
                                                                            null &&
                                                                        dates !=
                                                                            "") {
                                                                      var shifttype =
                                                                          shiftType;
                                                                      managerBloc.getUserListByDate(
                                                                          token,
                                                                          dates,
                                                                          shifttype
                                                                              .toString());
                                                                    }
                                                                  },
                                                                  hintText:
                                                                      Txt.date,
                                                                  keyboadType:
                                                                      TextInputType
                                                                          .none,
                                                                  isPwd: false),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child: TextInputFileds(
                                                        controlr: price,
                                                        validator: (date) {
                                                          if (validDate(date))
                                                            return null;
                                                          else
                                                            return "Enter Price";
                                                        },
                                                        onTapDate: () {},
                                                        hintText: "Price",
                                                        keyboadType:
                                                            TextInputType
                                                                .number,
                                                        isPwd: false),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: 100.w,
                                                          child: StreamBuilder(
                                                            stream: managerBloc
                                                                .usertypeStream,
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        List<
                                                                            UserTypeList>>
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
                                                                decoration:
                                                                    InputDecoration(
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5.0)),
                                                                          borderSide:
                                                                              BorderSide(color: Colors.grey),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8.0)),
                                                                            borderSide: BorderSide(
                                                                                color: Colors
                                                                                    .grey,
                                                                                width:
                                                                                    1)),
                                                                        contentPadding:
                                                                            EdgeInsets.all(
                                                                                3.0),
                                                                        labelText:
                                                                            "Assigned To",
                                                                        labelStyle:
                                                                            TextStyle(fontSize: 10.sp)),
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
                                                                          fontSize: 10
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
                                                                      is UserTypeList) {
                                                                    usertypeId =
                                                                        value
                                                                            .rowId!;
                                                                    print("PRINT THE RESPONSES");
                                                                    getData(date.text , shiftType.toString());
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
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 2),
                                                          child: Container(
                                                            child:
                                                                TextInputFileds(
                                                                    controlr:
                                                                        dateFrom,
                                                                    validator:
                                                                        (dateTo) {
                                                                      if (validDate(
                                                                          dateTo))
                                                                        return null;
                                                                      else
                                                                        return "select time";
                                                                    },
                                                                    onTapDate:
                                                                        () {
                                                                      selectTime(
                                                                          context,
                                                                          dateFrom);
                                                                    },
                                                                    hintText: Txt
                                                                        .timeFrom,
                                                                    keyboadType:
                                                                        TextInputType
                                                                            .none,
                                                                    isPwd:
                                                                        false),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: TextInputFileds(
                                                            controlr: dateTo,
                                                            validator:
                                                                (dateTo) {
                                                              if (validDate(
                                                                  dateTo))
                                                                return null;
                                                              else
                                                                return "select time";
                                                            },
                                                            onTapDate: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              selectTime(
                                                                  context,
                                                                  dateTo);
                                                            },
                                                            hintText:
                                                                Txt.timeTo,
                                                            keyboadType:
                                                                TextInputType
                                                                    .none,
                                                            isPwd: false),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child:
                                                        TextInputFiledDescription(
                                                            controlr: jobDescri,
                                                            onTapDate: () {},
                                                            validator:
                                                                (jobDescri) {
                                                              if (validDescription(
                                                                  jobDescri))
                                                                return null;
                                                              else
                                                                return "enter job decscription";
                                                            },
                                                            hintText:
                                                                Txt.jobDescri,
                                                            keyboadType:
                                                                TextInputType
                                                                    .visiblePassword,
                                                            isPwd: false),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      'Allowances',
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontFamily:
                                                            "SFProMedium",
                                                      ),
                                                    ),
                                                  ),
                                                  // RaisedButton(
                                                  //   onPressed: () {
                                                  //     showModalBottomSheet(
                                                  //         context: context,
                                                  //         builder: (context) {
                                                  //           return AllowanceBottomSheet(
                                                  //             onSumbmit: () {},
                                                  //             onTapView: () {},
                                                  //             value: 1,
                                                  //           );
                                                  //         });
                                                  //   },
                                                  //   padding: EdgeInsets.only(
                                                  //       left: 10,
                                                  //       right: 10,
                                                  //       top: 5,
                                                  //       bottom: 5),
                                                  //   color: Colors.blueAccent,
                                                  //   child: Text(
                                                  //     'Add Allowances',
                                                  //     style: TextStyle(fontSize: 10.sp,
                                                  //         color: Colors.white,
                                                  //         fontWeight:
                                                  //             FontWeight.w500,
                                                  //         letterSpacing: 0.6),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              StreamBuilder<List<Allowances>>(
                                                  stream: managerBloc
                                                      .allowancesList,
                                                  builder: (context, snapshot) {
                                                    return buildAllowanceList(
                                                        snapshot);
                                                  }),
                                              createShiftButton(),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        ),
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
                Center(
                  child: Visibility(
                    visible: visible,
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      child: const Center(
                        child: LoadingWidget(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAllowanceList(AsyncSnapshot<List<Allowances>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data?.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var items = snapshot.data?[index];

          String? allowace = items?.allowance.toString();
          String? category = items?.category.toString();
          String? amount = items?.amount.toString();
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      allowace!,
                      style: TextStyle(
                          color: Constants.colors[1],
                          fontSize: 14,
                          fontFamily: "SFProMedium",
                          fontWeight: FontWeight.w500),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      category!,
                      style: TextStyle(
                          color: Constants.colors[1],
                          fontSize: 14,
                          fontFamily: "SFProMedium",
                          fontWeight: FontWeight.w500),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      amount!,
                      style: TextStyle(
                          color: Constants.colors[1],
                          fontSize: 14,
                          fontFamily: "SFProMedium",
                          fontWeight: FontWeight.w500),
                    )),
                GestureDetector(
                  onTap: ()
                  {
                    managerBloc.deleteAllowance(index);
                  },
                  child: SvgPicture.asset(
                    'assets/images/icon/delete.svg',
                    fit: BoxFit.contain,
                    height: 20,
                    width: 30,
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Widget createShiftButton() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Visibility(
            // visible: !visible,
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
                            setState(() {
                              visible = true;
                            });

                            final prefs = await SharedPreferences.getInstance();
                            var auth_tokn =
                                prefs.getString(SharedPrefKey.AUTH_TOKEN);
                            if (null != auth_tokn) {
                              managerBloc.createShiftManager(
                                  auth_tokn,
                                  row_id,
                                  typeId,
                                  categoryId,
                                  usertypeId,
                                  jobtitle.text,
                                  hospitalId,
                                  date.text,
                                  dateFrom.text,
                                  dateTo.text,
                                  jobDescri.text,
                                  price.text,
                                  shift.text);
                            } else {
                              print("TOKEN NULL");
                            }

                          }
                        }
                        // showFeactureAlert(context, date: "");
                      },
                      label: buttonText)
                ],
              ),
            )),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  void observerResponse() {
    managerBloc.getmanagerStream.listen((event) {
      print(event.response?.status?.statusMessage.toString());
      print(event.response?.status?.statusCode);
      var message = event.response?.status?.statusMessage.toString();
      setState(() {
        visible = false;
      });
      if (event.response?.status?.statusCode == 200) {
        if (row_id == -1) {
          showAlertDialoge(context, title: "Success", message: message!);
          jobtitle.text = "";
          hospital.text = "";
          date.text = "";
          date.text = "";
          dateTo.text = "";
          dateFrom.text = "";
          jobDescri.text = "";
          price.text = "";
          shift.text = "";
        } else {
          // showAlertDialoge(context, title: "Success", message: message!);
          Navigator.pop(context);
        }
      } else {
        showAlertDialoge(context, title: "Failed", message: message!);
      }
    });
  }
}
