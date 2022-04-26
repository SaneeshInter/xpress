import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/db/database.dart';
import 'package:xpresshealthdev/dbmodel/allowance_category_model.dart';
import 'package:xpresshealthdev/model/allowance_model.dart';
import 'package:xpresshealthdev/model/schedule_hospital_list.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../dbmodel/allowance_mode.dart';
import '../model/gender_list.dart';
import '../model/manager_response.dart';
import '../model/schedule_categegory_list.dart';
import '../model/shift_type_list.dart';
import '../model/user_type_list.dart';

class CreateShiftmanagerBloc {
  final _repo = Repository();
  final _db = Db();
  final _manager = PublishSubject<void>();
  final _getmanager = PublishSubject<ManagerShift>();
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

  getDropDownValues() async {
    var usertype = await _db.getUserTypeList();
    var category = await _db.getCategory();
    var hospitals = await _db.getHospitalList();
    List<ShiftTypeList> typeList = [];
    var type1 = ShiftTypeList(rowId: 1, type: "Regular");
    var type2 = ShiftTypeList(rowId: 2, type: "Premium");
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

  Stream<void> get managerStream => _manager.stream;

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
  ) async {
    var json = jsonEncode(allowanceList.map((e) => e.toJson()).toList());
    // var json = jsonEncode(allowanceList, toEncodable: (e) => {
    // print(e)
    // });
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
      time_from,
      time_to,
      job_details,
      price,
      shift,
      allowances,
    );

    _getmanager.sink.add(respo);
  }

  getUserListByDate(String token, String date, String shifttype) {
    _repo.fetchGetAvailableUserByDate(token, date, shifttype);
  }

  dispose() {
    _manager.close();
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
      allowanceList.remove(index);
      _allowancesList.add(allowanceList);
    }
  }
}

final managerBloc = CreateShiftmanagerBloc();
