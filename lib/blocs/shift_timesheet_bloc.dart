import 'package:rxdart/rxdart.dart';

import '../model/manager_approve_timesheet_respo.dart';
import '../model/manager_get_time.dart';
import '../model/manager_timesheet.dart';

import '../resources/respository.dart';

class ShiftTimeSheetBloc{
  final _repo = Repository();
  final _shiftimeSheet = PublishSubject<ManagerTimeSheetResponse>();
  final _shiftimeSheetDetails = PublishSubject<ManagerTimeDetailsResponse>();
  final _approvetimesheet = PublishSubject<ManagerApproveResponse>();

  Stream<ManagerTimeSheetResponse> get timesheet => _shiftimeSheet.stream;
  Stream<ManagerTimeDetailsResponse> get timesheetdetails => _shiftimeSheetDetails.stream;

  Stream<ManagerApproveResponse> get approvetimesheet => _approvetimesheet.stream;




  fetchTimesheet(String token) async {
    ManagerTimeSheetResponse list = await _repo.fetchManagerTimesheet(token);
    _shiftimeSheet.sink.add(list);
  }
  fetchTimesheetDetails(String token,String time_shhet_id) async {
    ManagerTimeDetailsResponse list = await _repo.fetchManagerTimesheetDetials(token,time_shhet_id);
    _shiftimeSheetDetails.sink. add(list);
  }



  fetchApproveTimesheet(String token,String data) async {
    ManagerApproveResponse list = await _repo.fetchapproveTimeSheet(token,data);
    _approvetimesheet.sink. add(list);
  }


  dispose() {
    _shiftimeSheet.close();
    _shiftimeSheetDetails.close();
    _approvetimesheet.close();
  }
}



final  timesheetBloc= ShiftTimeSheetBloc();
