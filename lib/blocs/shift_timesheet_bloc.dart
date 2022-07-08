import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import '../model/approve_data.dart';
import '../model/manager_approve_timesheet_respo.dart';
import '../model/manager_get_time.dart';
import '../model/manager_timesheet.dart';
import '../resources/respository.dart';

class ShiftTimeSheetBloc {
  var token;
  var time_shhet_id = "";
  List<ApproveData> approveData = [];

  final _repo = Repository();
  final _shiftTimeSheet = PublishSubject<ManagerTimeSheetResponse>();
  final _shiftTimeSheetDetails = PublishSubject<ManagerTimeDetailsResponse>();
  final _approveTimesheet = PublishSubject<ManagerApproveResponse>();

  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;

  Stream<ManagerTimeSheetResponse> get timesheet => _shiftTimeSheet.stream;

  Stream<ManagerTimeDetailsResponse> get timeSheetDetails =>
      _shiftTimeSheetDetails.stream;

  Stream<ManagerApproveResponse> get approveTimeSheets =>
      _approveTimesheet.stream;

  fetchTimesheet() async {
    _visibility.add(true);
    ManagerTimeSheetResponse list = await _repo.fetchManagerTimesheet(token);
    _shiftTimeSheet.sink.add(list);
    _visibility.add(false);
  }
  fetchTimesheetDetails() async {
    _visibility.add(true);
    ManagerTimeDetailsResponse list =
        await _repo.fetchManagerTimesheetDetials(token, time_shhet_id);
    _shiftTimeSheetDetails.sink.add(list);
    _visibility.add(false);
  }

  approveTimeSheet(List<ApproveData> data) async {
    _visibility.add(true);
    var json =
        jsonEncode(data.map((e) => e.toJson()).toList()).toString();
    ManagerApproveResponse list =
        await _repo.fetchapproveTimeSheet(token, json);
    _approveTimesheet.sink.add(list);
    _visibility.add(false);
  }

  dispose() {
    _shiftTimeSheet.close();
    _shiftTimeSheetDetails.close();
    _approveTimesheet.close();
  }
}

final timesheetBloc = ShiftTimeSheetBloc();
