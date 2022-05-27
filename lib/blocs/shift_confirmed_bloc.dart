import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/model/user_view_request_response.dart';

import '../model/user_cancel_jobrequest.dart';
import '../model/user_working_hours.dart';
import '../resources/respository.dart';

class ShiftConfirmedBloc {
  final _repo = Repository();

  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;

  final _viewrequest = PublishSubject<UserViewRequestResponse>();
  final _usercanceljob = PublishSubject<UserCancelJobRequestResponse>();
  final _userworkinghours = PublishSubject<UserWorkingHoursResponse>();

  Stream<UserViewRequestResponse> get viewrequest => _viewrequest.stream;

  Stream<UserCancelJobRequestResponse> get usercanceljobrequest =>
      _usercanceljob.stream;

  Stream<UserWorkingHoursResponse> get userworkinghours =>
      _userworkinghours.stream;

  fetchUserViewRequest(String token) async {
    _visibility.add(true);
    UserViewRequestResponse list =
        await _repo.fetchUserViewRequestResponse(token);
    if (!_viewrequest.isClosed) {
      _viewrequest.sink.add(list);
      _visibility.add(false);
    }
  }

  userCancelJob(String token, String job_request_row_id) async {
    _visibility.add(true);
    UserCancelJobRequestResponse list =
        await _repo.cancelJobRequest(token, job_request_row_id);
    if (!_usercanceljob.isClosed) {
      _visibility.add(false);
      _usercanceljob.sink.add(list);
    }
  }

  fetchUserWorkingHours(String token, String shift_id, String start_time,
      String end_time, String working_hours) async {
    _visibility.add(true);
    UserWorkingHoursResponse list = await _repo.AddUserWorking(
        token, shift_id, start_time, end_time, working_hours);
    if (!_userworkinghours.isClosed) {
      _visibility.add(false);
      _userworkinghours.sink.add(list);
    }
  }

  dispose() {
    _viewrequest.close();
    _usercanceljob.close();
    _userworkinghours.close();
  }
}

final confirmBloc = ShiftConfirmedBloc();
