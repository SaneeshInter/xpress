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
  final _shiftimeSheet = PublishSubject<ManagerTimeSheetResponse>();
  final _shiftimeSheetDetails = PublishSubject<ManagerTimeDetailsResponse>();
  final _approvetimesheet = PublishSubject<ManagerApproveResponse>();

  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;

  Stream<ManagerTimeSheetResponse> get timesheet => _shiftimeSheet.stream;

  Stream<ManagerTimeDetailsResponse> get timesheetdetails =>
      _shiftimeSheetDetails.stream;

  Stream<ManagerApproveResponse> get approvetimesheet =>
      _approvetimesheet.stream;

  fetchTimesheet(String token) async {
    _visibility.add(true);
    ManagerTimeSheetResponse list = await _repo.fetchManagerTimesheet(token);
    _shiftimeSheet.sink.add(list);
    _visibility.add(false);
  }
  fetchTimesheetDetails() async {
    _visibility.add(true);
    ManagerTimeDetailsResponse list =
        await _repo.fetchManagerTimesheetDetials(token, time_shhet_id);
    _shiftimeSheetDetails.sink.add(list);
    _visibility.add(false);
  }

  approveTimeSheet() async {
    _visibility.add(true);
    var json =
        jsonEncode(approveData.map((e) => e.toJson()).toList()).toString();
    ManagerApproveResponse list =
        await _repo.fetchapproveTimeSheet(token, json);
    _approvetimesheet.sink.add(list);
    _visibility.add(false);
  }

  dispose() {
    _shiftimeSheet.close();
    _shiftimeSheetDetails.close();
    _approvetimesheet.close();
  }
}

final timesheetBloc = ShiftTimeSheetBloc();
