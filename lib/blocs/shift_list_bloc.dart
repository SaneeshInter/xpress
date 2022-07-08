import 'package:rxdart/rxdart.dart';
import '../resources/respository.dart';

import '../model/shift_list_response.dart';
import '../model/user_getschedule_bydate.dart';
import '../model/user_job_request.dart';

class ShiftListBloc {

  var token;
  final _repo = Repository();

  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;

  final _shiftList = PublishSubject<SliftListRepso>();
  final _scheduleDate = PublishSubject<UserGetScheduleByDate>();
  final _jobRequest = PublishSubject<UserJobRequestResponse>();
  Stream<SliftListRepso> get allShift => _shiftList.stream;
  Stream<UserGetScheduleByDate> get shiftByDate => _scheduleDate.stream;
  Stream<UserJobRequestResponse> get jobRequest => _jobRequest.stream;
  fetchAllList(String date) async {
    _visibility.add(true);
    SliftListRepso list = await _repo.fetchAllShift(date);
    if(null != list.response){
      _visibility.add(false);
      _shiftList.sink.add(list);
    }else
      {
        _visibility.add(false);
        _shiftList.sink.add(SliftListRepso());
      }
  }

  fetchGetUserScheduleByDate(String date) async {
    _visibility.add(true);
    UserGetScheduleByDate list =
        await _repo.fetchGetUserScheduleByDate(token, date);
    _scheduleDate.sink.add(list);
    _visibility.add(false);
  }

  fetchUserJobRequest(String job_id) async {
    _visibility.add(true);
    UserJobRequestResponse list =
        await _repo.fetchUserJobRequest(token, job_id);
    _jobRequest.sink.add(list);
    _visibility.add(false);
  }

  dispose() {
    _shiftList.close();
    _scheduleDate.close();
    _jobRequest.close();
  }
}

final bloc = ShiftListBloc();
