import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../model/shift_list_response.dart';
import '../model/user_getschedule_bydate.dart';
import '../model/user_job_request.dart';

class ShiftListBloc {
  final _repo = Repository();
  final _shiftList = PublishSubject<SliftListRepso>();
  final _visibility = PublishSubject<bool>();
  final _scheduledate = PublishSubject<UserGetScheduleByDate>();
  final _jobrequest = PublishSubject<UserJobRequestResponse>();

  Stream<SliftListRepso> get allShift => _shiftList.stream;

  Stream<bool> get visible => _visibility.stream;

  Stream<UserGetScheduleByDate> get shiftbydate => _scheduledate.stream;

  Stream<UserJobRequestResponse> get jobrequest => _jobrequest.stream;

  fetchAllList(String date) async {
    SliftListRepso list = await _repo.fetchAllShift(date);
    _shiftList.sink.add(list);
  }

  //SCHEDULE DATE
  fetchgetUserScheduleByDate(String token, String date) async {
    _visibility.add(true);
    UserGetScheduleByDate list =
        await _repo.fetchGetUserScheduleByDate(token, date);
    _scheduledate.sink.add(list);
    _visibility.add(false);
  }

  // JOB REQUEST
  fetchuserJobRequest(String token, String job_id) async {
    UserJobRequestResponse list =
        await _repo.fetchUserJobRequest(token, job_id);
    _jobrequest.sink.add(list);
  }

  dispose() {
    _shiftList.close();
    _scheduledate.close();
    _jobrequest.close();
  }
}

final bloc = ShiftListBloc();
