import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../db/database.dart';
import '../dbmodel/allowance_category_model.dart';
import '../model/allowance_model.dart';
import '../model/schedule_hospital_list.dart';
import '../resources/respository.dart';

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

class CreateShiftManagerBloc {

  var rowId = -1;
  var typeId = 1;
  var categoryId = 1;
  var usertypeId = 2; //default
  var shiftType = 1;
  var hospitalId = 1;
  var shiftTypeId = 1;
  var unitId = 1;
  var allowanceCategoryId = 1;
  var allowanceId = 1;
  var allowanceCategory = "Food Item";
  var allowance = "Break Fast";
  var shiftItem;
  var buttonText = "Create Shift";
  var token;
  bool isShiftTypeChanged = false;
  late AllowanceList selectedAllowance;
  late AllowanceCategoryList selectedAllowanceCategory;
  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;

  final _repo = Repository();
  final _db = Db();
  final _manager = PublishSubject<GetAvailableUserByDate>();
  final _getManager = PublishSubject<ManagerShift>();

  final _managerClient = PublishSubject<List<HospitalListItem>>();
  final _managerUnit = PublishSubject<List<UnitItems>>();

  final _managerClients = PublishSubject<ManagerGetClientsResponse>();
  final _managerUnits = PublishSubject<ManagerUnitNameResponse>();

  Stream<List<HospitalListItem>> get managerGetClientStream => _managerClient.stream;

  Stream<List<UnitItems>> get managerUnitStream => _managerUnit.stream;

  Stream<ManagerGetClientsResponse> get getClientsStream => _managerClients.stream;

  Stream<ManagerUnitNameResponse> get managerUnitNameStream => _managerUnits.stream;

  List<Allowances> allowanceList = [];
  final _allowancesList = PublishSubject<List<Allowances>>();

  Stream<List<Allowances>> get allowancesList => _allowancesList.stream;

  List<String> allowancesCategory = [];
  final _typeAllowancesCategory = PublishSubject<List<AllowanceCategoryList>>();

  Stream<List<AllowanceCategoryList>> get typeAllowancesCategory => _typeAllowancesCategory.stream;

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

  List<String> shiftTypes = [];
  final _shiftType = PublishSubject<List<ShiftTypeList>>();

  Stream<List<ShiftTypeList>> get shiftTypeStream => _shiftType.stream;

  List<String> shiftTime = [];
  final _shiftTime = PublishSubject<List<ShiftTimingList>>();

  Stream<List<ShiftTimingList>> get shiftTimeStream => _shiftTime.stream;

  reset() {
    rowId = -1;
    typeId = 1;
    categoryId = 1;
    usertypeId = 2; //default
    shiftType = 0;
    hospitalId = 1;
    shiftTypeId = 1;
    unitId = 1;
    allowanceCategoryId = 1;
    allowanceId = 1;
    allowanceCategory = "Food Item";
    allowance = "Break Fast";
    buttonText = "Create Shift";
    isShiftTypeChanged = false;
  }

  getDropDownValues() async {
    var usertype = await _db.getUserTypeList();
    var category = await _db.getCategory();
    var hospitals = await _db.getHospitalList();
    var shifttiming = await _db.getShiftTimingList();
    List<ShiftTypeList> typeList = [];

    typeList.add(ShiftTypeList(rowId: 0, type: "Regular"));
    typeList.add(ShiftTypeList(rowId: 1, type: "Premium"));
    List<ShiftTypeList> shifttype = [];
    var shifttype1 = ShiftTypeList(rowId: 1, type: "Day");
    var shifttype2 = ShiftTypeList(rowId: 2, type: "Night");
    shifttype.add(shifttype1);

    shifttype.add(shifttype2);
    _shiftType.sink.add(shifttype);

    _type.sink.add(typeList);
    _category.sink.add(category);
    _usertype.sink.add(usertype);
    _hospital.sink.add(hospitals);
    _shiftTime.sink.add(shifttiming);
  }

