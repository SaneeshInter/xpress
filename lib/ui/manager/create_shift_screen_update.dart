import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/blocs/createshift_manager_bloc.dart';
import 'package:xpresshealthdev/model/allowance_model.dart';
import 'package:xpresshealthdev/model/schedule_categegory_list.dart';
import 'package:xpresshealthdev/model/schedule_hospital_list.dart';
import 'package:xpresshealthdev/model/shift_type_list.dart';
import 'package:xpresshealthdev/utils/validator.dart';

import '../../../Constants/sharedPrefKeys.dart';
import '../../../Constants/strings.dart';
import '../../../Constants/toast.dart';
import '../../../blocs/shift_dropdown.dart';
import '../../../model/user_type_list.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../model/common/manager_shift.dart';
import '../../model/manager_unit_name.dart';
import '../../model/user_shifttiming_list.dart';
import '../widgets/allowance_bottom_sheet.dart';
import '../widgets/buttons/login_button.dart';
import '../widgets/input_text.dart';
import '../widgets/input_text_description.dart';
import '../widgets/loading_widget.dart';

class CreateShiftScreenUpdate extends StatefulWidget {
  final Items? shiftItem;

  const CreateShiftScreenUpdate({Key? key, this.shiftItem}) : super(key: key);

  @override
  _CreateShiftStateUpdate createState() => _CreateShiftStateUpdate();
}

