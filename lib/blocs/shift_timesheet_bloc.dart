import 'package:rxdart/rxdart.dart';

import '../model/manager_get_time.dart';
import '../model/manager_timesheet.dart';

import '../resources/respository.dart';

class ShiftTimeSheetBloc{
  final _repo = Repository();
  final _shiftimeSheet = PublishSubject<ManagerTimeSheetResponse>();
  final _shiftimeSheetDetails = PublishSubject<ManagerTimeDetailsResponse>();

  Stream<ManagerTimeSheetResponse> get timesheet => _shiftimeSheet.stream;
  Stream<ManagerTimeDetailsResponse> get timesheetdetails => _shiftimeSheetDetails.stream;


  fetchTimesheet(String token) async {
    ManagerTimeSheetResponse list = await _repo.fetchManagerTimesheet(token);
    _shiftimeSheet.sink.add(list);
  }
  fetchTimesheetDetails(String token,String time_shhet_id) async {
    ManagerTimeDetailsResponse list = await _repo.fetchManagerTimesheetDetials(token,time_shhet_id);
    _shiftimeSheetDetails.sink.add(list);
  }


  dispose() {
    _shiftimeSheet.close();
    _shiftimeSheetDetails.close();
  }
}



final  timesheetBloc= ShiftTimeSheetBloc();
