import 'package:rxdart/rxdart.dart';

import '../model/manager_approve_timesheet_respo.dart';
import '../model/manager_get_time.dart';
import '../model/manager_timesheet.dart';

import '../resources/respository.dart';

class CompletedApprovelBloc{
  final _repo = Repository();
  final _shiftimeSheet = PublishSubject<ManagerTimeSheetResponse>();
  final _shiftimeSheetDetails = PublishSubject<ManagerTimeDetailsResponse>();
  final _approvetimesheet = PublishSubject<ManagerApproveResponse>();


  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;

  Stream<ManagerTimeSheetResponse> get timesheet => _shiftimeSheet.stream;
  Stream<ManagerTimeDetailsResponse> get timesheetdetails => _shiftimeSheetDetails.stream;

  Stream<ManagerApproveResponse> get approvetimesheet => _approvetimesheet.stream;






  completedApprovel(String token) async {
    _visibility.add(true);
    ManagerTimeSheetResponse list = await _repo.fetchcompletedApprovel(token);
    _shiftimeSheet.sink.add(list);
    _visibility.add(false);
  }


  fetchTimesheetDetails(String token,String time_shhet_id) async {
    _visibility.add(true);
    ManagerTimeDetailsResponse list = await _repo.fetchManagerTimesheetDetials(token,time_shhet_id);
    _shiftimeSheetDetails.sink. add(list);
    _visibility.add(false);
  }






  approveTimeSheet(String token,String data) async {
    _visibility.add(true);
    ManagerApproveResponse list = await _repo.fetchapproveTimeSheet(token,data);
    _approvetimesheet.sink.add(list);
    _visibility.add(false);
  }

  dispose() {
    _shiftimeSheet.close();
    _shiftimeSheetDetails.close();
    _approvetimesheet.close();
  }
}



final  compeletedApprovelBloc= CompletedApprovelBloc();