  getModelDropDown() async {
    _typeAllowancesCategory.drain();
    var typeList = await _db.getAllowanceCategoryList();
    for (var list in typeList) {
      (list.category);
    }
    if(typeList.isNotEmpty)
      {
        selectedAllowanceCategory = typeList[0];
        allowanceId = 1;
        allowanceCategory = "Food Item";
        managerBloc.typeAllowancesList.drain();
        managerBloc.getAllowanceList(selectedAllowanceCategory.rowId!);
        allowanceCategoryId = selectedAllowanceCategory.rowId!;
        allowanceCategory = selectedAllowanceCategory.category!;
        _typeAllowancesCategory.add(typeList);
      }

  }

  getAllowanceList(int id) async {
    _typeAllowances.drain();
    var typeList = await _db.getAllowanceList(id);
    selectedAllowance = typeList[0];
    _typeAllowances.add(typeList);
    allowanceId = typeList[0].rowId!;
    allowance = typeList[0].allowance!;

  }

  Stream<ManagerShift> get getManagerStream => _getManager.stream;

  createShiftManager(
    String token,
    int rowId,
    int type,
    int category,
    int userType,
    String jobTitle,
    int hospital,
    String date,
    String time_from,
    String time_to,
    String job_details,
    String price,
    String shift,
    String unit_name,
    String poCode,
  ) async {
    _visibility.add(true);
    var timeFrom = convert12hrTo24hr(time_from);
    var timeTo = convert12hrTo24hr(time_to);
    var json = jsonEncode(allowanceList.map((e) => e.toJson()).toList());
    debugPrint("aaaa\n\n$json");
    ManagerShift resp = await _repo.CreateShiftManager(
      token,
      rowId,
      type,
      category,
      userType,
      jobTitle,
      hospital,
      date,
      timeFrom,
      timeTo,
      job_details,
      price,
      shift,
      json,
      unit_name,
        poCode
    );
    _getManager.sink.add(resp);
    _visibility.add(false);
  }

  getUserListByDate(String token, String date, String shifttype) async {
    GetAvailableUserByDate list = await _repo.fetchGetAvailableUserByDate(token, date, shifttype);
    _manager.sink.add(list);
  }

  Stream<GetAvailableUserByDate> get managerStream => _manager.stream;

  getManagerClient( String token,) async {
    _visibility.add(true);
    ManagerGetClientsResponse resp = await _repo.fetchManagerGetClients(token);
    var list = resp.response?.data?.items;
    _managerClient.sink.add(list!);
    _visibility.add(false);
  }

  getManagerUnitName(String token, String client) async {
    _visibility.add(true);
    ManagerUnitNameResponse resp = await _repo.fetchManagerUnitName(token, client);
    var list = resp.response?.data?.items;
    _managerUnit.sink.add(list!);
    _visibility.add(false);
  }

  dispose() {
    // _manager.close();
    // _managerclient.close();
    // _managerunit.close();
    // _getmanager.close();
  }

  void addAllowances(int allowanceId, int allowanceCategoryId, String allowance, String allowanceCategory, String amount) {
    Allowances allowances = Allowances(
        allowance: allowanceId.toString(),
        category_name: allowanceCategory,
        price: amount,
        allowance_name: allowance.toString(),
        category: allowanceCategoryId.toString());
    allowanceList.add(allowances);
    _allowancesList.add(allowanceList);
  }

  void deleteAllowance(int index) {
    if (null!= allowanceList) {
      allowanceList.removeAt(index);
      _allowancesList.add(allowanceList);
    }
  }

  void setAllowance(List<Allowances> allowances) {
    allowanceList.clear();
    if (!_allowancesList.isClosed) {

      for (var allow in allowances) {
        debugPrint(allow.category_name);
        allowanceList.add(allow);
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

final managerBloc = CreateShiftManagerBloc();
