import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/db/database.dart';
import 'package:xpresshealthdev/dbmodel/allowance_category_model.dart';
import 'package:xpresshealthdev/model/allowance_model.dart';
import 'package:xpresshealthdev/model/schedule_hospital_list.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../dbmodel/allowance_mode.dart';
import '../model/gender_list.dart';
import '../model/get_available_user_by_date.dart';
import '../model/manager_get_clients.dart';
import '../model/manager_response.dart';
import '../model/manager_unit_name.dart';
import '../model/schedule_categegory_list.dart';
import '../model/shift_type_list.dart';
import '../model/user_shifttiming_list.dart';
import '../model/user_type_list.dart';
import '../utils/utils.dart';

class CreateShiftmanagerBloc {




  var row_id = -1;
  var typeId = 1;
  var categoryId = 1;
  var usertypeId = 2; //default
  var shiftType = 0;
  var hospitalId = 1;
  var shiftTypeId = 1;
  var unitId = 1;
  var allowanceCategroyId = 1;
  var allowanceId = 1;
  var allowanceCategroy = "Food Item";
  var allowance = "Break Fast";
  var shiftItem;

  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;




  bool isPricevisible = false;
  bool isShiftTypeChanged = false;
  var buttonText = "Create Shift";
  var token;


  final _repo = Repository();
  final _db = Db();
  final _manager = PublishSubject<GetAvailableUserByDate>();
  final _getmanager = PublishSubject<ManagerShift>();

  final _managerclient = PublishSubject<List<HospitalListItem>>();
  final _managerunit = PublishSubject<List<UnitItems>>();

  final _managerclients = PublishSubject<ManagerGetClientsResponse>();
  final _managerunits = PublishSubject<ManagerUnitNameResponse>();

  Stream<List<HospitalListItem>> get managergetclientStream =>
      _managerclient.stream;

  Stream<List<UnitItems>> get managerunitStream => _managerunit.stream;

  Stream<ManagerGetClientsResponse> get getclientsdtream =>
      _managerclients.stream;

  Stream<ManagerUnitNameResponse> get managerunitnamestream =>
      _managerunits.stream;

  List<Allowances> allowanceList = [];
  final _allowancesList = PublishSubject<List<Allowances>>();

  Stream<List<Allowances>> get allowancesList => _allowancesList.stream;

  List<String> allowancesCategory = [];
  final _typeAllowancesCategroy = PublishSubject<List<AllowanceCategoryList>>();

  Stream<List<AllowanceCategoryList>> get typeAllowancesCategroys =>
      _typeAllowancesCategroy.stream;

  List<String> allowances = [];
  final _typeAllowances = PublishSubject<List<AllowanceList>>();

  Stream<List<AllowanceList>> get typeAllowancesList => _typeAllowances.stream;

  // gender
  List<String> genders = [];
  final _gender = PublishSubject<List<GenderList>>();

  Stream<List<GenderList>> get genderStream => _gender.stream;

  List<String> type = [];
  final _type = PublishSubject<List<ShiftTypeList>>();

  Stream<List<ShiftTypeList>> get typeStream => _type.stream;

  List<String> category = [];
  final _category = PublishSubject<List<ScheduleCategoryList>>();

  Stream<List<ScheduleCategoryList>> get categoryStream => _category.stream;

  List<String> usertypeStr = [];
  final _usertype = PublishSubject<List<UserTypeList>>();

  Stream<List<UserTypeList>> get usertypeStream => _usertype.stream;

  List<String> hospitals = [];
  final _hospital = PublishSubject<List<HospitalList>>();

  Stream<List<HospitalList>> get hospitalStream => _hospital.stream;

  List<String> shifttype = [];
  final _shifttype = PublishSubject<List<ShiftTypeList>>();

  Stream<List<ShiftTypeList>> get shifttypeStream => _shifttype.stream;

  List<String> shifttime = [];
  final _shiftime = PublishSubject<List<ShiftTimingList>>();

  Stream<List<ShiftTimingList>> get shifttimeStream => _shiftime.stream;

