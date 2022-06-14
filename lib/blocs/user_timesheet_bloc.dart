import 'package:rxdart/rxdart.dart';

import '../resources/respository.dart';

import '../model/user_get_timesheet.dart';
import '../model/user_time_sheet_details_respo.dart';

class UserTimeSheet {
  final _repo = Repository();
  final _usergettimesheet = PublishSubject<UserTimeSheetRespo>();
  final _usertimedetails = PublishSubject<UserTimeSheetDetailsRespo>();

  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;


  Stream<UserTimeSheetRespo> get timesheetstream =>
      _usergettimesheet.stream;

  Stream<UserTimeSheetDetailsRespo> get  timedetailststream =>
      _usertimedetails.stream;

  userGetTimeSheet(String token  ) async {
    _visibility.add(true);
    UserTimeSheetRespo respo =
    await _repo.fetchUserGetTimeSheet(token);
    _usergettimesheet.sink.add(respo);
    _visibility.add(false);
  }



  userGetTimeSheetDetails(  String token,String time_shhet_id ) async {
    _visibility.add(true);
    UserTimeSheetDetailsRespo respo =
    await _repo.fetchUserGetTimeSheetDetails(token,time_shhet_id);
    _usertimedetails.sink.add(respo);
    _visibility.add(false);

  }



  dispose() {
    _usergettimesheet.close();
    _usertimedetails.close();
  }
}

final  usertimesheetBloc= UserTimeSheet();