class _CreateShiftStateUpdate extends State<CreateShiftScreenUpdate> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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

  Future getData(String date, String shifttype) async {
    managerBloc.getUserListByDate(managerBloc.token, date, shifttype);
  }

  Future getToken() async {
    managerBloc.token = await TokenProvider().getToken();
    dropdownBloc.addItem();
    managerBloc.getDropDownValues();
    if (widget.shiftItem != null && null != managerBloc.token) {
      var item = widget.shiftItem;
      WidgetsBinding.instance.addPostFrameCallback((_) => updateAllowances(context, item!));
    } else if (null != managerBloc.token) {
      managerBloc.getManagerUnitName(managerBloc.token, managerBloc.hospitalId.toString());
    }
  }

  @override
  void didUpdateWidget(covariant CreateShiftScreenUpdate oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    observerResponse();
    getToken();
    managerBloc.row_id = -1;
    managerBloc.isShiftTypeChanged = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.colors[9],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Align(
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
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 18, right: 18),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          AutoSizeText(
                                            managerBloc.buttonText,
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
                                                        stream: managerBloc.typeStream,
                                                        builder: (context, AsyncSnapshot<List<ShiftTypeList>> snapshot) {
                                                          if (null == snapshot.data || snapshot.data?.length == 0) {
                                                            return Container();
                                                          }
                                                          return DropdownButtonFormField(
                                                            value: managerBloc.typeId,
                                                            decoration: buildInputDecoration(Txt.type),
                                                            items: snapshot.data?.map((item) {
                                                              return DropdownMenuItem(
                                                                child: new Text(
                                                                  item.type!,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10.sp,
                                                                    decoration: TextDecoration.none,
                                                                    color: Constants.colors[29],
                                                                  ),
                                                                ),
                                                                value: item.rowId,
                                                              );
                                                            }).toList(),
                                                            onChanged: (Object? value) {
                                                              managerBloc.typeId = value as int;
                                                              if (value == 1) {
                                                                setState(() {
                                                                  managerBloc.isPricevisible = true;
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  managerBloc.isPricevisible = false;
                                                                });
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
                                                        stream: managerBloc.categoryStream,
                                                        builder:
                                                            (context, AsyncSnapshot<List<ScheduleCategoryList>> snapshot) {
                                                          if (null == snapshot.data || snapshot.data?.length == 0) {
                                                            return Container();
                                                          }
                                                          return DropdownButtonFormField(
                                                            value: managerBloc.categoryId,
                                                            decoration: buildInputDecoration(Txt.category),
                                                            items: snapshot.data?.map((item) {
                                                              return DropdownMenuItem(
                                                                child: new Text(
                                                                  item.category!,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10.sp,
                                                                    decoration: TextDecoration.none,
                                                                    color: Constants.colors[29],
                                                                  ),
                                                                ),
                                                                value: item.rowId,
                                                              );
                                                            }).toList(),
                                                            onChanged: (Object? value) {
                                                              if (value is int?) {
                                                                managerBloc.categoryId = value!;
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
                                                        stream: managerBloc.usertypeStream,
                                                        builder: (context, AsyncSnapshot<List<UserTypeList>> snapshot) {
                                                          if (null == snapshot.data || snapshot.data?.length == 0) {
                                                            return Container();
                                                          }

                                                          return DropdownButtonFormField(
                                                            value: managerBloc.usertypeId,
                                                            decoration: buildInputDecoration(Txt.user_type),
                                                            items: snapshot.data?.map((item) {
                                                              return DropdownMenuItem(
                                                                child: new Text(
                                                                  item.type!,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10.sp,
                                                                    decoration: TextDecoration.none,
                                                                    color: Constants.colors[29],
                                                                  ),
                                                                ),
                                                                value: item.rowId,
                                                              );
                                                            }).toList(),
                                                            onChanged: (Object? value) {
                                                              if (value is int?) {
                                                                managerBloc.usertypeId = value!;
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
                                                        stream: managerBloc.hospitalStream,
                                                        builder: (context, AsyncSnapshot<List<HospitalList>> snapshot) {
                                                          if (null == snapshot.data || snapshot.data?.length == 0) {
                                                            return Container();
                                                          }

                                                          return DropdownButtonFormField(
                                                            isExpanded: true,
                                                            value: managerBloc.hospitalId,
                                                            decoration: buildInputDecoration(Txt.client),
                                                            items: snapshot.data?.map((item) {
                                                              return DropdownMenuItem(
                                                                child: new Text(
                                                                  item.name!,
                                                                  overflow: TextOverflow.clip,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 8.sp,
                                                                    decoration: TextDecoration.none,
                                                                    color: Constants.colors[29],
                                                                  ),
                                                                ),
                                                                value: item.rowId,
                                                              );
                                                            }).toList(),
                                                            onChanged: (Object? value) {
                                                              if (value is int?) {
                                                                managerBloc.hospitalId = value!;
                                                                setState(() {
                                                                  managerBloc.unitId = 1;
                                                                });
                                                                managerBloc.getManagerUnitName(
                                                                    managerBloc.token, managerBloc.hospitalId.toString());
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
                                          SizedBox(
                                            width: 100.w,
                                            child: StreamBuilder(
                                              stream: managerBloc.managerunitStream,
                                              builder: (context, AsyncSnapshot<List<UnitItems>> snapshot) {
                                                if (null == snapshot.data || snapshot.data?.length == 0) {
                                                  return Container();
                                                }

                                                return DropdownButtonFormField(
                                                  isExpanded: true,
                                                  value: managerBloc.unitId,
                                                  decoration: buildInputDecoration(Txt.unit_name),
                                                  items: snapshot.data?.map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item.unitName!,
                                                        overflow: TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 9.sp,
                                                          decoration: TextDecoration.none,
                                                          color: Constants.colors[29],
                                                        ),
                                                      ),
                                                      value: item.unitRowId,
                                                    );
                                                  }).toList(),
                                                  onChanged: (Object? value) {
                                                    if (value is int?) {
                                                      managerBloc.unitId = value!;
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                child: TextInputFileds(
                                                    onChange: () {},
                                                    controlr: jobtitle,
                                                    validator: (jobtitle) {
                                                      if (validJob(jobtitle))
                                                        return null;
                                                      else
                                                        return Txt.enter_job;
                                                    },
                                                    hintText: Txt.jobtitle,
                                                    keyboadType: TextInputType.text,
                                                    isPwd: false,
                                                    onTapDate: () {}),
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
                                                      width: 50.w,
                                                      child: StreamBuilder(
                                                        stream: managerBloc.shifttimeStream,
                                                        builder: (context, AsyncSnapshot<List<ShiftTimingList>> snapshot) {
                                                          if (null == snapshot.data || snapshot.data?.length == 0) {
                                                            return Container();
                                                          }

                                                          return DropdownButtonFormField(
                                                            value: managerBloc.shiftTypeId,
                                                            decoration: buildInputDecoration(Txt.shift_type),
                                                            items: snapshot.data?.map((item) {
                                                              return DropdownMenuItem(
                                                                child: new Text(
                                                                  item.shift!,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10.sp,
                                                                    decoration: TextDecoration.none,
                                                                    color: Constants.colors[29],
                                                                  ),
                                                                ),
                                                                value: item.rowId,
                                                              );
                                                            }).toList(),
                                                            onChanged: (Object? value) {
                                                              managerBloc.isShiftTypeChanged = true;
                                                              if (value is int?) {
                                                                ShiftTimingList shiftValue =
                                                                    getItemFromId(value!, snapshot.data);
                                                                managerBloc.shiftTypeId = shiftValue.rowId!;
                                                                var timeFrom = shiftValue.startTime!;
                                                                var timeTo = shiftValue.endTime!;
                                                                dateFrom.text = convert24hrTo12hr(timeFrom, context);
                                                                dateTo.text = convert24hrTo12hr(timeTo, context);
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
                                                      child: TextInputFileds(
                                                          onChange: () {},
                                                          controlr: date,
                                                          validator: (date) {
                                                            if (validDate(date))
                                                              return null;
                                                            else
                                                              return Txt.select_date;
                                                          },
                                                          onTapDate: () {
                                                            selectDate(context, date);
                                                            var dates = date.text;
                                                            if (managerBloc.token != null && dates != "") {
                                                              var shifttype = managerBloc.shiftType;
                                                              managerBloc.getUserListByDate(
                                                                  managerBloc.token, dates, shifttype.toString());
                                                            }
                                                          },
                                                          hintText: Txt.date,
                                                          keyboadType: TextInputType.none,
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
                                              Visibility(
                                                visible: managerBloc.isPricevisible,
                                                child: Container(
                                                  child: TextInputFileds(
                                                      onChange: () {},
                                                      controlr: price,
                                                      validator: (date) {
                                                        if (validDate(date))
                                                          return null;
                                                        else
                                                          return Txt.enter_price;
                                                      },
                                                      onTapDate: () {},
                                                      hintText: Txt.price,
                                                      keyboadType: TextInputType.number,
                                                      isPwd: false),
                                                ),
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
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 2),
                                                      child: Container(
                                                        child: TextInputFileds(
                                                            onChange: () {},
                                                            controlr: dateFrom,
                                                            validator: (dateTo) {
                                                              if (validDate(dateTo))
                                                                return null;
                                                              else
                                                                return Txt.select_time;
                                                            },
                                                            onTapDate: () {
                                                              selectTime(context, dateFrom);
                                                            },
                                                            hintText: Txt.timeFrom,
                                                            keyboadType: TextInputType.none,
                                                            isPwd: false),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: TextInputFileds(
                                                        onChange: () {},
                                                        controlr: dateTo,
                                                        validator: (dateTo) {
                                                          if (validDate(dateTo))
                                                            return null;
                                                          else
                                                            return Txt.select_time;
                                                        },
                                                        onTapDate: () {
                                                          FocusScope.of(context).unfocus();
                                                          selectTime(context, dateTo);
                                                        },
                                                        hintText: Txt.timeTo,
                                                        keyboadType: TextInputType.none,
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
                                                child: TextInputFiledDescription(
                                                    controlr: jobDescri,
                                                    onTapDate: () {},
                                                    validator: (jobDescri) {
                                                      if (validDescription(jobDescri))
                                                        return null;
                                                      else
                                                        return Txt.enter_job_descri;
                                                    },
                                                    hintText: Txt.jobDescri,
                                                    keyboadType: TextInputType.visiblePassword,
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
                                                  Txt.allowances,
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "SFProMedium",
                                                  ),
                                                ),
                                              ),
                                              RaisedButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return AllowanceBottomSheet(
                                                          onSumbmit: () {},
                                                          onTapView: () {},
                                                          value: 1,
                                                        );
                                                      });
                                                },
                                                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                                color: Colors.blueAccent,
                                                child: Text(
                                                  Txt.add_allowances,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      letterSpacing: 0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          StreamBuilder<List<Allowances>>(
                                              stream: managerBloc.allowancesList,
                                              builder: (context, snapshot) {
                                                if (null == snapshot.data) {
                                                  return Container();
                                                }
                                                if (null == snapshot.data) {
                                                  return Container();
                                                }
                                                return buildAllowanceList(snapshot, context);
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
          ),
          Center(
            child: StreamBuilder(
              stream: managerBloc.visible,
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
          ),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration(String type) {
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: Constants.colors[28],
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Constants.colors[28], width: 1)),
        contentPadding: EdgeInsets.all(3.0),
        labelText: type,
        labelStyle: TextStyle(fontSize: 10.sp));
  }

  Widget buildAllowanceList(AsyncSnapshot<List<Allowances>> snapshot, BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data?.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var items = snapshot.data?[index];
        String? allowace = items?.allowance.toString();
        print(allowace);
        String? category = items?.category.toString();
        String? amount = items?.amount.toString();
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      allowace!,
                      style: TextStyle(
                          color: Constants.colors[1], fontSize: 14, fontFamily: "SFProMedium", fontWeight: FontWeight.w500),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      category!,
                      style: TextStyle(
                          color: Constants.colors[1], fontSize: 14, fontFamily: "SFProMedium", fontWeight: FontWeight.w500),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      amount!,
                      style: TextStyle(
                          color: Constants.colors[1], fontSize: 14, fontFamily: "SFProMedium", fontWeight: FontWeight.w500),
                    )),
                GestureDetector(
                  onTap: () {
                    print("Delete");
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
          ),
        );
      },
    );
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
                            final prefs = await SharedPreferences.getInstance();
                            var auth_tokn = prefs.getString(SharedPrefKey.AUTH_TOKEN);
                            if (null == auth_tokn) {
                              return;
                            }

                            print("managerBloc.typeId");
                            print(managerBloc.typeId);
                            managerBloc.createShiftManager(
                                auth_tokn,
                                managerBloc.row_id,
                                managerBloc.typeId,
                                managerBloc.categoryId,
                                managerBloc.usertypeId,
                                jobtitle.text,
                                managerBloc.hospitalId,
                                date.text,
                                dateFrom.text,
                                dateTo.text,
                                jobDescri.text,
                                price.text,
                                managerBloc.shiftTypeId.toString(),
                                managerBloc.unitId.toString());
                          }
                        }
                      },
                      label: managerBloc.buttonText)
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
      var message = event.response?.status?.statusMessage.toString();
      if (event.response?.status?.statusCode == 200) {
        managerBloc.reset();
        Fluttertoast.showToast(msg: '$message');
        Navigator.pop(context);
      } else {
        showAlertDialoge(context, title: Txt.failed, message: message!);
      }
    });

    managerBloc.shifttimeStream.listen((event) {
      if (!managerBloc.isShiftTypeChanged && managerBloc.shiftTypeId == 1) {
        var shiftValue = event.first;
        managerBloc.shiftTypeId = shiftValue.rowId!;
        var timeFrom = shiftValue.startTime!;
        var timeTo = shiftValue.endTime!;
        dateFrom.text = convert24hrTo12hr(timeFrom, context);
        dateTo.text = convert24hrTo12hr(timeTo, context);
      }
    });
  }

  getItemFromId(int value, List<ShiftTimingList>? data) {
    int? index = data?.indexWhere((element) => element.rowId == value);
    return data![index!];
  }

  updateAllowances(BuildContext context, Items item) {
    if (item != null) {
      jobtitle.text = item.jobTitle!;
      managerBloc.row_id = item.rowId!;
      date.text = item.date!;
      dateTo.text = convert24hrTo12hr(item.timeTo!, context);
      if (item.price != null) {
        price.text = item.price.toString();
      }
      dateFrom.text = convert24hrTo12hr(item.timeFrom!, context);
      jobDescri.text = item.jobDetails!;
      category.text = item.category!;
      managerBloc.buttonText = "Edit Shift";
    }

    if (null != item.allowances) {
      managerBloc.setAllowance(item.allowances!);
    }
    print(item.type);
    print("item.hospitalId");
    print(item.hospitalId);
    print(item.type == "Premium");
    if (item.type == "Premium") {
      setState(() {
        managerBloc.typeId = 1;
        managerBloc.isPricevisible = true;
      });
    } else {
      setState(() {
        managerBloc.typeId = 0;
        managerBloc.isPricevisible = false;
      });
    }

    if (item.categoryId != 0 && null != item.categoryId) {
      setState(() {
        managerBloc.categoryId = item.categoryId!;
      });
    }

    if (item.userTypeId != 1 && null != item.userTypeId) {
      setState(() {
        managerBloc.usertypeId = item.userTypeId!;
      });
    }
    print("item.hospitalId");
    print(item.hospitalId);
    if (item.hospitalId != 0 && null != item.hospitalId) {
      setState(() {
        managerBloc.hospitalId = item.hospitalId!;
      });
      managerBloc.getManagerUnitName(managerBloc.token, item.hospitalId.toString());
    }
    if (null != item.shiftTypeId) {
      setState(() {
        managerBloc.shiftTypeId = item.shiftTypeId!;
      });
    }
    if (item.unitNameId != 0 && null != item.unitNameId) {
      setState(() {
        managerBloc.unitId = item.unitNameId!;
      });
    }
  }
}