  getDropDownValues() async {
    var usertype = await _db.getUserTypeList();
    var category = await _db.getCategory();
    var hospitals = await _db.getHospitalList();

    var shifttiming = await _db.getShiftTimingList();
    List<ShiftTypeList> typeList = [];
    var type1 = ShiftTypeList(rowId: 0, type: "Regular");
    var type2 = ShiftTypeList(rowId: 1, type: "Premium");
    typeList.add(type1);
    typeList.add(type2);
    List<ShiftTypeList> shifttype = [];
    var shifttype1 = ShiftTypeList(rowId: 1, type: "Day");
    var shifttype2 = ShiftTypeList(rowId: 2, type: "Night");
    shifttype.add(shifttype1);

    shifttype.add(shifttype2);
    _shifttype.add(shifttype);

    _type.add(typeList);
    _category.add(category);
    _usertype.add(usertype);
    _hospital.add(hospitals);
    _shiftime.add(shifttiming);
  }

  getModelDropDown() async {
    print("getModelDropDown");
    _typeAllowancesCategroy.drain();
    var typeList = await _db.getAllowanceCategoryList();
    for (var list in typeList) {
      print(list.category);
    }
    _typeAllowancesCategroy.add(typeList);
  }

  getAllowanceList(int id) async {
    print("getAllowanceCategory");
    _typeAllowances.drain();
    var typeList = await _db.getAllowanceList(id);
    print("typeList");
    print(typeList.length);
    _typeAllowances.add(typeList);
  }

  Stream<ManagerShift> get getmanagerStream => _getmanager.stream;

  createShiftManager(
    String token,
    int row_id,
    int type,
    int category,
    int user_type,
    String job_title,
    int hospital,
    String date,
    String time_from,
    String time_to,
    String job_details,
    String price,
    String shift,
    String unit_name,
  ) async {


    _visibility.add(true);
    var timeFrom = convert12hrTo24hr(time_from);
    var timeTo = convert12hrTo24hr(time_to);

    var json = jsonEncode(allowanceList.map((e) => e.toJson()).toList());
    var allowances = json.toString();
    print("allowances");
    print(allowances);
    ManagerShift respo = await _repo.CreateShiftManager(
      token,
      row_id,
      type,
      category,
      user_type,
      job_title,
      hospital,
      date,
      timeFrom,
      timeTo,
      job_details,
      price,
      shift,
      json,
      unit_name,
    );
    _getmanager.sink.add(respo);
    _visibility.add(false);
  }

  getUserListByDate(String token, String date, String shifttype) async {
    GetAvailableUserByDate list =
        await _repo.fetchGetAvailableUserByDate(token, date, shifttype);
    _manager.sink.add(list);
  }

  Stream<GetAvailableUserByDate> get managerStream => _manager.stream;

  getManagerClient(
    String token,
  ) async {
    _visibility.add(true);
    ManagerGetClientsResponse respo = await _repo.fetchManagerGetClients(token);
    var list = respo.response?.data?.items;
    _managerclient.sink.add(list!);
    _visibility.add(false);
  }

  getManagerUnitName(String token, String client) async {
    _visibility.add(true);
    ManagerUnitNameResponse respo =
        await _repo.fetchManagerUnitName(token, client);
    var list = respo.response?.data?.items;
    _managerunit.sink.add(list!);
    _visibility.add(false);
  }

  dispose() {
    _manager.close();
    _managerclient.close();
    _managerunit.close();
  }

  void addAllowances(int allowanceId, int allowanceCategroyId, String allowance,
      String allowanceCategroy, String amount) {
    Allowances allowances = Allowances(
        allowance: allowance,
        category: allowanceCategroy,
        amount: amount,
        allowanceId: allowanceId,
        categoryId: allowanceCategroyId);
    allowanceList.add(allowances);
    _allowancesList.add(allowanceList);
  }

  void deleteAllowance(int index) {
    if (null != allowanceList) {
      allowanceList.removeAt(index);
      _allowancesList.add(allowanceList);
    }
  }

  void setAllowance(List<Allowances> allowances) {
    allowanceList.clear();
    if (!_allowancesList.isClosed) {
      print("allo.category");
      for (var allo in allowances) {
        print(allo.category);
        allowanceList.add(allo);
      }
      _allowancesList.add(allowanceList);
    }
  }
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

final managerBloc = CreateShiftmanagerBloc();
